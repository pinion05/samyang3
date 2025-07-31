<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>삼양농장 - ${pageTitle != null ? pageTitle : '이커머스'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="container">
                <div class="nav-left">
                    <a href="${pageContext.request.contextPath}/" class="logo">삼양농장</a>
                    <ul class="nav-menu">
                        <li><a href="${pageContext.request.contextPath}/product">상품목록</a></li>
                        <li><a href="${pageContext.request.contextPath}/post">커뮤니티</a></li>
                    </ul>
                </div>
                <div class="nav-right">
                    <c:choose>
                        <c:when test="${sessionScope.loginUser != null}">
                            <c:if test="${sessionScope.loginUser.isAdmin}">
                                <a href="${pageContext.request.contextPath}/admin" class="nav-link">관리자</a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/cart" class="nav-link">
                                장바구니
                                <c:if test="${sessionScope.cartCount > 0}">
                                    <span class="badge">${sessionScope.cartCount}</span>
                                </c:if>
                            </a>
                            <a href="${pageContext.request.contextPath}/mypage" class="nav-link">${sessionScope.loginUser.fullName}님</a>
                            <a href="${pageContext.request.contextPath}/logout" class="nav-link">로그아웃</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="nav-link">로그인</a>
                            <a href="${pageContext.request.contextPath}/register" class="nav-link">회원가입</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </nav>
    </header>
    <main class="main-content">
        <div class="container">