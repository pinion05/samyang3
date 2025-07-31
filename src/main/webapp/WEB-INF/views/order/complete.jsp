<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="주문 완료" />
<%@ include file="../common/header.jsp" %>

<div class="complete-container">
    <div class="complete-content">
        <div class="complete-header">
            <div class="check-icon">✓</div>
            <h2>주문이 완료되었습니다</h2>
            <p>주문번호: ${order.orderID}</p>
        </div>
        
        <div class="section">
            <h3>주문 정보</h3>
            <div class="info-row">
                <span>주문일시</span>
                <span><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
            <div class="info-row">
                <span>주문자</span>
                <span>${order.userName}</span>
            </div>
            <div class="info-row">
                <span>배송지</span>
                <span>${order.shippingAddress}</span>
            </div>
            <div class="info-row">
                <span>결제수단</span>
                <span>${order.paymentMethod}</span>
            </div>
            <div class="info-row">
                <span>결제금액</span>
                <span class="total-amount"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원</span>
            </div>
        </div>
        
        <div class="section">
            <h3>주문 상품</h3>
            <div class="order-items">
                <c:forEach items="${orderItems}" var="item">
                    <div class="order-item">
                        <div class="item-info">
                            <h4>${item.productName}</h4>
                            <p><fmt:formatNumber value="${item.price}" pattern="#,###"/>원 × ${item.quantity}개</p>
                        </div>
                        <div class="item-total">
                            <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>원
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        
        <div class="complete-actions">
            <a href="${pageContext.request.contextPath}/order/list" class="btn btn-primary">주문내역 보기</a>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">쇼핑 계속하기</a>
        </div>
    </div>
</div>

<style>
.complete-container {
    max-width: 600px;
    margin: 2rem auto;
}

.complete-content {
    background: white;
    border-radius: 8px;
    padding: 3rem 2rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.complete-header {
    text-align: center;
    margin-bottom: 3rem;
}

.check-icon {
    width: 80px;
    height: 80px;
    background-color: #27ae60;
    color: white;
    font-size: 3rem;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 1rem;
}

.complete-header h2 {
    color: #2c3e50;
    margin-bottom: 0.5rem;
}

.complete-header p {
    color: #666;
    font-size: 1.1rem;
}

.section {
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid #e0e0e0;
}

.section:last-of-type {
    border-bottom: none;
}

.section h3 {
    margin-bottom: 1rem;
    color: #34495e;
}

.info-row {
    display: flex;
    justify-content: space-between;
    padding: 0.5rem 0;
}

.info-row span:first-child {
    color: #666;
}

.total-amount {
    font-weight: bold;
    color: #e74c3c;
}

.order-items {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.order-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    background-color: #f8f9fa;
    border-radius: 4px;
}

.item-info h4 {
    margin: 0 0 0.5rem 0;
    font-size: 1rem;
}

.item-info p {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

.item-total {
    font-weight: bold;
    color: #e74c3c;
}

.complete-actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
    margin-top: 2rem;
}
</style>

<%@ include file="../common/footer.jsp" %>