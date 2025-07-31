<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 상세 - 관리자</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .order-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .order-info h2 {
            margin-top: 0;
        }
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .info-item {
            padding: 10px 0;
        }
        .info-label {
            font-weight: bold;
            color: #666;
        }
        .status-update {
            background: #e9ecef;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .status-update select {
            padding: 8px;
            margin-right: 10px;
        }
        .order-items {
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
        }
        .item-table {
            width: 100%;
            border-collapse: collapse;
        }
        .item-table th,
        .item-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .item-table th {
            background: #f8f9fa;
        }
        .status-badge {
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
            font-weight: bold;
        }
        .status-주문접수 { background: #17a2b8; color: white; }
        .status-배송준비 { background: #ffc107; color: black; }
        .status-배송중 { background: #28a745; color: white; }
        .status-배송완료 { background: #6c757d; color: white; }
        .status-주문취소 { background: #dc3545; color: white; }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container">
        <h1>주문 상세 정보</h1>
        
        <div class="order-info">
            <h2>주문 정보</h2>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">주문번호:</span> #${order.orderID}
                </div>
                <div class="info-item">
                    <span class="info-label">주문일시:</span> 
                    <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
                <div class="info-item">
                    <span class="info-label">주문자 ID:</span> ${order.userID}
                </div>
                <div class="info-item">
                    <span class="info-label">주문자명:</span> ${order.userName}
                </div>
                <div class="info-item">
                    <span class="info-label">총 금액:</span> 
                    <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원
                </div>
                <div class="info-item">
                    <span class="info-label">결제방법:</span> ${order.paymentMethod}
                </div>
                <div class="info-item">
                    <span class="info-label">현재 상태:</span> 
                    <span class="status-badge status-${order.orderStatus}">${order.orderStatus}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">배송주소:</span> ${order.shippingAddress}
                </div>
            </div>
        </div>
        
        <div class="status-update">
            <h3>주문 상태 변경</h3>
            <form action="/admin/orders/${order.orderID}/update-status" method="post">
                <select name="status">
                    <option value="주문접수" ${order.orderStatus == '주문접수' ? 'selected' : ''}>주문접수</option>
                    <option value="배송준비" ${order.orderStatus == '배송준비' ? 'selected' : ''}>배송준비</option>
                    <option value="배송중" ${order.orderStatus == '배송중' ? 'selected' : ''}>배송중</option>
                    <option value="배송완료" ${order.orderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
                    <option value="주문취소" ${order.orderStatus == '주문취소' ? 'selected' : ''}>주문취소</option>
                </select>
                <button type="submit" class="btn btn-primary">상태 변경</button>
            </form>
        </div>
        
        <div class="order-items">
            <h3>주문 상품</h3>
            <table class="item-table">
                <thead>
                    <tr>
                        <th>상품ID</th>
                        <th>상품명</th>
                        <th>단가</th>
                        <th>수량</th>
                        <th>소계</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orderItems}" var="item">
                        <tr>
                            <td>${item.productID}</td>
                            <td>${item.productName}</td>
                            <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>원</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="text-center" style="margin-top: 30px;">
            <a href="/admin/orders" class="btn btn-secondary">목록으로</a>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>