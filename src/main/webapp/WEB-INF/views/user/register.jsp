<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="회원가입" />
<%@ include file="../common/header.jsp" %>

<div class="auth-container">
    <div class="auth-box">
        <h2>회원가입</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" required>
                <span class="form-text" id="usernameMsg"></span>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
                <span class="form-text">6자 이상 입력해주세요</span>
            </div>
            
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required>
                <span class="form-text" id="passwordMsg"></span>
            </div>
            
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
                <span class="form-text" id="emailMsg"></span>
            </div>
            
            <div class="form-group">
                <label for="fullName">이름</label>
                <input type="text" id="fullName" name="fullName" required>
            </div>
            
            <div class="form-group">
                <label for="phone">전화번호</label>
                <input type="tel" id="phone" name="phone" placeholder="010-0000-0000">
            </div>
            
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address">
            </div>
            
            <button type="submit" class="btn btn-primary btn-block">회원가입</button>
        </form>
        
        <div class="auth-links">
            <p>이미 회원이신가요? <a href="${pageContext.request.contextPath}/login">로그인</a></p>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    let isUsernameValid = false;
    let isEmailValid = false;
    
    // 아이디 중복 체크
    $('#username').on('blur', function() {
        const username = $(this).val();
        if (username.length < 4) {
            $('#usernameMsg').text('아이디는 4자 이상이어야 합니다.').css('color', 'red');
            isUsernameValid = false;
            return;
        }
        
        $.get('${pageContext.request.contextPath}/check/username', {username: username}, function(available) {
            if (available) {
                $('#usernameMsg').text('사용 가능한 아이디입니다.').css('color', 'green');
                isUsernameValid = true;
            } else {
                $('#usernameMsg').text('이미 사용중인 아이디입니다.').css('color', 'red');
                isUsernameValid = false;
            }
        });
    });
    
    // 이메일 중복 체크
    $('#email').on('blur', function() {
        const email = $(this).val();
        if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
            $('#emailMsg').text('올바른 이메일 형식이 아닙니다.').css('color', 'red');
            isEmailValid = false;
            return;
        }
        
        $.get('${pageContext.request.contextPath}/check/email', {email: email}, function(available) {
            if (available) {
                $('#emailMsg').text('사용 가능한 이메일입니다.').css('color', 'green');
                isEmailValid = true;
            } else {
                $('#emailMsg').text('이미 사용중인 이메일입니다.').css('color', 'red');
                isEmailValid = false;
            }
        });
    });
    
    // 비밀번호 확인
    $('#passwordConfirm').on('keyup', function() {
        if ($('#password').val() !== $(this).val()) {
            $('#passwordMsg').text('비밀번호가 일치하지 않습니다.').css('color', 'red');
        } else {
            $('#passwordMsg').text('비밀번호가 일치합니다.').css('color', 'green');
        }
    });
    
    // 폼 제출 검증
    $('#registerForm').on('submit', function(e) {
        if (!isUsernameValid) {
            alert('아이디를 확인해주세요.');
            e.preventDefault();
            return false;
        }
        
        if (!isEmailValid) {
            alert('이메일을 확인해주세요.');
            e.preventDefault();
            return false;
        }
        
        if ($('#password').val() !== $('#passwordConfirm').val()) {
            alert('비밀번호가 일치하지 않습니다.');
            e.preventDefault();
            return false;
        }
        
        if ($('#password').val().length < 6) {
            alert('비밀번호는 6자 이상이어야 합니다.');
            e.preventDefault();
            return false;
        }
    });
});
</script>

<%@ include file="../common/footer.jsp" %>