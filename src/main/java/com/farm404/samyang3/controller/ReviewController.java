package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.OrderVO;
import com.farm404.samyang3.domain.ReviewVO;
import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.service.OrderService;
import com.farm404.samyang3.service.ReviewService;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

/* 리뷰 컨트롤러... 리뷰 CRUD 처리 */
@Controller
@RequestMapping("/review")
public class ReviewController {
    
    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private OrderService orderService;
    
    // 내가 쓴 리뷰 목록
    @GetMapping("/my")
    public String myReviews(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        List<ReviewVO> reviews = reviewService.getReviewsByUser(loginUser.getUserID().longValue());
        model.addAttribute("reviews", reviews);
        
        return "review/my";
    }
    
    /** 리뷰 작성 폼 (주문 완료 후)
     * 주문한 상품에 대해서만 리뷰 쓸수있음
     */
    @GetMapping("/write/{orderId}")
    public String writeForm(@PathVariable Long orderId,
                          HttpSession session,
                          Model model) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        // 주문 확인
        OrderVO order = orderService.getOrderById(orderId);
        
        if (order == null || !order.getUserID().equals(loginUser.getUserID())) {
            return "redirect:/order/list";
        }
        
        /* 배송완료 상태인지 확인 (여기서는 주문완료 상태에서도 리뷰 작성 가능하도록)... 이거 맞나? */
        if (!"주문완료".equals(order.getOrderStatus()) && !"배송완료".equals(order.getOrderStatus())) {
            return "redirect:/order/list";
        }
        
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderService.getOrderItems(order.getOrderID()));
        
        return "review/write";
    }
    
    // 리뷰 작성 처리
    @PostMapping("/write")
    public String write(@RequestParam Long orderId,
                       @RequestParam Long productId,
                       @RequestParam Integer rating,
                       @RequestParam String title,
                       @RequestParam String comment,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        ReviewVO review = new ReviewVO();
        review.setUserID(loginUser.getUserID());
        review.setProductID(productId.intValue());
        // review doesn't have orderID in the VO... 왜 없지??
        review.setUsername(loginUser.getUsername());
        review.setRating(rating);
        review.setTitle(title);
        review.setContent(comment);
        
        if (reviewService.addReview(review)) {
            redirectAttributes.addFlashAttribute("success", "리뷰가 등록되었습니다.");
            return "redirect:/product/" + productId;
        } else {
            redirectAttributes.addFlashAttribute("error", "이미 리뷰를 작성한 주문입니다.");
            return "redirect:/order/detail/" + orderId;
        }
    }
    
    // 리뷰 수정 폼
    @GetMapping("/edit/{reviewId}")
    public String editForm(@PathVariable Long reviewId,
                         HttpSession session,
                         Model model) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        ReviewVO review = reviewService.getReviewById(reviewId);
        
        if (review == null || !review.getUserID().equals(loginUser.getUserID())) {
            return "redirect:/review/my";
        }
        
        model.addAttribute("review", review);
        
        return "review/edit";
    }
    
    /* 리뷰 수정 처리 */
    @PostMapping("/edit/{reviewId}")
    public String edit(@PathVariable Long reviewId,
                      @RequestParam Integer rating,
                      @RequestParam String comment,
                      HttpSession session,
                      RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        ReviewVO review = reviewService.getReviewById(reviewId);
        
        if (review == null || !review.getUserID().equals(loginUser.getUserID())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/review/my";
        }
        
        review.setRating(rating);
        review.setContent(comment);
        
        if (reviewService.updateReview(review)) {
            redirectAttributes.addFlashAttribute("success", "리뷰가 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "리뷰 수정에 실패했습니다.");
        }
        
        return "redirect:/review/my";
    }
    
    // 리뷰 삭제... delete 매핑인데 PostMapping 써도 되나
    @PostMapping("/delete/{reviewId}")
    public String delete(@PathVariable Long reviewId,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        if (reviewService.deleteReview(reviewId, loginUser.getUserID().longValue())) {
            redirectAttributes.addFlashAttribute("success", "리뷰가 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "리뷰 삭제에 실패했습니다.");
        }
        
        return "redirect:/review/my";
    }
}