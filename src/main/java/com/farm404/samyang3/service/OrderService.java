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
    
    /**
     * 주문 생성하는 메소드... 트랜잭션 걸어놨음
     */
    @Transactional(rollbackFor = Exception.class)
    public Long createOrder(OrderVO order, List<CartVO> cartItems) {
        try {
            if (cartItems.isEmpty()) {
                throw new Exception("장바구니가 비어있습니다.");
            }
            
            // 1. 주문 생성
            if (orderMapper.insertOrder(order) <= 0) {
                throw new Exception("주문 생성에 실패했습니다.");
            }
            
            // 2. 주문 상품 생성
            for (CartVO cart : cartItems) {
                // 재고 차감하고
                if (productMapper.updateStock(cart.getProductID(), cart.getQuantity()) <= 0) {
                    throw new Exception("재고가 부족합니다: " + cart.getProductName());
                }
                
                /* 주문 상품 만들어서 저장 */
                OrderItemVO orderItem = new OrderItemVO();
                orderItem.setOrderID(order.getOrderID());
                orderItem.setProductID(cart.getProductID());
                orderItem.setProductName(cart.getProductName());
                orderItem.setQuantity(cart.getQuantity());
                orderItem.setPrice(cart.getPrice());
                
                if (orderItemMapper.insertOrderItem(orderItem) <= 0) {
                    throw new Exception("주문 상품 생성에 실패했습니다.");
                }
            }
            
            return order.getOrderID().longValue();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // 사용자의 주문 목록
    public List<OrderVO> getUserOrders(Integer userID) {
        return orderMapper.selectByUserId(userID);
    }
    
    // 주문 상세 조회
    public OrderVO getOrderById(Long orderID) {
        return orderMapper.selectById(orderID.intValue());
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
    
    // 주문 취소
    public boolean cancelOrder(Long orderID) {
        return orderMapper.updateStatus(orderID.intValue(), "주문취소") > 0;
    }
    
    // 주문 개수
    public int getOrderCount() {
        return orderMapper.countOrders();
    }
    
    // 대기중인 주문 개수
    public int getPendingOrderCount() {
        return orderMapper.countPendingOrders();
    }
    
    // 최근 주문 목록
    public List<OrderVO> getRecentOrders(int limit) {
        return orderMapper.selectRecentOrders(limit);
    }
    
    // 상태별 주문 목록
    public List<OrderVO> getOrdersByStatus(String status) {
        return orderMapper.selectByStatus(status);
    }
    
    // 월별 통계 (추후 구현)
    public List<Object> getMonthlyStatistics() {
        return new ArrayList<>();
    }
}