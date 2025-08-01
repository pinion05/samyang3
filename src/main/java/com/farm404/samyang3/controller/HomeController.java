package com.farm404.samyang3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 홈 컨트롤러
@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home() {
        return "index";  /* 메인페이지임 index.jsp 보여줌 */
    }
}