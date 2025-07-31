<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 관리 - 관리자</title>
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
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-box input {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .product-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        .product-table th,
        .product-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .product-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .product-table tr:hover {
            background: #f8f9fa;
        }
        .product-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }
        .stock-low {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container">
        <h1>상품 관리</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/users">회원 관리</a></li>
                <li><a href="/admin/products" class="active">상품 관리</a></li>
                <li><a href="/admin/orders">주문 관리</a></li>
                <li><a href="/admin/posts">게시글 관리</a></li>
                <li><a href="/admin/statistics">통계</a></li>
            </ul>
        </nav>
        
        <div class="action-bar">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="상품 검색 (상품명, 카테고리)" onkeyup="filterProducts()">
            </div>
            <a href="/products/new" class="btn btn-primary">새 상품 등록</a>
        </div>
        
        <table class="product-table">
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>ID</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>가격</th>
                    <th>재고</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>
                            <c:if test="${not empty product.imageURL}">
                                <img src="${product.imageURL}" alt="${product.productName}" class="product-image">
                            </c:if>
                            <c:if test="${empty product.imageURL}">
                                <div style="width:50px;height:50px;background:#ddd;border-radius:4px;"></div>
                            </c:if>
                        </td>
                        <td>${product.productID}</td>
                        <td>${product.productName}</td>
                        <td>${product.category}</td>
                        <td><fmt:formatNumber value="${product.price}" pattern="#,###"/>원</td>
                        <td class="${product.stock < 10 ? 'stock-low' : ''}">
                            ${product.stock}
                        </td>
                        <td>
                            <a href="/products/${product.productID}" class="btn btn-sm">보기</a>
                            <a href="/products/${product.productID}/edit" class="btn btn-sm">수정</a>
                            <form action="/products/${product.productID}/delete" method="post" style="display:inline;"
                                  onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                <button type="submit" class="btn btn-sm btn-danger">삭제</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script>
    function filterProducts() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.querySelector('.product-table');
        const rows = table.querySelectorAll('tbody tr');
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            row.style.display = text.includes(filter) ? '' : 'none';
        });
    }
    </script>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>