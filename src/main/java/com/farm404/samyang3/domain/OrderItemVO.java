package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class OrderItemVO {
    private Integer orderItemID;
    private Integer orderID;
    private Integer productID;
    private String productName;
    private Integer quantity;
    private Integer price;
    private LocalDateTime createdAt;
}