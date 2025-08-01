package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.CartVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * 장바구니 매퍼
 */
@Mapper
public interface CartMapper {
    // 사용자의 장바구니 목록
    List<CartVO> selectByUserId(Integer userID);
    
    // 장바구니에 상품 추가
    int insertCart(CartVO cart);
    
    // 장바구니 수량 변경
    int updateQuantity(@Param("cartID") Integer cartID, @Param("quantity") Integer quantity);
    
    // 장바구니 삭제
    int deleteCart(Integer cartID);
    
    // 사용자의 장바구니 전체 삭제
    int deleteAllByUserId(Integer userID);
    
    /* 장바구니에 같은 상품이 있는지 확인... 중복방지용 */
    CartVO selectByUserIdAndProductId(@Param("userID") Integer userID, @Param("productID") Integer productID);
    
    // 장바구니 상품 개수
    int countByUserId(Integer userID);
    
    // 장바구니 단건 조회
    CartVO selectById(Integer cartID);
}