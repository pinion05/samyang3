package com.farm404.samyang3.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserVO {
    private Integer userID;
    private String username;
    private String password;
    private String email;
    private String fullName;
    private String phone;
    private String address;
    private Boolean isAdmin;
    private LocalDateTime createdAt;
}