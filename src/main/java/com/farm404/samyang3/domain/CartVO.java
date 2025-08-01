package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

// 장바구니 vo
@Data
public class CartVO {
    private Integer cartID;
    private Integer userID;
    private Integer productID;
    private Integer quantity;
    private LocalDateTime createdAt;
    
    // 조인 없이 사용하기 위한 추가 필드... 이게 맞나
    private String productName;
    private Integer price;
    private String imageUrl;
}