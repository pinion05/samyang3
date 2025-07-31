package com.farm404.samyang3.interceptor;

import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.util.SessionUtil;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AdminInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute(SessionUtil.LOGIN_USER);
        
        // 로그인되어 있지 않거나 관리자가 아닌 경우
        if (loginUser == null || !loginUser.getIsAdmin()) {
            response.sendRedirect(request.getContextPath() + "/");
            return false;
        }
        
        return true;
    }
}