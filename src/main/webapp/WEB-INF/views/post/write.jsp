<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="게시글 작성" />
<%@ include file="../common/header.jsp" %>

<div class="post-write-container">
    <h2>게시글 작성</h2>
    
    <form action="${pageContext.request.contextPath}/post/write" method="post" id="postForm">
        <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" name="category" required>
                <option value="">카테고리 선택</option>
                <option value="일반">일반</option>
                <option value="공지사항">공지사항</option>
                <option value="질문답변">질문답변</option>
                <option value="팁과노하우">팁과노하우</option>
                <option value="후기">후기</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required>
        </div>
        
        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" name="content" rows="15" required></textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">등록</button>
            <a href="${pageContext.request.contextPath}/post" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<style>
.post-write-container {
    max-width: 800px;
    margin: 0 auto;
}

.post-write-container h2 {
    margin-bottom: 2rem;
    color: #2c3e50;
}

.post-write-container form {
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
document.getElementById('postForm').addEventListener('submit', function(e) {
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