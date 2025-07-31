package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.CommentVO;
import com.farm404.samyang3.mapper.CommentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

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
    
    // 댓글 작성
    public boolean addComment(CommentVO comment) {
        try {
            return commentMapper.insertComment(comment) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 댓글 삭제
    public boolean deleteComment(Long commentId) {
        try {
            return commentMapper.deleteComment(commentId.intValue()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 사용자별 댓글 목록
    public List<CommentVO> getCommentsByUser(Integer userId) {
        return commentMapper.selectByUserId(userId);
    }
}