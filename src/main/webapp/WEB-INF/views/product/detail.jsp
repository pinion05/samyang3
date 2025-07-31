<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="${product.productName}" />
<%@ include file="../common/header.jsp" %>

<div class="product-detail-container">
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <div class="product-detail">
        <div class="product-image-section">
            <c:choose>
                <c:when test="${not empty product.imageURL}">
                    <img src="${pageContext.request.contextPath}${product.imageURL}" alt="${product.productName}">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/no-image.png" alt="이미지 없음">
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="product-info-section">
            <h1>${product.productName}</h1>
            <p class="category">${product.category}</p>
            
            <div class="rating-info">
                <span class="stars">★ ${avgRating > 0 ? avgRating : 0}</span>
                <span class="review-count">(리뷰 ${reviewCount}개)</span>
            </div>
            
            <div class="price-section">
                <p class="price"><fmt:formatNumber value="${product.price}" pattern="#,###"/>원</p>
            </div>
            
            <div class="stock-info">
                <c:choose>
                    <c:when test="${product.stock > 0}">
                        <p class="in-stock">재고: ${product.stock}개</p>
                    </c:when>
                    <c:otherwise>
                        <p class="out-of-stock">품절</p>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="description">
                <h3>상품 설명</h3>
                <p>${product.description}</p>
            </div>
            
            <div class="action-buttons">
                <c:if test="${product.stock > 0}">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" class="add-to-cart-form">
                        <input type="hidden" name="productId" value="${product.productID}">
                        <div class="quantity-selector">
                            <label for="quantity">수량:</label>
                            <input type="number" id="quantity" name="quantity" min="1" max="${product.stock}" value="1">
                        </div>
                        <button type="submit" class="btn btn-primary">장바구니 담기</button>
                    </form>
                </c:if>
                
                <c:if test="${sessionScope.loginUser.isAdmin}">
                    <a href="${pageContext.request.contextPath}/product/edit/${product.productID}" class="btn btn-secondary">수정</a>
                    <form action="${pageContext.request.contextPath}/product/delete/${product.productID}" method="post" style="display: inline;">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- 리뷰 섹션 -->
    <div class="review-section">
        <h2>상품 리뷰</h2>
        
        <c:if test="${not empty reviews}">
            <div class="review-list">
                <c:forEach items="${reviews}" var="review">
                    <div class="review-item">
                        <div class="review-header">
                            <span class="reviewer">${review.username}</span>
                            <span class="rating">★ ${review.rating}</span>
                            <span class="date"><fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd"/></span>
                        </div>
                        <div class="review-content">
                            <p>${review.comment}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${empty reviews}">
            <div class="no-reviews">
                <p>아직 리뷰가 없습니다.</p>
            </div>
        </c:if>
    </div>
</div>

<style>
.product-detail-container {
    max-width: 1200px;
    margin: 0 auto;
}

.product-detail {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 3rem;
    margin-bottom: 3rem;
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.product-image-section img {
    width: 100%;
    height: auto;
    border-radius: 8px;
}

.product-info-section h1 {
    font-size: 2rem;
    margin-bottom: 1rem;
    color: #2c3e50;
}

.category {
    color: #7f8c8d;
    font-size: 1rem;
    margin-bottom: 1rem;
}

.rating-info {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 1rem;
}

.stars {
    color: #f1c40f;
    font-size: 1.2rem;
}

.price-section {
    margin: 1.5rem 0;
}

.price {
    font-size: 2rem;
    font-weight: bold;
    color: #e74c3c;
}

.stock-info {
    margin-bottom: 1.5rem;
}

.in-stock {
    color: #27ae60;
    font-weight: bold;
}

.out-of-stock {
    color: #e74c3c;
    font-weight: bold;
}

.description {
    margin: 2rem 0;
}

.description h3 {
    margin-bottom: 1rem;
    color: #34495e;
}

.action-buttons {
    display: flex;
    gap: 1rem;
    align-items: flex-end;
}

.add-to-cart-form {
    display: flex;
    gap: 1rem;
    align-items: flex-end;
}

.quantity-selector {
    display: flex;
    flex-direction: column;
}

.quantity-selector label {
    margin-bottom: 0.5rem;
}

.quantity-selector input {
    width: 80px;
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
}

.review-section {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.review-section h2 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

.review-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.review-item {
    padding: 1.5rem;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.reviewer {
    font-weight: bold;
    color: #34495e;
}

.rating {
    color: #f1c40f;
}

.date {
    color: #7f8c8d;
    font-size: 0.9rem;
}

.review-content p {
    margin: 0;
    color: #555;
}

.no-reviews {
    text-align: center;
    padding: 2rem;
    color: #666;
}

@media (max-width: 768px) {
    .product-detail {
        grid-template-columns: 1fr;
    }
    
    .action-buttons {
        flex-direction: column;
        align-items: stretch;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>