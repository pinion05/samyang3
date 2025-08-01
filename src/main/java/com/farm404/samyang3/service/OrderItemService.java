package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.OrderItemVO;
import com.farm404.samyang3.mapper.OrderItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/* 주문상품 서비스... 별로 안씀 */
@Service
@Transactional
public class OrderItemService {
    
    @Autowired
    private OrderItemMapper orderItemMapper;
    
    // 주문 상품 목록 조회
    public List<OrderItemVO> getOrderItems(Long orderId) {
        return orderItemMapper.selectByOrderId(orderId.intValue());
    }
    
    // 주문 상품 추가
    public boolean addOrderItem(OrderItemVO orderItem) {
        return orderItemMapper.insertOrderItem(orderItem) > 0;
    }
    
    /** 주문별 총 금액 계산
     * 배송비는 안들어감 */
    public int calculateOrderTotal(Long orderId) {
        List<OrderItemVO> items = orderItemMapper.selectByOrderId(orderId.intValue());
        int total = 0;
        
        for (OrderItemVO item : items) {
            total += item.getPrice() * item.getQuantity();  // 단가 * 수량
        
        return total;
    }
}