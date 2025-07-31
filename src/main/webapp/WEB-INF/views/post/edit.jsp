<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="게시글 수정" />
<%@ include file="../common/header.jsp" %>

<div class="post-edit-container">
    <h2>게시글 수정</h2>
    
    <form action="${pageContext.request.contextPath}/post/edit/${post.postID}" method="post" id="editForm">
        <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" name="category" required>
                <option value="">카테고리 선택</option>
                <option value="일반" ${post.category eq '일반' ? 'selected' : ''}>일반</option>
                <option value="공지사항" ${post.category eq '공지사항' ? 'selected' : ''}>공지사항</option>
                <option value="질문답변" ${post.category eq '질문답변' ? 'selected' : ''}>질문답변</option>
                <option value="팁과노하우" ${post.category eq '팁과노하우' ? 'selected' : ''}>팁과노하우</option>
                <option value="후기" ${post.category eq '후기' ? 'selected' : ''}>후기</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="${post.title}" required>
        </div>
        
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="15" required>${post.content}</textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">수정</button>
            <a href="${pageContext.request.contextPath}/post/${post.postID}" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<style>
.post-edit-container {
    max-width: 800px;
    margin: 0 auto;
}

.post-edit-container h2 {
    margin-bottom: 2rem;
    color: #2c3e50;
}

.post-edit-container form {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
    color: #34495e;
}

.form-group input[type="text"],
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
    font-family: inherit;
}

.form-group textarea {
    resize: vertical;
}

.form-actions {
    display: flex;
    gap: 1rem;
    margin-top: 2rem;
}
</style>

<script>
document.getElementById('editForm').addEventListener('submit', function(e) {
    const title = document.getElementById('title').value.trim();
    const content = document.getElementById('content').value.trim();
    
    if (title.length < 2) {
        alert('제목을 2자 이상 입력해주세요.');
        e.preventDefault();
        return false;
    }
    
    if (content.length < 10) {
        alert('내용을 10자 이상 입력해주세요.');
        e.preventDefault();
        return false;
    }
});
</script>

<%@ include file="../common/footer.jsp" %>