package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 리뷰VO임
 */
@Data
public class ReviewVO {
    private Integer reviewID;
    private Integer userID;
    private Integer productID;
    private String username;  /* 유저네임은 왜 여기있지 */
    private Integer rating;
    private String title;
    private String content;
    private LocalDateTime createdAt;
}