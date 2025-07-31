package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.CartVO;
import com.farm404.samyang3.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class CartService {
    
    @Autowired
    private CartMapper cartMapper;
    
    // 사용자의 장바구니 목록
    public List<CartVO> getCartList(Integer userID) {
        return cartMapper.selectByUserId(userID);
    }
    
    // 장바구니에 상품 추가
    public boolean addToCart(CartVO cart) {
        // 이미 장바구니에 있는 상품인지 확인
        CartVO existingCart = cartMapper.selectByUserIdAndProductId(cart.getUserID(), cart.getProductID());
        
        if (existingCart != null) {
            // 이미 있으면 수량만 증가
            int newQuantity = existingCart.getQuantity() + cart.getQuantity();
            return cartMapper.updateQuantity(existingCart.getCartID(), newQuantity) > 0;
        } else {
            // 없으면 새로 추가
            return cartMapper.insertCart(cart) > 0;
        }
    }
    
    // 장바구니 수량 변경
    public boolean updateQuantity(Integer cartID, Integer quantity) {
        if (quantity <= 0) {
            return false;
        }
        return cartMapper.updateQuantity(cartID, quantity) > 0;
    }
    
    // 장바구니에서 삭제
    public boolean removeFromCart(Integer cartID) {
        return cartMapper.deleteCart(cartID) > 0;
    }
    
    // 사용자의 장바구니 전체 삭제
    public boolean clearCart(Integer userID) {
        return cartMapper.deleteAllByUserId(userID) > 0;
    }
    
    // 장바구니 상품 개수
    public int getCartCount(Integer userID) {
        return cartMapper.countByUserId(userID);
    }
    
    // 장바구니 총 금액 계산
    public int calculateTotalAmount(Integer userID) {
        List<CartVO> cartList = cartMapper.selectByUserId(userID);
        int total = 0;
        
        for (CartVO cart : cartList) {
            total += cart.getPrice() * cart.getQuantity();
        }
        
        return total;
    }
}