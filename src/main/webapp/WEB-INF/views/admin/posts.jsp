<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 관리 - 관리자</title>
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
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .post-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        .post-table th,
        .post-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .post-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .post-table tr:hover {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <%@ include file="../common/header.jsp" %>
    
    <div class="container">
        <h1>게시글 관리</h1>
        
        <nav class="admin-menu">
            <ul>
                <li><a href="/admin">대시보드</a></li>
                <li><a href="/admin/users">회원 관리</a></li>
                <li><a href="/admin/products">상품 관리</a></li>
                <li><a href="/admin/orders">주문 관리</a></li>
                <li><a href="/admin/posts" class="active">게시글 관리</a></li>
                <li><a href="/admin/statistics">통계</a></li>
            </ul>
        </nav>
        
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="게시글 검색 (제목, 작성자)" onkeyup="filterPosts()">
        </div>
        
        <table class="post-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>카테고리</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${posts}" var="post">
                    <tr>
                        <td>${post.postID}</td>
                        <td>${post.category}</td>
                        <td>${post.title}</td>
                        <td>${post.userName}</td>
                        <td>${post.createdAt.toLocalDate()}</td>
                        <td>${post.viewCount}</td>
                        <td>
                            <a href="/community/posts/${post.postID}" class="btn btn-sm">보기</a>
                            <form action="/admin/posts/${post.postID}/delete" method="post" style="display:inline;"
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
    function filterPosts() {
        const input = document.getElementById('searchInput');
        const filter = input.value.toLowerCase();
        const table = document.querySelector('.post-table');
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