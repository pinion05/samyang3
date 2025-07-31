<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>통계 - 관리자</title>
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
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .stat-card h3 {
            margin-top: 0;
            color: #333;
        }
        .big-number {
            font-size: 48px;
            font-weight: bold;
            color: #007bff;
            margin: 20px 0;
        }
        .category-stats {
            margin-top: 20px;
        }
        .category-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        .top-products {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .product-rank {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .rank-number {
            font-size: 24px;
            font-weight: bold;
            color: #666;
            margin-right: 20px;
            width: 30px;
        }
        .product-info {
            flex: 1;
        }
        .product-info .name {
            font-weight: bold;
        }
        .product-info .category {
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container">
        <h1>통계</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/users">회원 관리</a></li>
                <li><a href="/admin/products">상품 관리</a></li>
                <li><a href="/admin/orders">주문 관리</a></li>
                <li><a href="/admin/posts">게시글 관리</a></li>
                <li><a href="/admin/statistics" class="active">통계</a></li>
            </ul>
        </nav>
        
        <div class="stats-grid">
            <div class="stat-card">
                <h3>전체 회원 수</h3>
                <div class="big-number">${userCount}</div>
                <p>가입한 전체 회원 수</p>
            </div>
            
            <div class="stat-card">
                <h3>전체 상품 수</h3>
                <div class="big-number">${productCount}</div>
                <p>등록된 전체 상품 수</p>
                
                <div class="category-stats">
                    <h4>카테고리별 상품</h4>
                    <c:forEach items="${categoryStats}" var="cat">
                        <div class="category-item">
                            <span>${cat.category}</span>
                            <span>${cat.count}개</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
            
            <div class="stat-card">
                <h3>전체 주문 수</h3>
                <div class="big-number">${orderCount}</div>
                <p>누적 주문 건수</p>
                
                <div class="category-stats">
                    <h4>주문 상태별 현황</h4>
                    <div class="category-item">
                        <span>주문접수</span>
                        <span>${pendingOrderCount}건</span>
                    </div>
                    <div class="category-item">
                        <span>배송중</span>
                        <span>${shippingCount}건</span>
                    </div>
                    <div class="category-item">
                        <span>배송완료</span>
                        <span>${completedCount}건</span>
                    </div>
                </div>
            </div>
            
            <div class="stat-card">
                <h3>총 매출액</h3>
                <div class="big-number">
                    <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>원
                </div>
                <p>전체 기간 매출액</p>
            </div>
        </div>
        
        <div class="top-products">
            <h3>인기 상품 TOP 5</h3>
            <c:forEach items="${topProducts}" var="product" varStatus="status">
                <div class="product-rank">
                    <div class="rank-number">${status.index + 1}</div>
                    <div class="product-info">
                        <div class="name">${product.productName}</div>
                        <div class="category">${product.category}</div>
                    </div>
                    <div class="price">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/>원
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>