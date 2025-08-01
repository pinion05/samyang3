package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

/* 게시글 VO */
@Data
public class PostVO {
    private Integer postID;
    private Integer userID;
    private String username;  // 조인 안쓰려고 추가함
    private String title;
    private String content;
    private String category;  /** 카테고리... enum으로 해야되나 */
    private Integer viewCount;
    private LocalDateTime createdAt;
}