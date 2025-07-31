<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="커뮤니티" />
<%@ include file="../common/header.jsp" %>

<div class="post-container">
    <div class="post-header">
        <h2>커뮤니티</h2>
        <c:if test="${sessionScope.loginUser != null}">
            <a href="${pageContext.request.contextPath}/post/write" class="btn btn-primary">글쓰기</a>
        </c:if>
    </div>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <!-- 검색 및 카테고리 필터 -->
    <div class="filter-section">
        <div class="category-filter">
            <a href="${pageContext.request.contextPath}/post" 
               class="category-btn ${empty selectedCategory ? 'active' : ''}">전체</a>
            <c:forEach items="${categories}" var="cat">
                <a href="${pageContext.request.contextPath}/post?category=${cat}" 
                   class="category-btn ${selectedCategory eq cat ? 'active' : ''}">${cat}</a>
            </c:forEach>
        </div>
        
        <form action="${pageContext.request.contextPath}/post" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="제목, 내용, 작성자 검색" value="${keyword}">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>
    
    <!-- 게시글 목록 -->
    <div class="post-list">
        <table class="post-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${posts}" var="post" varStatus="status">
                    <tr>
                        <td>${post.postID}</td>
                        <td><span class="category-label">${post.category}</span></td>
                        <td class="title">
                            <a href="${pageContext.request.contextPath}/post/${post.postID}">
                                ${post.title}
                            </a>
                        </td>
                        <td>${post.username}</td>
                        <td>${post.createdAt.toLocalDate()}</td>
                        <td>${post.viewCount}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <c:if test="${empty posts}">
            <div class="no-data">
                <p>등록된 게시글이 없습니다.</p>
            </div>
        </c:if>
    </div>
</div>

<style>
.post-container {
    max-width: 1200px;
    margin: 0 auto;
}

.post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    padding: 1rem;
    background-color: #f8f9fa;
    border-radius: 8px;
}

.category-filter {
    display: flex;
    gap: 0.5rem;
}

.category-btn {
    padding: 0.5rem 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    background-color: white;
    transition: all 0.3s;
}

.category-btn:hover,
.category-btn.active {
    background-color: #3498db;
    color: white;
    border-color: #3498db;
}

.search-form {
    display: flex;
    gap: 0.5rem;
}

.search-form input {
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 250px;
}

.post-list {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    overflow: hidden;
}

.post-table {
    width: 100%;
    border-collapse: collapse;
}

.post-table th,
.post-table td {
    padding: 1rem;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

.post-table th {
    background-color: #f8f9fa;
    font-weight: 600;
    color: #34495e;
}

.post-table tbody tr:hover {
    background-color: #f8f9fa;
}

.post-table .title {
    max-width: 400px;
}

.post-table .title a {
    color: #2c3e50;
    text-decoration: none;
}

.post-table .title a:hover {
    color: #3498db;
}

.category-label {
    display: inline-block;
    padding: 0.25rem 0.5rem;
    background-color: #e9ecef;
    border-radius: 4px;
    font-size: 0.875rem;
    color: #495057;
}

.no-data {
    text-align: center;
    padding: 4rem 0;
    color: #666;
}

@media (max-width: 768px) {
    .filter-section {
        flex-direction: column;
        gap: 1rem;
    }
    
    .category-filter {
        flex-wrap: wrap;
    }
    
    .search-form input {
        width: 200px;
    }
    
    .post-table {
        font-size: 0.9rem;
    }
    
    .post-table th:nth-child(1),
    .post-table td:nth-child(1),
    .post-table th:nth-child(6),
    .post-table td:nth-child(6) {
        display: none;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>