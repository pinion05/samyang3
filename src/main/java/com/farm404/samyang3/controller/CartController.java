package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.CartVO;
import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.service.CartService;
import com.farm404.samyang3.service.ProductService;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {
    
    @Autowired
    private CartService cartService;
    
    @Autowired
    private ProductService productService;
    
    // 장바구니 목록
    @GetMapping
    public String list(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        List<CartVO> cartItems = cartService.getCartItems(loginUser.getUserID());
        int totalAmount = cartService.calculateTotalAmount(cartItems);
        
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalAmount", totalAmount);
        
        return "cart/list";
    }
    
    // 장바구니 담기
    @PostMapping("/add")
    public String add(@RequestParam Long productId,
                     @RequestParam(defaultValue = "1") Integer quantity,
                     HttpSession session,
                     RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        // 재고 확인
        if (!productService.checkStock(productId.intValue(), quantity)) {
            redirectAttributes.addFlashAttribute("error", "재고가 부족합니다.");
            return "redirect:/product/" + productId;
        }
        
        CartVO cart = new CartVO();
        cart.setUserID(loginUser.getUserID());
        cart.setProductID(productId.intValue());
        cart.setQuantity(quantity);
        
        if (cartService.addToCart(cart)) {
            // 세션의 장바구니 개수 업데이트
            int cartCount = cartService.getCartCount(loginUser.getUserID());
            session.setAttribute(SessionUtil.CART_COUNT, cartCount);
            
            redirectAttributes.addFlashAttribute("success", "장바구니에 담았습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "장바구니 담기에 실패했습니다.");
        }
        
        return "redirect:/product/" + productId;
    }
    
    // 수량 변경
    @PostMapping("/update")
    public String update(@RequestParam Long cartId,
                        @RequestParam Integer quantity,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        CartVO cart = cartService.getCartById(cartId);
        
        if (cart == null || !cart.getUserID().equals(loginUser.getUserID())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/cart";
        }
        
        // 재고 확인
        if (!productService.checkStock(cart.getProductID(), quantity)) {
            redirectAttributes.addFlashAttribute("error", "재고가 부족합니다.");
            return "redirect:/cart";
        }
        
        cart.setQuantity(quantity);
        
        if (cartService.updateCart(cart)) {
            redirectAttributes.addFlashAttribute("success", "수량을 변경했습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "수량 변경에 실패했습니다.");
        }
        
        return "redirect:/cart";
    }
    
    // 장바구니에서 삭제
    @PostMapping("/delete")
    public String delete(@RequestParam Long cartId,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        CartVO cart = cartService.getCartById(cartId);
        
        if (cart == null || !cart.getUserID().equals(loginUser.getUserID())) {
            redirectAttributes.addFlashAttribute("error", "잘못된 요청입니다.");
            return "redirect:/cart";
        }
        
        if (cartService.deleteFromCart(cartId.intValue())) {
            // 세션의 장바구니 개수 업데이트
            int cartCount = cartService.getCartCount(loginUser.getUserID());
            session.setAttribute(SessionUtil.CART_COUNT, cartCount);
            
            redirectAttributes.addFlashAttribute("success", "장바구니에서 삭제했습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "삭제에 실패했습니다.");
        }
        
        return "redirect:/cart";
    }
    
    // 선택 항목 삭제
    @PostMapping("/delete-selected")
    public String deleteSelected(@RequestParam(value = "cartIds", required = false) List<Long> cartIds,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        if (loginUser == null) {
            return "redirect:/login";
        }
        
        if (cartIds == null || cartIds.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "선택된 상품이 없습니다.");
            return "redirect:/cart";
        }
        
        int deletedCount = 0;
        for (Long cartId : cartIds) {
            CartVO cart = cartService.getCartById(cartId);
            if (cart != null && cart.getUserID().equals(loginUser.getUserID())) {
                if (cartService.deleteFromCart(cartId.intValue())) {
                    deletedCount++;
                }
            }
        }
        
        // 세션의 장바구니 개수 업데이트
        int cartCount = cartService.getCartCount(loginUser.getUserID());
        session.setAttribute(SessionUtil.CART_COUNT, cartCount);
        
        if (deletedCount > 0) {
            redirectAttributes.addFlashAttribute("success", deletedCount + "개 상품을 삭제했습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "삭제에 실패했습니다.");
        }
        
        return "redirect:/cart";
    }
}