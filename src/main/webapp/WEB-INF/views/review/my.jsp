<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="내가 쓴 리뷰" />
<%@ include file="../common/header.jsp" %>

<div class="my-reviews-container">
    <h2>내가 쓴 리뷰</h2>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <c:choose>
        <c:when test="${not empty reviews}">
            <div class="review-list">
                <c:forEach items="${reviews}" var="review">
                    <div class="review-card">
                        <div class="review-header">
                            <div class="product-info">
                                <h3>
                                    <a href="${pageContext.request.contextPath}/product/${review.productID}">
                                        ${review.productName}
                                    </a>
                                </h3>
                                <div class="rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <span class="star ${i <= review.rating ? 'filled' : ''}">★</span>
                                    </c:forEach>
                                    <span class="rating-text">${review.rating}.0</span>
                                </div>
                            </div>
                            <div class="review-date">
                                <fmt:formatDate value="${review.reviewDate}" pattern="yyyy-MM-dd"/>
                            </div>
                        </div>
                        
                        <div class="review-content">
                            <p>${review.comment}</p>
                        </div>
                        
                        <div class="review-actions">
                            <a href="${pageContext.request.contextPath}/review/edit/${review.reviewID}" class="btn btn-secondary btn-sm">수정</a>
                            <form action="${pageContext.request.contextPath}/review/delete/${review.reviewID}" method="post" style="display: inline;">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('리뷰를 삭제하시겠습니까?');">삭제</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-reviews">
                <p>작성한 리뷰가 없습니다.</p>
                <p>상품을 구매하신 후 리뷰를 작성해보세요.</p>
                <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary">주문내역 보기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.my-reviews-container {
    max-width: 800px;
    margin: 0 auto;
}

.review-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.review-card {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.review-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 1rem;
}

.product-info h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.2rem;
}

.product-info h3 a {
    color: #2c3e50;
    text-decoration: none;
}

.product-info h3 a:hover {
    color: #3498db;
}

.rating {
    display: flex;
    align-items: center;
    gap: 0.25rem;
}

.star {
    color: #ddd;
    font-size: 1.2rem;
}

.star.filled {
    color: #f1c40f;
}

.rating-text {
    margin-left: 0.5rem;
    color: #666;
    font-size: 0.9rem;
}

.review-date {
    color: #666;
    font-size: 0.9rem;
}

.review-content {
    margin-bottom: 1rem;
}

.review-content p {
    margin: 0;
    color: #333;
    line-height: 1.6;
}

.review-actions {
    display: flex;
    gap: 0.5rem;
}

.empty-reviews {
    text-align: center;
    padding: 4rem 0;
}

.empty-reviews p {
    margin: 0.5rem 0;
    color: #666;
    font-size: 1.1rem;
}

.empty-reviews .btn {
    margin-top: 1.5rem;
}

.btn-sm {
    padding: 0.375rem 0.75rem;
    font-size: 0.875rem;
}
</style>

<%@ include file="../common/footer.jsp" %>