<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="${post.title}" />
<%@ include file="../common/header.jsp" %>

<div class="post-detail-container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <div class="post-detail">
        <div class="post-header">
            <div class="post-info">
                <span class="category-label">${post.category}</span>
                <h1>${post.title}</h1>
                <div class="post-meta">
                    <span class="author">${post.username}</span>
                    <span class="date">${post.createdAt}</span>
                    <span class="views">조회 ${post.viewCount}</span>
                </div>
            </div>
            <div class="post-actions">
                <c:if test="${sessionScope.loginUser.userID eq post.userID}">
                    <a href="${pageContext.request.contextPath}/post/edit/${post.postID}" class="btn btn-secondary btn-sm">수정</a>
                </c:if>
                <c:if test="${sessionScope.loginUser.userID eq post.userID or sessionScope.loginUser.isAdmin}">
                    <form action="${pageContext.request.contextPath}/post/delete/${post.postID}" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('게시글을 삭제하시겠습니까?');">삭제</button>
                    </form>
                </c:if>
                <a href="${pageContext.request.contextPath}/post" class="btn btn-secondary btn-sm">목록</a>
            </div>
        </div>
        
        <div class="post-content">
            ${post.content}
        </div>
    </div>
    
    <!-- 댓글 섹션 -->
    <div class="comment-section" id="comments">
        <h3>댓글 <span class="comment-count">(${comments.size()})</span></h3>
        
        <!-- 댓글 작성 폼 -->
        <c:if test="${sessionScope.loginUser != null}">
            <form action="${pageContext.request.contextPath}/post/${post.postID}/comment" method="post" class="comment-form">
                <textarea name="content" rows="3" placeholder="댓글을 작성해주세요." required></textarea>
                <button type="submit" class="btn btn-primary">댓글 작성</button>
            </form>
        </c:if>
        
        <!-- 댓글 목록 -->
        <div class="comment-list">
            <c:forEach items="${comments}" var="comment">
                <div class="comment-item">
                    <div class="comment-header">
                        <span class="comment-author">${comment.username}</span>
                        <span class="comment-date">${comment.createdAt}</span>
                        <c:if test="${sessionScope.loginUser.userID eq comment.userID or sessionScope.loginUser.isAdmin}">
                            <form action="${pageContext.request.contextPath}/post/comment/delete/${comment.commentID}" method="post" class="comment-delete">
                                <input type="hidden" name="postId" value="${post.postID}">
                                <button type="submit" class="btn-delete" onclick="return confirm('댓글을 삭제하시겠습니까?');">삭제</button>
                            </form>
                        </c:if>
                    </div>
                    <div class="comment-content">
                        ${comment.content}
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty comments}">
            <div class="no-comments">
                <p>첫 번째 댓글을 작성해보세요.</p>
            </div>
        </c:if>
    </div>
</div>

<style>
.post-detail-container {
    max-width: 900px;
    margin: 0 auto;
}

.post-detail {
    background: white;
    border-radius: 8px;
    padding: 2rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.post-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 2rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid #e0e0e0;
}

.post-info h1 {
    margin: 0.5rem 0 1rem 0;
    font-size: 2rem;
    color: #2c3e50;
}

.category-label {
    display: inline-block;
    padding: 0.25rem 0.75rem;
    background-color: #3498db;
    color: white;
    border-radius: 4px;
    font-size: 0.875rem;
}

.post-meta {
    display: flex;
    gap: 1rem;
    color: #666;
    font-size: 0.9rem;
}

.post-meta span::after {
    content: '•';
    margin-left: 1rem;
}

.post-meta span:last-child::after {
    content: '';
}

.post-actions {
    display: flex;
    gap: 0.5rem;
}

.post-content {
    line-height: 1.8;
    color: #333;
    white-space: pre-wrap;
    word-wrap: break-word;
}

.comment-section {
    background: white;
    border-radius: 8px;
    padding: 2rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.comment-section h3 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

.comment-count {
    color: #3498db;
}

.comment-form {
    margin-bottom: 2rem;
    padding: 1.5rem;
    background-color: #f8f9fa;
    border-radius: 8px;
}

.comment-form textarea {
    width: 100%;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    resize: vertical;
    margin-bottom: 1rem;
    font-family: inherit;
}

.comment-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.comment-item {
    padding: 1.5rem;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    background-color: #f8f9fa;
}

.comment-header {
    display: flex;
    align-items: center;
    margin-bottom: 0.75rem;
}

.comment-author {
    font-weight: bold;
    color: #34495e;
}

.comment-date {
    margin-left: 1rem;
    color: #666;
    font-size: 0.875rem;
}

.comment-delete {
    margin-left: auto;
    display: inline;
}

.btn-delete {
    background: none;
    border: none;
    color: #e74c3c;
    cursor: pointer;
    font-size: 0.875rem;
    padding: 0.25rem 0.5rem;
}

.btn-delete:hover {
    text-decoration: underline;
}

.comment-content {
    color: #333;
    line-height: 1.6;
    white-space: pre-wrap;
    word-wrap: break-word;
}

.no-comments {
    text-align: center;
    padding: 2rem;
    color: #666;
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
}

@media (max-width: 768px) {
    .post-header {
        flex-direction: column;
        gap: 1rem;
    }
    
    .post-actions {
        width: 100%;
        justify-content: flex-end;
    }
    
    .post-info h1 {
        font-size: 1.5rem;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>