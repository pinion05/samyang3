package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class PostVO {
    private Integer postID;
    private Integer userID;
    private String username;
    private String title;
    private String content;
    private String category;
    private Integer viewCount;
    private LocalDateTime createdAt;
}