package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class ReviewVO {
    private Integer reviewID;
    private Integer userID;
    private Integer productID;
    private String username;
    private Integer rating;
    private String title;
    private String content;
    private LocalDateTime createdAt;
}