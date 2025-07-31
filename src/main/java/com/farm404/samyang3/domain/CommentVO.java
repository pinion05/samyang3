package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class CommentVO {
    private Integer commentID;
    private Integer postID;
    private Integer userID;
    private String username;
    private String content;
    private LocalDateTime createdAt;
}