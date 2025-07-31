package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.CartVO;
import com.farm404.samyang3.domain.OrderVO;
import com.farm404.samyang3.domain.OrderItemVO;
import com.farm404.samyang3.mapper.CartMapper;
import com.farm404.samyang3.mapper.OrderMapper;
import com.farm404.samyang3.mapper.OrderItemMapper;
import com.farm404.samyang3.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class OrderService {
    
    @Autowired
    private OrderMapper orderMapper;
    
    @Autowired
    private OrderItemMapper orderItemMapper;
    
    @Autowired
    private CartMapper cartMapper;
    
    @Autowired
    private ProductMapper productMapper;
    
    @Autowired
    private CartService cartService;
    
    // 주문 생성 (장바구니 → 주문)
    @Transactional(rollbackFor = Exception.class)
    public OrderVO createOrder(Integer userID, String shippingName, String shippingPhone, String shippingAddress) throws Exception {
        // 1. 장바구니 조회
        List<CartVO> cartList = cartMapper.selectByUserId(userID);
        if (cartList.isEmpty()) {
            throw new Exception("장바구니가 비어있습니다.");
        }
        
        // 2. 주문 총액 계산
        int totalAmount = cartService.calculateTotalAmount(userID);
        
        // 3. 주문 생성
        OrderVO order = new OrderVO();
        order.setUserID(userID);
        order.setTotalAmount(totalAmount);
        order.setStatus("pending");
        order.setShippingName(shippingName);
        order.setShippingPhone(shippingPhone);
        order.setShippingAddress(shippingAddress);
        
        if (orderMapper.insertOrder(order) <= 0) {
            throw new Exception("주문 생성에 실패했습니다.");
        }
        
        // 4. 주문 상품 생성
        List<OrderItemVO> orderItems = new ArrayList<>();
        for (CartVO cart : cartList) {
            // 재고 확인
            if (productMapper.updateStock(cart.getProductID(), cart.getQuantity()) <= 0) {
                throw new Exception("재고가 부족합니다: " + cart.getProductName());
            }
            
            // 주문 상품 생성
            OrderItemVO orderItem = new OrderItemVO();
            orderItem.setOrderID(order.getOrderID());
            orderItem.setProductID(cart.getProductID());
            orderItem.setProductName(cart.getProductName());
            orderItem.setQuantity(cart.getQuantity());
            orderItem.setPrice(cart.getPrice());
            orderItems.add(orderItem);
        }
        
        // 5. 주문 상품 저장
        if (orderItems.size() > 0) {
            orderItemMapper.insertOrderItems(orderItems);
        }
        
        // 6. 장바구니 비우기
        cartMapper.deleteAllByUserId(userID);
        
        return order;
    }
    
    // 사용자의 주문 목록
    public List<OrderVO> getUserOrders(Integer userID) {
        return orderMapper.selectByUserId(userID);
    }
    
    // 주문 상세 조회
    public OrderVO getOrderDetail(Integer orderID) {
        return orderMapper.selectById(orderID);
    }
    
    // 주문 상품 목록
    public List<OrderItemVO> getOrderItems(Integer orderID) {
        return orderItemMapper.selectByOrderId(orderID);
    }
    
    // 전체 주문 목록 (관리자)
    public List<OrderVO> getAllOrders() {
        return orderMapper.selectAllOrders();
    }
    
    // 주문 상태 변경 (관리자)
    public boolean updateOrderStatus(Integer orderID, String status) {
        return orderMapper.updateStatus(orderID, status) > 0;
    }
    
    // 최근 주문 조회
    public OrderVO getLatestOrder(Integer userID) {
        return orderMapper.selectLatestByUserId(userID);
    }
}