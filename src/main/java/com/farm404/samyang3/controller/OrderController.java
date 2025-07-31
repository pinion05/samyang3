package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.*;
import com.farm404.samyang3.service.*;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ProductService productService;
    
    @Autowired
    private OrderItemService orderItemService;
    
    // 주문 페이지 (장바구니에서 이동)
    @GetMapping("/checkout")
    public String checkout(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        // 장바구니 상품 목록
        List<CartVO> cartItems = cartService.getCartItems(loginUser.getUserID());
        
        if (cartItems.isEmpty()) {
            return "redirect:/cart";
        }
        
        // 사용자 정보 (배송지 정보)
        UserVO user = userService.getUserById(loginUser.getUserID());
        
        // 주문 금액 계산
        int totalAmount = cartService.calculateTotalAmount(cartItems);
        int shippingFee = totalAmount >= 30000 ? 0 : 3000;
        int finalAmount = totalAmount + shippingFee;
        
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("finalAmount", finalAmount);
        
        return "order/checkout";
    }
    
    // 주문 처리
    @PostMapping("/place")
    public String placeOrder(@RequestParam String shippingAddress,
                           @RequestParam String paymentMethod,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        // 장바구니 상품 목록
        List<CartVO> cartItems = cartService.getCartItems(loginUser.getUserID());
        
        if (cartItems.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "장바구니가 비어있습니다.");
            return "redirect:/cart";
        }
        
        // 재고 확인
        for (CartVO item : cartItems) {
            if (!productService.checkStock(item.getProductID(), item.getQuantity())) {
                redirectAttributes.addFlashAttribute("error", item.getProductName() + "의 재고가 부족합니다.");
                return "redirect:/cart";
            }
        }
        
        // 주문 생성
        OrderVO order = new OrderVO();
        order.setUserID(loginUser.getUserID());
        order.setUserName(loginUser.getFullName());
        order.setTotalAmount(cartService.calculateTotalAmount(cartItems));
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setOrderStatus("주문완료");
        
        // 주문 처리 (트랜잭션)
        Long orderId = orderService.createOrder(order, cartItems);
        
        if (orderId != null) {
            // 장바구니 비우기
            cartService.clearCart(loginUser.getUserID());
            
            // 세션의 장바구니 개수 업데이트
            session.setAttribute(SessionUtil.CART_COUNT, 0);
            
            redirectAttributes.addFlashAttribute("success", "주문이 완료되었습니다.");
            return "redirect:/order/complete/" + orderId;
        } else {
            redirectAttributes.addFlashAttribute("error", "주문 처리 중 오류가 발생했습니다.");
            return "redirect:/cart";
        }
    }
    
    // 주문 완료 페이지
    @GetMapping("/complete/{orderId}")
    public String orderComplete(@PathVariable Long orderId,
                              HttpSession session,
                              Model model) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        OrderVO order = orderService.getOrderById(orderId);
        
        if (order == null || !order.getUserID().equals(loginUser.getUserID())) {
            return "redirect:/";
        }
        
        List<OrderItemVO> orderItems = orderItemService.getOrderItems(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);
        
        return "order/complete";
    }
    
    // 주문 목록
    @GetMapping("/list")
    public String orderList(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        List<OrderVO> orders = orderService.getUserOrders(loginUser.getUserID());
        model.addAttribute("orders", orders);
        
        return "order/list";
    }
    
    // 주문 상세
    @GetMapping("/detail/{orderId}")
    public String orderDetail(@PathVariable Long orderId,
                            HttpSession session,
                            Model model) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        OrderVO order = orderService.getOrderById(orderId);
        
        if (order == null || !order.getUserID().equals(loginUser.getUserID())) {
            return "redirect:/order/list";
        }
        
        List<OrderItemVO> orderItems = orderItemService.getOrderItems(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("orderItems", orderItems);
        
        return "order/detail";
    }
    
    // 주문 취소 (주문완료 상태에서만 가능)
    @PostMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable Long orderId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        OrderVO order = orderService.getOrderById(orderId);
        
        if (order == null || !order.getUserID().equals(loginUser.getUserID())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/order/list";
        }
        
        if (!"주문완료".equals(order.getOrderStatus())) {
            redirectAttributes.addFlashAttribute("error", "주문완료 상태에서만 취소가 가능합니다.");
            return "redirect:/order/detail/" + orderId;
        }
        
        if (orderService.cancelOrder(orderId)) {
            redirectAttributes.addFlashAttribute("success", "주문이 취소되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "주문 취소에 실패했습니다.");
        }
        
        return "redirect:/order/detail/" + orderId;
    }
}