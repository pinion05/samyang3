package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.CommentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

// 댓글 매퍼
@Mapper
public interface CommentMapper {
    
    // 게시글별 댓글 목록
    List<CommentVO> selectByPostId(@Param("postId") Integer postId);
    
    // 사용자별 댓글 목록
    List<CommentVO> selectByUserId(@Param("userId") Integer userId);
    
    // 댓글 단건 조회
    CommentVO selectById(@Param("commentId") Integer commentId);
    
    /* 댓글 작성 */
    int insertComment(CommentVO comment);
    
    /** 댓글 삭제
     * 수정은 없음... 삭제만 가능 */
    int deleteComment(@Param("commentId") Integer commentId);
}