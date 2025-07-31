package com.farm404.samyang3.interceptor;

import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class LoginInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        // 로그인되어 있지 않은 경우
        if (loginUser == null) {
            // 원래 요청 URL 저장 (로그인 후 리다이렉트용)
            String originalUrl = request.getRequestURL().toString();
            String queryString = request.getQueryString();
            if (queryString != null) {
                originalUrl += "?" + queryString;
            }
            session.setAttribute("redirectUrl", originalUrl);
            
            // 로그인 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        
        return true;
    }
}