package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.PostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/** 게시판 매퍼
 * 게시판 CRUD
 */
@Mapper
public interface PostMapper {
    
    // 전체 게시글 목록
    List<PostVO> selectAllPosts();
    
    // 카테고리별 게시글 목록
    List<PostVO> selectByCategory(@Param("category") String category);
    
    // 사용자별 게시글 목록
    List<PostVO> selectByUserId(@Param("userId") Integer userId);
    
    /* 게시글 검색... 제목이랑 내용에서 검색 */
    List<PostVO> searchPosts(@Param("keyword") String keyword);
    
    // 게시글 상세 조회
    PostVO selectById(@Param("postId") Integer postId);
    
    // 게시글 작성
    int insertPost(PostVO post);
    
    // 게시글 수정
    int updatePost(PostVO post);
    
    // 게시글 삭제
    int deletePost(@Param("postId") Integer postId);
    
    // 조회수 증가
    int increaseViewCount(@Param("postId") Integer postId);  //+1 해줌
}