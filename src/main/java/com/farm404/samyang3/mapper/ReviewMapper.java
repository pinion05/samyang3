package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.ReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ReviewMapper {
    
    // 상품별 리뷰 목록
    List<ReviewVO> selectByProductId(@Param("productId") Long productId);
    
    // 사용자별 리뷰 목록
    List<ReviewVO> selectByUserId(@Param("userId") Long userId);
    
    // 주문별 리뷰 조회 (중복 체크용)
    ReviewVO selectByOrderId(@Param("orderId") Long orderId);
    
    // 리뷰 단건 조회
    ReviewVO selectById(@Param("reviewId") Long reviewId);
    
    // 리뷰 등록
    int insert(ReviewVO review);
    
    // 리뷰 수정
    int update(ReviewVO review);
    
    // 리뷰 삭제
    int delete(@Param("reviewId") Long reviewId);
    
    // 평균 평점
    Double selectAverageRating(@Param("productId") Long productId);
}