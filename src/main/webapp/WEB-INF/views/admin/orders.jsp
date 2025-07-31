<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문 관리 - 관리자</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .admin-menu {
            background: #333;
            padding: 0;
            margin-bottom: 30px;
        }
        .admin-menu ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .admin-menu li {
            flex: 1;
        }
        .admin-menu a {
            display: block;
            padding: 15px;
            text-align: center;
            color: white;
            text-decoration: none;
        }
        .admin-menu a:hover,
        .admin-menu a.active {
            background: #007bff;
        }
        .status-filter {
            margin-bottom: 20px;
        }
        .status-filter a {
            display: inline-block;
            padding: 8px 16px;
            margin-right: 10px;
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 4px;
            text-decoration: none;
            color: #333;
        }
        .status-filter a.active,
        .status-filter a:hover {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        .order-table th,
        .order-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .order-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .order-table tr:hover {
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
        <h1>주문 관리</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/users">회원 관리</a></li>
                <li><a href="/admin/products">상품 관리</a></li>
                <li><a href="/admin/orders" class="active">주문 관리</a></li>
                <li><a href="/admin/posts">게시글 관리</a></li>
                <li><a href="/admin/statistics">통계</a></li>
            </ul>
        </nav>
        
        <div class="status-filter">
            <a href="/admin/orders" class="${empty status ? 'active' : ''}">전체</a>
            <a href="/admin/orders?status=주문접수" class="${status == '주문접수' ? 'active' : ''}">주문접수</a>
            <a href="/admin/orders?status=배송준비" class="${status == '배송준비' ? 'active' : ''}">배송준비</a>
            <a href="/admin/orders?status=배송중" class="${status == '배송중' ? 'active' : ''}">배송중</a>
            <a href="/admin/orders?status=배송완료" class="${status == '배송완료' ? 'active' : ''}">배송완료</a>
            <a href="/admin/orders?status=주문취소" class="${status == '주문취소' ? 'active' : ''}">주문취소</a>
        </div>
        
        <table class="order-table">
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>주문자</th>
                    <th>주문일시</th>
                    <th>총금액</th>
                    <th>결제방법</th>
                    <th>상태</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>#${order.orderID}</td>
                        <td>${order.userName}</td>
                        <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원</td>
                        <td>${order.paymentMethod}</td>
                        <td>
                            <span class="status-badge status-${order.orderStatus}">${order.orderStatus}</span>
                        </td>
                        <td>
                            <a href="/admin/orders/${order.orderID}" class="btn btn-sm">상세</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>