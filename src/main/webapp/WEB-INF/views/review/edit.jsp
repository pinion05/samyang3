<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="리뷰 수정" />
<%@ include file="../common/header.jsp" %>

<div class="review-edit-container">
    <h2>리뷰 수정</h2>
    
    <div class="product-info">
        <h3>${review.productName}</h3>
    </div>
    
    <form action="${pageContext.request.contextPath}/review/edit/${review.reviewID}" method="post" id="editForm">
        <div class="rating-section">
            <h3>평점</h3>
            <div class="rating-input">
                <c:forEach begin="1" end="5" var="i">
                    <label class="star-label">
                        <input type="radio" name="rating" value="${i}" ${review.rating == i ? 'checked' : ''} required>
                        <span class="star-group">
                            <c:forEach begin="1" end="${i}" var="j">
                                <span class="star">★</span>
                            </c:forEach>
                        </span>
                    </label>
                </c:forEach>
            </div>
        </div>
        
        <div class="comment-section">
            <h3>리뷰 내용</h3>
            <textarea name="comment" rows="5" placeholder="상품에 대한 솔직한 리뷰를 작성해주세요." required>${review.comment}</textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="${pageContext.request.contextPath}/review/my" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<style>
.review-edit-container {
    max-width: 700px;
    margin: 0 auto;
}

.product-info {
    background-color: #f8f9fa;
    padding: 1.5rem;
    border-radius: 8px;
    margin-bottom: 2rem;
    text-align: center;
}

.product-info h3 {
    margin: 0;
    color: #2c3e50;
}

.rating-section,
.comment-section {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
}

.rating-section h3,
.comment-section h3 {
    margin: 0 0 1.5rem 0;
    color: #2c3e50;
    font-size: 1.2rem;
}

.rating-input {
    display: flex;
    gap: 1rem;
}

.star-label {
    cursor: pointer;
}

.star-label input[type="radio"] {
    display: none;
}

.star-group {
    display: inline-block;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    transition: all 0.3s;
}

.star-label:hover .star-group,
.star-label input[type="radio"]:checked ~ .star-group {
    background-color: #fff8dc;
    border-color: #f1c40f;
}

.star-label input[type="radio"]:checked ~ .star-group {
    transform: scale(1.1);
}

.star {
    color: #f1c40f;
    font-size: 1.5rem;
}

.comment-section textarea {
    width: 100%;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    resize: vertical;
    font-family: inherit;
    font-size: 1rem;
}

.form-actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
}
</style>

<script>
// 평점 선택 시 시각적 피드백
document.querySelectorAll('.star-label input[type="radio"]').forEach(input => {
    input.addEventListener('change', function() {
        document.querySelectorAll('.star-label .star-group').forEach(group => {
            group.style.transform = 'scale(1)';
        });
        this.nextElementSibling.style.transform = 'scale(1.1)';
    });
});

// 초기 선택된 평점에 스케일 적용
document.querySelector('.star-label input[type="radio"]:checked').nextElementSibling.style.transform = 'scale(1.1)';

// 폼 제출 시 검증
document.getElementById('editForm').addEventListener('submit', function(e) {
    const comment = document.querySelector('textarea[name="comment"]').value.trim();
    if (comment.length < 10) {
        alert('리뷰 내용을 10자 이상 작성해주세요.');
        e.preventDefault();
        return false;
    }
});
</script>

<%@ include file="../common/footer.jsp" %>