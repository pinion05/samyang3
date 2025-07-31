<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="주문 내역" />
<%@ include file="../common/header.jsp" %>

<div class="order-list-container">
    <h2>주문 내역</h2>
    
    <c:choose>
        <c:when test="${not empty orders}">
            <div class="order-list">
                <c:forEach items="${orders}" var="order">
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-info">
                                <h3>주문번호: ${order.orderID}</h3>
                                <p class="order-date"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></p>
                            </div>
                            <div class="order-status">
                                <span class="status-badge ${order.orderStatus eq '주문완료' ? 'status-success' : order.orderStatus eq '주문취소' ? 'status-danger' : 'status-info'}">
                                    ${order.orderStatus}
                                </span>
                            </div>
                        </div>
                        
                        <div class="order-body">
                            <div class="order-details">
                                <p><strong>배송지:</strong> ${order.shippingAddress}</p>
                                <p><strong>결제수단:</strong> ${order.paymentMethod}</p>
                            </div>
                            <div class="order-amount">
                                <p class="amount-label">결제금액</p>
                                <p class="amount-value"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원</p>
                            </div>
                        </div>
                        
                        <div class="order-footer">
                            <a href="${pageContext.request.contextPath}/order/detail/${order.orderID}" class="btn btn-primary btn-sm">상세보기</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-orders">
                <p>주문 내역이 없습니다.</p>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">쇼핑하러 가기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.order-list-container {
    max-width: 900px;
    margin: 0 auto;
}

.order-list {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.order-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    overflow: hidden;
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.5rem;
    background-color: #f8f9fa;
    border-bottom: 1px solid #e0e0e0;
}

.order-info h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.2rem;
    color: #2c3e50;
}

.order-date {
    margin: 0;
    color: #666;
    font-size: 0.9rem;
}

.status-badge {
    display: inline-block;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    font-weight: bold;
    font-size: 0.9rem;
}

.status-success {
    background-color: #d4edda;
    color: #155724;
}

.status-danger {
    background-color: #f8d7da;
    color: #721c24;
}

.status-info {
    background-color: #d1ecf1;
    color: #0c5460;
}

.order-body {
    display: flex;
    justify-content: space-between;
    padding: 1.5rem;
}

.order-details p {
    margin: 0.5rem 0;
    color: #333;
}

.order-amount {
    text-align: right;
}

.amount-label {
    margin: 0 0 0.5rem 0;
    color: #666;
    font-size: 0.9rem;
}

.amount-value {
    margin: 0;
    font-size: 1.5rem;
    font-weight: bold;
    color: #e74c3c;
}

.order-footer {
    padding: 1rem 1.5rem;
    background-color: #f8f9fa;
    border-top: 1px solid #e0e0e0;
    text-align: right;
}

.empty-orders {
    text-align: center;
    padding: 4rem 0;
}

.empty-orders p {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 2rem;
}

.btn-sm {
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
}

@media (max-width: 768px) {
    .order-body {
        flex-direction: column;
        gap: 1rem;
    }
    
    .order-amount {
        text-align: left;
        padding-top: 1rem;
        border-top: 1px solid #e0e0e0;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>