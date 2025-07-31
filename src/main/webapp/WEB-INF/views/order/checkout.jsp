<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="주문하기" />
<%@ include file="../common/header.jsp" %>

<div class="checkout-container">
    <h2>주문하기</h2>
    
    <form action="${pageContext.request.contextPath}/order/place" method="post" id="orderForm">
        <div class="checkout-content">
            <div class="section">
                <h3>주문 상품</h3>
                <div class="order-items">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="order-item">
                            <div class="item-image">
                                <c:choose>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${pageContext.request.contextPath}${item.imageUrl}" alt="${item.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/no-image.png" alt="이미지 없음">
                                    </c:otherwise>
                                </c:choose>
                            </div>
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
            
            <div class="section">
                <h3>배송 정보</h3>
                <div class="form-group">
                    <label for="receiverName">받는 분</label>
                    <input type="text" id="receiverName" value="${user.fullName}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="receiverPhone">연락처</label>
                    <input type="tel" id="receiverPhone" value="${user.phone}" readonly>
                </div>
                
                <div class="form-group">
                    <label for="shippingAddress">배송지 주소</label>
                    <input type="text" id="shippingAddress" name="shippingAddress" value="${user.address}" required>
                </div>
            </div>
            
            <div class="section">
                <h3>결제 수단</h3>
                <div class="payment-methods">
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="신용카드" checked>
                        <span>신용카드</span>
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="계좌이체">
                        <span>계좌이체</span>
                    </label>
                    <label class="payment-method">
                        <input type="radio" name="paymentMethod" value="무통장입금">
                        <span>무통장입금</span>
                    </label>
                </div>
            </div>
            
            <div class="section order-summary">
                <h3>결제 정보</h3>
                <div class="summary-row">
                    <span>상품 금액</span>
                    <span><fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원</span>
                </div>
                <div class="summary-row">
                    <span>배송비</span>
                    <span><fmt:formatNumber value="${shippingFee}" pattern="#,###"/>원</span>
                </div>
                <div class="summary-divider"></div>
                <div class="summary-row total">
                    <span>총 결제금액</span>
                    <span class="total-amount"><fmt:formatNumber value="${finalAmount}" pattern="#,###"/>원</span>
                </div>
            </div>
            
            <div class="checkout-actions">
                <button type="submit" class="btn btn-primary btn-lg">결제하기</button>
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary btn-lg">장바구니로 돌아가기</a>
            </div>
        </div>
    </form>
</div>

<style>
.checkout-container {
    max-width: 800px;
    margin: 0 auto;
}

.checkout-content {
    background: white;
    border-radius: 8px;
    padding: 2rem;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.section {
    margin-bottom: 2rem;
    padding-bottom: 2rem;
    border-bottom: 1px solid #e0e0e0;
}

.section:last-child {
    border-bottom: none;
}

.section h3 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

.order-items {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.order-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem;
    background-color: #f8f9fa;
    border-radius: 4px;
}

.item-image img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 4px;
}

.item-info {
    flex: 1;
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

.payment-methods {
    display: flex;
    gap: 1rem;
}

.payment-method {
    flex: 1;
    display: flex;
    align-items: center;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}

.payment-method:hover {
    background-color: #f8f9fa;
}

.payment-method input[type="radio"] {
    margin-right: 0.5rem;
}

.payment-method input[type="radio"]:checked + span {
    font-weight: bold;
}

.order-summary {
    background-color: #f8f9fa;
    padding: 1.5rem;
    border-radius: 4px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 0.75rem;
}

.summary-divider {
    border-top: 1px solid #ddd;
    margin: 1rem 0;
}

.summary-row.total {
    font-size: 1.2rem;
    font-weight: bold;
}

.total-amount {
    color: #e74c3c;
}

.checkout-actions {
    display: flex;
    gap: 1rem;
    margin-top: 2rem;
    justify-content: center;
}

.btn-lg {
    padding: 1rem 2rem;
    font-size: 1.1rem;
}
</style>

<script>
document.getElementById('orderForm').addEventListener('submit', function(e) {
    if (!document.getElementById('shippingAddress').value.trim()) {
        alert('배송지 주소를 입력해주세요.');
        e.preventDefault();
        return false;
    }
    
    if (!confirm('주문하시겠습니까?')) {
        e.preventDefault();
        return false;
    }
});
</script>

<%@ include file="../common/footer.jsp" %>