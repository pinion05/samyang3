package com.farm404.samyang3.service;

import com.farm404.samyang3.domain.UserVO;
import com.farm404.samyang3.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class UserService {
    
    @Autowired
    private UserMapper userMapper;
    
    /* 회원가입하는 메서드 */
    public boolean register(UserVO user) {
        // 아이디 중복 체크
        if (userMapper.selectByUsername(user.getUsername()) != null) {
            return false;
        }
        
        // 이메일 중복 체크
        if (userMapper.selectByEmail(user.getEmail()) != null) {
            return false;
        }
        
        // 일반 사용자로 설정
        user.setIsAdmin(false);
        
        // 회원 정보 저장
        return userMapper.insertUser(user) > 0;
    }
    
    // 로그인
    public UserVO login(String username, String password) {
        UserVO user = userMapper.selectByUsername(username);
        
        //사용자가 존재하고 비밀번호가 일치하는 경우... 암호화 안함ㅋㅋ
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        
        return null;
    }
    
    // 사용자 정보 조회
    public UserVO getUserById(Integer userID) {
        return userMapper.selectById(userID);
    }
    
    // 회원 정보 수정
    public boolean updateUser(UserVO user) {
        return userMapper.updateUser(user) > 0;
    }
    
    // 비밀번호 변경
    public boolean updatePassword(Integer userID, String newPassword) {
        return userMapper.updatePassword(userID, newPassword) > 0;
    }
    
    // 아이디 중복 체크
    public boolean checkUsername(String username) {
        return userMapper.selectByUsername(username) == null;
    }
    
    // 이메일 중복 체크
    public boolean checkEmail(String email) {
        return userMapper.selectByEmail(email) == null;
    }
    
    // 전체 사용자 목록
    public List<UserVO> getAllUsers() {
        return userMapper.selectAllUsers();
    }
    
    /**
     * 사용자 수 세는거
     */
    public int getUserCount() {
        return userMapper.countUsers();
    }
    
    // 관리자 권한 토글
    public boolean toggleAdminStatus(Integer userId) {
        UserVO user = userMapper.selectById(userId);
        if (user != null) {
            return userMapper.updateAdminStatus(userId, !user.getIsAdmin()) > 0;  //이거 맞나??
        }
        return false;
    }
}