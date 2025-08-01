package com.farm404.samyang3.controller;

import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.service.UserService;
import com.farm404.samyang3.service.CartService;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// 사용자 컨트롤러인데 뭔가 이상함...
@Controller
public class UserController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private CartService cartService;
    
    /* 로긴화면 보여주는거 */
    @GetMapping("/login")
    public String loginForm() {
        return "user/login";
    }
    
    // 로그인 처리
    @PostMapping("/login")
    public String login(@RequestParam String username, 
                       @RequestParam String password,
                       HttpSession session,
                       RedirectAttributes redirectAttributes) {
        
        UserVO user = userService.login(username, password);
        
        if (user != null) {
            // 로그인 성공
            session.setAttribute(SessionUtil.LOGIN_USER, user);
            
            //장바구니 개수 세션에 저장하는데 이거 꼭 여기서 해야하나
            int cartCount = cartService.getCartCount(user.getUserID());
            session.setAttribute(SessionUtil.CART_COUNT, cartCount);
            
            // 원래 가려던 페이지가 있으면 그곳으로, 없으면 메인으로
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                return "redirect:" + redirectUrl;
            }
            
            return "redirect:/";
        } else {
            // 로그인 실패
            redirectAttributes.addFlashAttribute("error", "아이디 또는 비밀번호가 일치하지 않습니다.");
            return "redirect:/login";
        }
    }
    
    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    // 회원가입 페이지
    @GetMapping("/register")
    public String registerForm() {
        return "user/register";
    }
    
    /**
     * 회원가입 처리하는 메소드 만드느라 힘들었음
     * user객체로 받아서 처리함
     */
    @PostMapping("/register")
    public String register(UserVO user, RedirectAttributes redirectAttributes) {
        
        if (userService.register(user)) {
            redirectAttributes.addFlashAttribute("success", "회원가입이 완료되었습니다. 로그인해주세요.");
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "이미 사용중인 아이디 또는 이메일입니다.");
            return "redirect:/register";
        }
    }
    
    // 마이페이지
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        UserVO user = userService.getUserById(loginUser.getUserID());
        model.addAttribute("user", user);
        return "user/mypage";
    }
    
    // 회원정보 수정
    @PostMapping("/mypage/update")
    public String updateUser(UserVO user, HttpSession session, RedirectAttributes redirectAttributes) {
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        user.setUserID(loginUser.getUserID());
        
        if (userService.updateUser(user)) {
            // 세션 정보 업데이트
            loginUser.setEmail(user.getEmail());
            loginUser.setFullName(user.getFullName());
            loginUser.setPhone(user.getPhone());
            loginUser.setAddress(user.getAddress());
            
            redirectAttributes.addFlashAttribute("success", "회원정보가 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("error", "회원정보 수정에 실패했습니다.");
        }
        
        return "redirect:/mypage";
    }
    
    // 아이디 중복 체크 (AJAX)
    @GetMapping("/check/username")
    @ResponseBody
    public boolean checkUsername(@RequestParam String username) {
        return userService.checkUsername(username);  // true면 사용가능한건지 불가능한건지.. 헷갈림
    }
    
    /* 이메일 중복체크임 ajax로 함 */
    @GetMapping("/check/email")
    @ResponseBody
    public boolean checkEmail(@RequestParam String email) {
        return userService.checkEmail(email);
    }
}