package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

/** 주문 상품 VO */
@Data
public class OrderItemVO {
    private Integer orderItemID;
    private Integer orderID;
    private Integer productID;
    private String productName;  //상품명 중복저장... 
    private Integer quantity;
    private Integer price;  /* 주문당시 가격 */
    private LocalDateTime createdAt;
}