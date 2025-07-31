<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="../common/header.jsp" %>

<div class="mypage-container">
    <h2>마이페이지</h2>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <div class="mypage-content">
        <div class="section">
            <h3>회원정보</h3>
            <form action="${pageContext.request.contextPath}/mypage/update" method="post">
                <div class="form-group">
                    <label>아이디</label>
                    <input type="text" value="${user.username}" disabled>
                </div>
                
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" value="${user.email}" required>
                </div>
                
                <div class="form-group">
                    <label for="fullName">이름</label>
                    <input type="text" id="fullName" name="fullName" value="${user.fullName}" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" value="${user.phone}">
                </div>
                
                <div class="form-group">
                    <label for="address">주소</label>
                    <input type="text" id="address" name="address" value="${user.address}">
                </div>
                
                <div class="form-group">
                    <label>가입일</label>
                    <input type="text" value="${user.createdAt}" disabled>
                </div>
                
                <button type="submit" class="btn btn-primary">정보 수정</button>
            </form>
        </div>
        
        <div class="section">
            <h3>나의 활동</h3>
            <div class="activity-links">
                <a href="${pageContext.request.contextPath}/order/list" class="activity-link">
                    <span class="icon">📦</span>
                    <span>주문 내역</span>
                </a>
                <a href="${pageContext.request.contextPath}/review/my" class="activity-link">
                    <span class="icon">✍️</span>
                    <span>내가 쓴 리뷰</span>
                </a>
                <a href="${pageContext.request.contextPath}/post/my" class="activity-link">
                    <span class="icon">📝</span>
                    <span>내가 쓴 글</span>
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>