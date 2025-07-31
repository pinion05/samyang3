package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.OrderVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface OrderMapper {
    // 주문 생성
    int insertOrder(OrderVO order);
    
    // 사용자의 주문 목록
    List<OrderVO> selectByUserId(Integer userID);
    
    // 주문 상세 조회
    OrderVO selectById(Integer orderID);
    
    // 전체 주문 목록 (관리자)
    List<OrderVO> selectAllOrders();
    
    // 주문 상태 변경 (관리자)
    int updateStatus(@Param("orderID") Integer orderID, @Param("status") String status);
    
    // 사용자의 최근 주문 1개
    OrderVO selectLatestByUserId(Integer userID);
}