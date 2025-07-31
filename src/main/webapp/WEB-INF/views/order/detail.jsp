<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="주문 상세" />
<%@ include file="../common/header.jsp" %>

<div class="order-detail-container">
    <div class="detail-header">
        <h2>주문 상세</h2>
        <a href="${pageContext.request.contextPath}/order/list" class="btn btn-secondary">목록으로</a>
    </div>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <div class="order-detail">
        <div class="section">
            <h3>주문 정보</h3>
            <div class="info-grid">
                <div class="info-row">
                    <span class="label">주문번호</span>
                    <span class="value">${order.orderID}</span>
                </div>
                <div class="info-row">
                    <span class="label">주문일시</span>
                    <span class="value"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                </div>
                <div class="info-row">
                    <span class="label">주문상태</span>
                    <span class="value">
                        <span class="status-badge ${order.orderStatus eq '주문완료' ? 'status-success' : order.orderStatus eq '주문취소' ? 'status-danger' : 'status-info'}">
                            ${order.orderStatus}
                        </span>
                    </span>
                </div>
                <div class="info-row">
                    <span class="label">주문자</span>
                    <span class="value">${order.userName}</span>
                </div>
                <div class="info-row">
                    <span class="label">배송지</span>
                    <span class="value">${order.shippingAddress}</span>
                </div>
                <div class="info-row">
                    <span class="label">결제수단</span>
                    <span class="value">${order.paymentMethod}</span>
                </div>
            </div>
        </div>
        
        <div class="section">
            <h3>주문 상품</h3>
            <div class="order-items">
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>상품명</th>
                            <th>단가</th>
                            <th>수량</th>
                            <th>금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderItems}" var="item">
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/product/${item.productID}">
                                        ${item.productName}
                                    </a>
                                </td>
                                <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
                                <td>${item.quantity}개</td>
                                <td class="amount"><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>원</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="total-label">총 결제금액</td>
                            <td class="total-amount"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원</td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        
        <c:if test="${order.orderStatus eq '주문완료'}">
            <div class="order-actions">
                <form action="${pageContext.request.contextPath}/order/cancel/${order.orderID}" method="post">
                    <button type="submit" class="btn btn-danger" onclick="return confirm('정말 주문을 취소하시겠습니까?');">주문 취소</button>
                </form>
            </div>
        </c:if>
    </div>
</div>

<style>
.order-detail-container {
    max-width: 900px;
    margin: 0 auto;
}

.detail-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
}

.order-detail {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    padding: 2rem;
}

.section {
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid #e0e0e0;
}

.section:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
}

.section h3 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
}

.info-row {
    display: flex;
    padding: 0.75rem;
    background-color: #f8f9fa;
    border-radius: 4px;
}

.info-row .label {
    flex: 0 0 120px;
    color: #666;
    font-weight: 500;
}

.info-row .value {
    flex: 1;
    color: #333;
}

.status-badge {
    display: inline-block;
    padding: 0.25rem 0.75rem;
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

.items-table {
    width: 100%;
    border-collapse: collapse;
}

.items-table th,
.items-table td {
    padding: 1rem;
    text-align: left;
    border-bottom: 1px solid #e0e0e0;
}

.items-table th {
    background-color: #f8f9fa;
    font-weight: 600;
    color: #34495e;
}

.items-table td a {
    color: #3498db;
    text-decoration: none;
}

.items-table td a:hover {
    text-decoration: underline;
}

.items-table .amount {
    text-align: right;
    font-weight: 500;
}

.items-table tfoot td {
    padding-top: 1.5rem;
    font-weight: bold;
    border-bottom: none;
}

.total-label {
    text-align: right;
    color: #666;
}

.total-amount {
    text-align: right;
    font-size: 1.2rem;
    color: #e74c3c;
}

.order-actions {
    margin-top: 2rem;
    text-align: center;
}

@media (max-width: 768px) {
    .info-grid {
        grid-template-columns: 1fr;
    }
    
    .items-table {
        font-size: 0.9rem;
    }
    
    .items-table th,
    .items-table td {
        padding: 0.5rem;
    }
}
</style>

<%@ include file="../common/footer.jsp" %>