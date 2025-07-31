package com.farm404.samyang3.util;

public class SessionUtil {
    // 세션 키 상수
    public static final String LOGIN_USER = "loginUser";
    public static final String CART_COUNT = "cartCount";
    
    // 로그인 체크가 필요 없는 URL 패턴
    public static final String[] EXCLUDE_PATHS = {
        "/", "/login", "/register", "/product/**", "/static/**", "/css/**", "/js/**"
    };
    
    // 관리자만 접근 가능한 URL 패턴
    public static final String[] ADMIN_PATHS = {
        "/admin/**"
    };
}