package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class OrderVO {
    private Integer orderID;
    private Integer userID;
    private Integer totalAmount;
    private String status;
    private String shippingName;
    private String shippingPhone;
    private String shippingAddress;
    private LocalDateTime createdAt;
    
    // 조인 없이 사용하기 위한 추가 필드
    private String username;
}