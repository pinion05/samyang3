package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 사용자 VO
 * 유저 정보 담는 클래스
 */
@Data
public class UserVO {
    private Integer userID;
    private String username;
    private String password;  // 비밀번호 평문 저장... 보안 신경 안씀
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private Boolean isAdmin;  //관리자인지
    private LocalDateTime createdAt;
}