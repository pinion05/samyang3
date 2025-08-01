package com.farm404.samyang3.config;

import com.farm404.samyang3.interceptor.LoginInterceptor;
import com.farm404.samyang3.interceptor.AdminInterceptor;
import com.farm404.samyang3.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/* 웹MVC 설정... 이거 맞게 한건가 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    
    @Autowired
    private LoginInterceptor loginInterceptor;
    
    @Autowired
    private AdminInterceptor adminInterceptor;
    
    // 인터셉터 등록하는거
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 로그인 인터셉터
        registry.addInterceptor(loginInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns(SessionUtil.EXCLUDE_PATHS)
                .excludePathPatterns("/api/**");  // API는 제외
        
        // 관리자 인터셉터
        registry.addInterceptor(adminInterceptor)
                .addPathPatterns(SessionUtil.ADMIN_PATHS);
    }
    
    /**
     * 정적 리소스 핸들러 추가
     * css, js, 이미지 같은거 매핑해줌.. 이거 없으면 404뜸
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 정적 리소스 매핑
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/", "/static/");
        
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/", "/static/css/");
        
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/", "/static/js/");
        
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/", "/static/images/");
    }
}