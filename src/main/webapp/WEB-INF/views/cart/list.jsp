<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="장바구니" />
<%@ include file="../common/header.jsp" %>

<div class="cart-container">
    <h2>장바구니</h2>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <c:choose>
        <c:when test="${not empty cartItems}">
            <form id="cartForm" method="post">
                <div class="cart-header">
                    <label>
                        <input type="checkbox" id="selectAll"> 전체선택
                    </label>
                    <button type="button" class="btn btn-secondary btn-sm" onclick="deleteSelected()">선택삭제</button>
                </div>
                
                <div class="cart-items">
                    <c:forEach items="${cartItems}" var="item">
                        <div class="cart-item">
                            <div class="item-select">
                                <input type="checkbox" name="cartIds" value="${item.cartID}" class="item-checkbox">
                            </div>
                            
                            <div class="item-image">
                                <a href="${pageContext.request.contextPath}/product/${item.productID}">
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${pageContext.request.contextPath}${item.imageUrl}" alt="${item.productName}">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/images/no-image.png" alt="이미지 없음">
                                        </c:otherwise>
                                    </c:choose>
                                </a>
                            </div>
                            
                            <div class="item-info">
                                <h3><a href="${pageContext.request.contextPath}/product/${item.productID}">${item.productName}</a></h3>
                                <p class="price"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</p>
                            </div>
                            
                            <div class="item-quantity">
                                <form action="${pageContext.request.contextPath}/cart/update" method="post" class="quantity-form">
                                    <input type="hidden" name="cartId" value="${item.cartID}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="99" class="quantity-input">
                                    <button type="submit" class="btn btn-sm">변경</button>
                                </form>
                            </div>
                            
                            <div class="item-total">
                                <p class="total-price">
                                    <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>원
                                </p>
                            </div>
                            
                            <div class="item-delete">
                                <form action="${pageContext.request.contextPath}/cart/delete" method="post">
                                    <input type="hidden" name="cartId" value="${item.cartID}">
                                    <button type="submit" class="btn-delete">×</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="cart-summary">
                    <div class="summary-content">
                        <h3>주문 요약</h3>
                        <div class="summary-row">
                            <span>상품 합계</span>
                            <span><fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원</span>
                        </div>
                        <div class="summary-row">
                            <span>배송비</span>
                            <span>${totalAmount >= 30000 ? '무료' : '3,000원'}</span>
                        </div>
                        <div class="summary-divider"></div>
                        <div class="summary-row total">
                            <span>총 결제금액</span>
                            <span class="total-amount">
                                <fmt:formatNumber value="${totalAmount >= 30000 ? totalAmount : totalAmount + 3000}" pattern="#,###"/>원
                            </span>
                        </div>
                        <button type="button" class="btn btn-primary btn-block" onclick="checkout()">주문하기</button>
                    </div>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <div class="empty-cart">
                <p>장바구니가 비어있습니다.</p>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">쇼핑하러 가기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<style>
.cart-container {
    max-width: 1200px;
    margin: 0 auto;
}

.cart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem;
    background-color: #f8f9fa;
    border-radius: 8px;
    margin-bottom: 1rem;
}

.cart-items {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.cart-item {
    display: grid;
    grid-template-columns: 40px 100px 1fr 150px 150px 40px;
    align-items: center;
    padding: 1.5rem;
    border-bottom: 1px solid #e0e0e0;
    gap: 1rem;
}

.cart-item:last-child {
    border-bottom: none;
}

.item-select {
    text-align: center;
}

.item-image img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 4px;
}

.item-info h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.1rem;
}

.item-info a {
    color: #2c3e50;
    text-decoration: none;
}

.item-info a:hover {
    color: #3498db;
}

.item-info .price {
    color: #666;
    font-size: 0.95rem;
}

.quantity-form {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.quantity-input {
    width: 60px;
    padding: 0.25rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-align: center;
}

.item-total .total-price {
    font-size: 1.1rem;
    font-weight: bold;
    color: #e74c3c;
    text-align: right;
}

.btn-delete {
    background: none;
    border: none;
    font-size: 1.5rem;
    color: #999;
    cursor: pointer;
    padding: 0;
    width: 30px;
    height: 30px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    transition: all 0.3s;
}

.btn-delete:hover {
    background-color: #f0f0f0;
    color: #e74c3c;
}

.cart-summary {
    position: sticky;
    top: 80px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    padding: 2rem;
    max-width: 400px;
    margin-left: auto;
}

.summary-content h3 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 1rem;
}

.summary-divider {
    border-top: 1px solid #e0e0e0;
    margin: 1.5rem 0;
}

.summary-row.total {
    font-size: 1.2rem;
    font-weight: bold;
}

.total-amount {
    color: #e74c3c;
}

.empty-cart {
    text-align: center;
    padding: 4rem 0;
}

.empty-cart p {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 2rem;
}

.btn-sm {
    padding: 0.25rem 0.75rem;
    font-size: 0.875rem;
}

@media (max-width: 768px) {
    .cart-item {
        grid-template-columns: 40px 80px 1fr;
        grid-template-areas:
            "select image info"
            "select image quantity"
            "select image total"
            "select image delete";
    }
    
    .item-select { grid-area: select; }
    .item-image { grid-area: image; }
    .item-info { grid-area: info; }
    .item-quantity { grid-area: quantity; }
    .item-total { grid-area: total; }
    .item-delete { grid-area: delete; }
}
</style>

<script>
// 전체 선택
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('.item-checkbox');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

// 개별 체크박스 변경 시 전체 선택 체크박스 상태 업데이트
document.querySelectorAll('.item-checkbox').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
        const totalCheckboxes = document.querySelectorAll('.item-checkbox').length;
        const checkedCheckboxes = document.querySelectorAll('.item-checkbox:checked').length;
        document.getElementById('selectAll').checked = totalCheckboxes === checkedCheckboxes;
    });
});

// 선택 삭제
function deleteSelected() {
    const checkedItems = document.querySelectorAll('.item-checkbox:checked');
    if (checkedItems.length === 0) {
        alert('삭제할 상품을 선택해주세요.');
        return;
    }
    
    if (confirm(checkedItems.length + '개 상품을 삭제하시겠습니까?')) {
        document.getElementById('cartForm').action = '${pageContext.request.contextPath}/cart/delete-selected';
        document.getElementById('cartForm').submit();
    }
}

// 주문하기
function checkout() {
    window.location.href = '${pageContext.request.contextPath}/order/checkout';
}
</script>

<%@ include file="../common/footer.jsp" %>