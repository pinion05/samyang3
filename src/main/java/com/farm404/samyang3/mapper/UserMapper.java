package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    // 회원가입
    int insertUser(UserVO user);
    
    // 로그인 - username으로 조회
    UserVO selectByUsername(String username);
    
    // 이메일 중복 체크
    UserVO selectByEmail(String email);
    
    // ID로 사용자 조회
    UserVO selectById(Integer userID);
    
    // 회원 정보 수정
    int updateUser(UserVO user);
    
    // 비밀번호 변경
    int updatePassword(@Param("userID") Integer userID, @Param("password") String password);
}