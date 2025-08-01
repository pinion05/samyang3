package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.PostVO;
import com.farm404.samyang3.mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;

/* 게시판 서비스 */
@Service
@Transactional
public class PostService {
    
    @Autowired
    private PostMapper postMapper;
    
    // 전체 게시글 목록
    public List<PostVO> getAllPosts() {
        return postMapper.selectAllPosts();
    }
    
    // 카테고리별 게시글 목록
    public List<PostVO> getPostsByCategory(String category) {
        return postMapper.selectByCategory(category);
    }
    
    // 사용자별 게시글 목록
    public List<PostVO> getPostsByUser(Integer userId) {
        return postMapper.selectByUserId(userId);
    }
    
    // 게시글 검색
    public List<PostVO> searchPosts(String keyword) {
        return postMapper.searchPosts(keyword);
    }
    
    // 게시글 상세 조회
    public PostVO getPostById(Long postId) {
        return postMapper.selectById(postId.intValue());
    }
    
    /** 게시글 작성... 실패하면 false */
    public boolean createPost(PostVO post) {
        try {
            return postMapper.insertPost(post) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 게시글 수정
    public boolean updatePost(PostVO post) {
        try {
            return postMapper.updatePost(post) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 게시글 삭제
    public boolean deletePost(Long postId) {
        try {
            return postMapper.deletePost(postId.intValue()) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /* 조회수 증가... 중복조회도 카운트됨ㅋ */
    public void increaseViewCount(Long postId) {
        postMapper.increaseViewCount(postId.intValue());
    }
    
    // 카테고리 목록
    public List<String> getCategories() {
        // 하드코딩된 카테고리 (나중에 DB에서 가져올 수도 있음)... 이거 테이블로 빼야되는거 아님?
        return Arrays.asList("일반", "공지사항", "질문답변", "팁과노하우", "후기");
    }
}