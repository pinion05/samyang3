package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.CommentVO;
import com.farm404.samyang3.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

//댓글 서비스인데 별로 기능이 없네
@Service
@Transactional
public class CommentService {
    
    @Autowired
    private CommentMapper commentMapper;
    
    // 게시글별 댓글 목록
    public List<CommentVO> getCommentsByPost(Long postId) {
        return commentMapper.selectByPostId(postId.intValue());
    }
    
    // 댓글 단건 조회
    public CommentVO getCommentById(Long commentId) {
        return commentMapper.selectById(commentId.intValue());
    }
    
    /* 댓글 작성 */
    public boolean addComment(CommentVO comment) {
        try {
            return commentMapper.insertComment(comment) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /** 댓글 삭제
     * 댓글 수정 기능은 없음... 왜 안만들었지
     */
    public boolean deleteComment(Long commentId) {
        try {
            return commentMapper.deleteComment(commentId.intValue()) > 0;
        } catch (Exception e) {
            e.printStackTrace();  // 이거 로그로 바꿔야됨
            return false;
        }
    }
    
    // 사용자별 댓글 목록
    public List<CommentVO> getCommentsByUser(Integer userId) {
        return commentMapper.selectByUserId(userId);
    }
}