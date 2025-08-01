package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class OrderVO {
    private Integer orderID;
    private Integer userID;
    private Integer totalAmount;
    private String orderStatus;
    private String shippingAddress;
    private String paymentMethod;
    private LocalDateTime orderDate;
    
    // 조인 없이 사용하기 위한 추가 필드... DB 정규화 무시ㅋ
    private String userName;
}