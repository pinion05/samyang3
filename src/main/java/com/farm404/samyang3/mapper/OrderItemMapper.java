package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.OrderItemVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

/* 주문상품 매퍼... 별로 기능없음 */
@Mapper
public interface OrderItemMapper {
    // 주문 상품 추가
    int insertOrderItem(OrderItemVO orderItem);
    
    // 주문별 상품 목록
    List<OrderItemVO> selectByOrderId(Integer orderID);
    
    // 여러 주문 상품 한번에 추가... 배치 인서트
    int insertOrderItems(List<OrderItemVO> orderItems);
}