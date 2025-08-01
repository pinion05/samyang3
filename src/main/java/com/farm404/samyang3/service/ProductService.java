package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.ProductVO;
import com.farm404.samyang3.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

/* 상품 서비스 클래스 */
@Service
@Transactional
public class ProductService {
    
    @Autowired
    private ProductMapper productMapper;
    
    // 전체 상품 목록
    public List<ProductVO> getAllProducts() {
        return productMapper.selectAllProducts();
    }
    
    // 카테고리별 상품 목록
    public List<ProductVO> getProductsByCategory(String category) {
        return productMapper.selectByCategory(category);
    }
    
    // 상품 상세 조회
    public ProductVO getProductById(Long productID) {
        return productMapper.selectById(productID.intValue());
    }
    
    // 카테고리 목록 조회
    public List<String> getAllCategories() {
        return productMapper.selectCategories();
    }
    
    // 상품 검색
    public List<ProductVO> searchProducts(String keyword) {
        return productMapper.searchProducts(keyword);
    }
    
    /**
     * 재고 확인하는 메소드
     * @param productID 상품아이디
     * @param quantity 수량
     * @return 재고있으면 true
     */
    public boolean checkStock(Integer productID, Integer quantity) {
        ProductVO product = productMapper.selectById(productID);
        return product != null && product.getStock() >= quantity;
    }
    
    // 재고 차감
    public boolean updateStock(Integer productID, Integer quantity) {
        return productMapper.updateStock(productID, quantity) > 0;  //이거 맞나?? 
    }
    
    // 상품 등록 (관리자)
    public boolean addProduct(ProductVO product) {
        return productMapper.insertProduct(product) > 0;
    }
    
    // 상품 수정 (관리자)
    public boolean updateProduct(ProductVO product) {
        return productMapper.updateProduct(product) > 0;
    }
    
    // 상품 삭제 (관리자)
    public boolean deleteProduct(Long productID) {
        return productMapper.deleteProduct(productID.intValue()) > 0;
    }
    
    // 상품 개수
    public int getProductCount() {
        return productMapper.countProducts();
    }
    
    /* 베스트 셀러 상품 가져오기 */
    public List<ProductVO> getTopSellingProducts(int limit) {
        // 추후 판매량 기준으로 구현, 현재는 임시로 최신 상품 반환
        return productMapper.selectTopProducts(limit);
    }
    
    // 카테고리별 통계
    public List<Object> getCategoryStatistics() {
        // 추후 구현
        return new ArrayList<>();
    }
}