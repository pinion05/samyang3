package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.ProductVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/* 상품 매퍼 인터페이스... MyBatis로 구현 */
@Mapper
public interface ProductMapper {
    // 전체 상품 목록
    List<ProductVO> selectAllProducts();
    
    // 카테고리별 상품 목록
    List<ProductVO> selectByCategory(String category);
    
    // 상품 상세 조회
    ProductVO selectById(Integer productID);
    
    // 상품 등록 (관리자)
    int insertProduct(ProductVO product);
    
    // 상품 수정 (관리자)
    int updateProduct(ProductVO product);
    
    // 상품 삭제 (관리자)
    int deleteProduct(Integer productID);
    
    /** 재고 차감
     * quantity만큼 차감함
     */
    int updateStock(@Param("productID") Integer productID, @Param("quantity") Integer quantity);
    
    // 카테고리 목록
    List<String> selectCategories();
    
    // 상품 검색
    List<ProductVO> searchProducts(String keyword);
    
    // 상품 개수
    int countProducts();
    
    // 상위 상품 목록... 베스트셀러인데 구현 안됨ㅋ
    List<ProductVO> selectTopProducts(int limit);
}