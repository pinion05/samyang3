<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리 - 관리자</title>
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
        .user-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        .user-table th,
        .user-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .user-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .user-table tr:hover {
            background: #f8f9fa;
        }
        .admin-badge {
            background: #28a745;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 12px;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container">
        <h1>회원 관리</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/users" class="active">회원 관리</a></li>
                <li><a href="/admin/products">상품 관리</a></li>
                <li><a href="/admin/orders">주문 관리</a></li>
                <li><a href="/admin/posts">게시글 관리</a></li>
                <li><a href="/admin/statistics">통계</a></li>
            </ul>
        </nav>
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="회원 검색 (이름, 이메일, 아이디)" onkeyup="filterUsers()">
        </div>
        
        <table class="user-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>전화번호</th>
                    <th>가입일</th>
                    <th>권한</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.userID}</td>
                        <td>${user.username}</td>
                        <td>${user.fullName}</td>
                        <td>${user.email}</td>
                        <td>${user.phone}</td>
                        <td>${user.createdAt.toLocalDate()}</td>
                        <td>
                            <c:if test="${user.isAdmin}">
                                <span class="admin-badge">관리자</span>
                            </c:if>
                            <c:if test="${!user.isAdmin}">
                                일반회원
                            </c:if>
                        </td>
                        <td>
                            <form action="/admin/users/${user.userID}/toggle-admin" method="post" style="display:inline;">
                                <c:if test="${user.isAdmin}">
                                    <button type="submit" class="btn btn-sm btn-danger" 
                                            onclick="return confirm('관리자 권한을 해제하시겠습니까?')">권한 해제</button>
                                </c:if>
                                <c:if test="${!user.isAdmin}">
                                    <button type="submit" class="btn btn-sm btn-success"
                                            onclick="return confirm('관리자 권한을 부여하시겠습니까?')">권한 부여</button>
                                </c:if>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script>
    function filterUsers() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.querySelector('.user-table');
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