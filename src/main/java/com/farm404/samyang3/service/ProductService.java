package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.ProductVO;
import com.farm404.samyang3.mapper.ProductMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

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
    public ProductVO getProductById(Integer productID) {
        return productMapper.selectById(productID);
    }
    
    // 카테고리 목록 조회
    public List<String> getCategories() {
        return productMapper.selectCategories();
    }
    
    // 재고 확인
    public boolean checkStock(Integer productID, Integer quantity) {
        ProductVO product = productMapper.selectById(productID);
        return product != null && product.getStock() >= quantity;
    }
    
    // 재고 차감
    public boolean updateStock(Integer productID, Integer quantity) {
        return productMapper.updateStock(productID, quantity) > 0;
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
    public boolean deleteProduct(Integer productID) {
        return productMapper.deleteProduct(productID) > 0;
    }
}