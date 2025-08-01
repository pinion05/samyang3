package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.*;
import com.farm404.samyang3.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private PostService postService;
    
    /* 관리자 메인화면 보여주기 */
    @GetMapping
    public String dashboard(Model model) {
        // 통계 정보 담아서
        model.addAttribute("userCount", userService.getUserCount());
        model.addAttribute("productCount", productService.getProductCount());
        model.addAttribute("orderCount", orderService.getOrderCount());
        model.addAttribute("pendingOrderCount", orderService.getPendingOrderCount());
        
        // 최근 주문 목록
        model.addAttribute("recentOrders", orderService.getRecentOrders(5));
        
        return "admin/dashboard";
    }
    
    // 사용자 관리
    @GetMapping("/users")
    public String userList(Model model) {
        List<UserVO> users = userService.getAllUsers();
        model.addAttribute("users", users);
        
        return "admin/users";
    }
    
    /**
     * 관리자 권한 토글 기능
     * 일반유저 <-> 관리자
     */
    @PostMapping("/users/{userId}/toggle-admin")
    public String toggleAdmin(@PathVariable Integer userId,
                             RedirectAttributes redirectAttributes) {
        
        if (userService.toggleAdminStatus(userId)) {
            redirectAttributes.addFlashAttribute("success", "관리자 권한이 변경되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "권한 변경에 실패했습니다.");
        }
        
        return "redirect:/admin/users";
    }
    
    // 주문 관리
    @GetMapping("/orders")
    public String orderList(@RequestParam(required = false) String status,
                          Model model) {
        
        List<OrderVO> orders;
        if (status != null && !status.isEmpty()) {
            orders = orderService.getOrdersByStatus(status);
            model.addAttribute("selectedStatus", status);
        } else {
            orders = orderService.getAllOrders();
        }
        
        model.addAttribute("orders", orders);
        model.addAttribute("statuses", List.of("주문완료", "배송준비", "배송중", "배송완료", "주문취소"));
        
        return "admin/orders";
    }
    
    // 주문 상세 조회
    @GetMapping("/orders/{orderId}")
    public String orderDetail(@PathVariable Integer orderId, Model model) {
        OrderVO order = orderService.getOrderById(orderId.longValue());
        if (order == null) {
            return "redirect:/admin/orders";
        }
        
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderService.getOrderItems(orderId));
        
        return "admin/order-detail";
    }
    
    // 주문 상태 변경
    @PostMapping("/orders/{orderId}/update-status")
    public String updateOrderStatus(@PathVariable Integer orderId,
                                  @RequestParam String status,
                                  RedirectAttributes redirectAttributes) {
        
        if (orderService.updateOrderStatus(orderId, status)) {
            redirectAttributes.addFlashAttribute("success", "주문 상태가 변경되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "상태 변경에 실패했습니다.");
        }
        
        return "redirect:/admin/orders";
    }
    
    // 상품 관리 (기존 ProductController 활용)
    @GetMapping("/products")
    public String productList(Model model) {
        List<ProductVO> products = productService.getAllProducts();
        model.addAttribute("products", products);
        
        return "admin/products";
    }
    
    // 게시글 관리
    @GetMapping("/posts")
    public String postList(Model model) {
        List<PostVO> posts = postService.getAllPosts();
        model.addAttribute("posts", posts);
        
        return "admin/posts";
    }
    
    // 통계 페이지
    @GetMapping("/statistics")
    public String statistics(Model model) {
        // 기본 통계
        model.addAttribute("userCount", userService.getUserCount());
        model.addAttribute("productCount", productService.getProductCount());
        model.addAttribute("orderCount", orderService.getOrderCount());
        model.addAttribute("pendingOrderCount", orderService.getPendingOrderCount());
        
        // 추가 통계 (임시 데이터)
        model.addAttribute("shippingCount", 0);
        model.addAttribute("completedCount", 0);
        model.addAttribute("totalRevenue", 0);
        
        // 월별 통계 (추후 구현)
        model.addAttribute("monthlyOrders", orderService.getMonthlyStatistics());
        model.addAttribute("topProducts", productService.getTopSellingProducts(5));
        model.addAttribute("categoryStats", productService.getCategoryStatistics());
        
        return "admin/statistics";
    }
    
    // 게시글 삭제
    @PostMapping("/posts/{postId}/delete")
    public String deletePost(@PathVariable Long postId,
                           RedirectAttributes redirectAttributes) {
        if (postService.deletePost(postId)) {
            redirectAttributes.addFlashAttribute("success", "게시글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "게시글 삭제에 실패했습니다.");
        }
        return "redirect:/admin/posts";
    }
}