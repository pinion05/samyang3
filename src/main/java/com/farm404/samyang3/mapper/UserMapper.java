package com.farm404.samyang3.mapper;

import com.farm404.samyang3.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/* 유저 매퍼 인터페이스 */
@Mapper
public interface UserMapper {
    // 회원가입
    int insertUser(UserVO user);
    
    // 로그인 - username으로 조회
    UserVO selectByUsername(String username);
    
    /* 이메일 중복체크할때 씀 */
    UserVO selectByEmail(String email);
    
    // ID로 사용자 조회
    UserVO selectById(Integer userID);
    
    // 회원 정보 수정
    int updateUser(UserVO user);
    
    // 비밀번호 변경
    int updatePassword(@Param("userID") Integer userID, @Param("password") String password);
    
    // 전체 사용자 목록
    List<UserVO> selectAllUsers();
    
    // 사용자 수 카운트하는거
    int countUsers();
    
    /**
     * 관리자 권한 업데이트
     * @Param 쓰는거 맞나?
     */
    int updateAdminStatus(@Param("userID") Integer userID, @Param("isAdmin") Boolean isAdmin);
}