<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드 - Samyang3</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .stat-card h3 {
            margin: 0 0 10px 0;
            color: #666;
            font-size: 14px;
        }
        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
        }
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
        .recent-orders {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
        }
        .recent-orders h2 {
            margin-top: 0;
        }
        .order-table {
            width: 100%;
            border-collapse: collapse;
        }
        .order-table th,
        .order-table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .order-table th {
            background: #e9ecef;
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
        <h1>관리자 대시보드</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin" class="active">대시보드</a></li>
                <li><a href="/admin/users">회원 관리</a></li>
                <li><a href="/admin/products">상품 관리</a></li>
                <li><a href="/admin/orders">주문 관리</a></li>
                <li><a href="/admin/posts">게시글 관리</a></li>
                <li><a href="/admin/statistics">통계</a></li>
            </ul>
        </nav>
        
        <div class="dashboard-stats">
            <div class="stat-card">
                <h3>전체 회원</h3>
                <div class="number">${userCount}</div>
            </div>
            <div class="stat-card">
                <h3>전체 상품</h3>
                <div class="number">${productCount}</div>
            </div>
            <div class="stat-card">
                <h3>전체 주문</h3>
                <div class="number">${orderCount}</div>
            </div>
            <div class="stat-card">
                <h3>대기중인 주문</h3>
                <div class="number">${pendingOrderCount}</div>
            </div>
        </div>
        
        <div class="recent-orders">
            <h2>최근 주문</h2>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>주문자</th>
                        <th>주문일시</th>
                        <th>총금액</th>
                        <th>상태</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${recentOrders}" var="order">
                        <tr>
                            <td>#${order.orderID}</td>
                            <td>${order.userName}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>원</td>
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
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>