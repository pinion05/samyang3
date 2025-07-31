package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ProductVO {
    private Integer productID;
    private String productName;
    private String category;
    private String description;
    private Integer price;
    private Integer stock;
    private String imageUrl;
    private LocalDateTime createdAt;
}