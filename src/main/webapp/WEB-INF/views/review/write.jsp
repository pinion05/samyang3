<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="리뷰 작성" />
<%@ include file="../common/header.jsp" %>

<div class="review-write-container">
    <h2>리뷰 작성</h2>
    
    <div class="order-info">
        <p>주문번호: ${order.orderID} | 주문일: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></p>
    </div>
    
    <form action="${pageContext.request.contextPath}/review/write" method="post" id="reviewForm">
        <input type="hidden" name="orderId" value="${order.orderID}">
        
        <div class="product-select">
            <h3>리뷰를 작성할 상품을 선택하세요</h3>
            <div class="product-list">
                <c:forEach items="${orderItems}" var="item">
                    <label class="product-item">
                        <input type="radio" name="productId" value="${item.productID}" required>
                        <div class="product-info">
                            <span class="product-name">${item.productName}</span>
                            <span class="product-price"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원 × ${item.quantity}개</span>
                        </div>
                    </label>
                </c:forEach>
            </div>
        </div>
        
        <div class="rating-section">
            <h3>평점</h3>
            <div class="rating-input">
                <c:forEach begin="1" end="5" var="i">
                    <label class="star-label">
                        <input type="radio" name="rating" value="${i}" ${i == 5 ? 'checked' : ''} required>
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
            <textarea name="comment" rows="5" placeholder="상품에 대한 솔직한 리뷰를 작성해주세요." required></textarea>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">리뷰 등록</button>
            <a href="${pageContext.request.contextPath}/order/detail/${order.orderID}" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<style>
.review-write-container {
    max-width: 700px;
    margin: 0 auto;
}

.order-info {
    background-color: #f8f9fa;
    padding: 1rem;
    border-radius: 4px;
    margin-bottom: 2rem;
    text-align: center;
    color: #666;
}

.product-select,
.rating-section,
.comment-section {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 1.5rem;
}

.product-select h3,
.rating-section h3,
.comment-section h3 {
    margin: 0 0 1.5rem 0;
    color: #2c3e50;
    font-size: 1.2rem;
}

.product-list {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.product-item {
    display: flex;
    align-items: center;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s;
}

.product-item:hover {
    background-color: #f8f9fa;
}

.product-item input[type="radio"] {
    margin-right: 1rem;
}

.product-item input[type="radio"]:checked + .product-info {
    font-weight: bold;
}

.product-info {
    display: flex;
    justify-content: space-between;
    width: 100%;
}

.product-name {
    color: #333;
}

.product-price {
    color: #666;
    font-size: 0.9rem;
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

// 폼 제출 시 검증
document.getElementById('reviewForm').addEventListener('submit', function(e) {
    const productSelected = document.querySelector('input[name="productId"]:checked');
    if (!productSelected) {
        alert('리뷰를 작성할 상품을 선택해주세요.');
        e.preventDefault();
        return false;
    }
    
    const comment = document.querySelector('textarea[name="comment"]').value.trim();
    if (comment.length < 10) {
        alert('리뷰 내용을 10자 이상 작성해주세요.');
        e.preventDefault();
        return false;
    }
});
</script>

<%@ include file="../common/footer.jsp" %>