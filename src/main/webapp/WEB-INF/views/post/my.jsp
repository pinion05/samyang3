<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="내가 쓴 글" />
<%@ include file="../common/header.jsp" %>

<div class="my-posts-container">
    <h2>내가 쓴 글</h2>
    
    <c:choose>
        <c:when test="${not empty posts}">
            <div class="post-list">
                <table class="post-table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>작성일</th>
                            <th>조회</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${posts}" var="post">
                            <tr>
                                <td>${post.postID}</td>
                                <td><span class="category-label">${post.category}</span></td>
                                <td class="title">
                                    <a href="${pageContext.request.contextPath}/post/${post.postID}">
                                        ${post.title}
                                    </a>
                                </td>
                                <td>${post.createdAt.toLocalDate()}</td>
                                <td>${post.viewCount}</td>
                                <td class="actions">
                                    <a href="${pageContext.request.contextPath}/post/edit/${post.postID}" class="btn btn-secondary btn-sm">수정</a>
                                    <form action="${pageContext.request.contextPath}/post/delete/${post.postID}" method="post" style="display: inline;">
                                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('게시글을 삭제하시겠습니까?');">삭제</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-posts">
                <p>작성한 게시글이 없습니다.</p>
                <a href="${pageContext.request.contextPath}/post/write" class="btn btn-primary">첫 게시글 작성하기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.my-posts-container {
    max-width: 1000px;
    margin: 0 auto;
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
    max-width: 350px;
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

.actions {
    white-space: nowrap;
}

.empty-posts {
    text-align: center;
    padding: 4rem 0;
}

.empty-posts p {
    font-size: 1.1rem;
    color: #666;
    margin-bottom: 1.5rem;
}

.btn-sm {
    padding: 0.25rem 0.5rem;
    font-size: 0.875rem;
}

@media (max-width: 768px) {
    .post-table {
        font-size: 0.9rem;
    }
    
    .post-table th:nth-child(1),
    .post-table td:nth-child(1),
    .post-table th:nth-child(5),
    .post-table td:nth-child(5) {
        display: none;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>