package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

// 댓글VO... 대댓글 기능은 없음
@Data
public class CommentVO {
    private Integer commentID;
    private Integer postID;
    private Integer userID;
    private String username;  /* 조인 안쓰려고 */
    private String content;
    private LocalDateTime createdAt;
}