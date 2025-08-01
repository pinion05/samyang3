package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

//상품VO
@Data
public class ProductVO {
    private Integer productID;
    private String productName;
    private String category;
    private String description;
    private Integer price;  /* 가격인데 int로 함 */
    private Integer stock;
    private String imageUrl;
    private LocalDateTime createdAt;
}