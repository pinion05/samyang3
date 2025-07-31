package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.ReviewVO;
import com.farm404.samyang3.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReviewService {
    
    @Autowired
    private ReviewMapper reviewMapper;
    
    // 상품별 리뷰 목록
    public List<ReviewVO> getReviewsByProduct(Long productId) {
        return reviewMapper.selectByProductId(productId);
    }
    
    // 사용자별 리뷰 목록
    public List<ReviewVO> getReviewsByUser(Long userId) {
        return reviewMapper.selectByUserId(userId);
    }
    
    // 리뷰 작성
    @Transactional
    public boolean addReview(ReviewVO review) {
        try {
            // 이미 동일 상품에 리뷰를 작성했는지 확인
            // (실제로는 주문별로 체크해야 하지만 현재 구조상 제한)
            
            return reviewMapper.insert(review) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 리뷰 수정
    @Transactional
    public boolean updateReview(ReviewVO review) {
        try {
            return reviewMapper.update(review) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 리뷰 삭제
    @Transactional
    public boolean deleteReview(Long reviewId, Long userId) {
        try {
            ReviewVO review = reviewMapper.selectById(reviewId);
            if (review != null && review.getUserID().equals(userId)) {
                return reviewMapper.delete(reviewId) > 0;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 평균 평점 계산
    public double getAverageRating(Long productId) {
        Double avg = reviewMapper.selectAverageRating(productId);
        return avg != null ? avg : 0.0;
    }
    
    // 리뷰 단건 조회
    public ReviewVO getReviewById(Long reviewId) {
        return reviewMapper.selectById(reviewId);
    }
}