<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pageTitle" value="상품 목록" />
<%@ include file="../common/header.jsp" %>

<div class="product-container">
    <h2>상품 목록</h2>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    
    <!-- 검색 및 카테고리 필터 -->
    <div class="filter-section">
        <div class="category-filter">
            <a href="${pageContext.request.contextPath}/product" 
               class="category-btn ${empty selectedCategory ? 'active' : ''}">전체</a>
            <c:forEach items="${categories}" var="cat">
                <a href="${pageContext.request.contextPath}/product?category=${cat}" 
                   class="category-btn ${selectedCategory eq cat ? 'active' : ''}">${cat}</a>
            </c:forEach>
        </div>
        
        <form action="${pageContext.request.contextPath}/product" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="상품명, 설명 검색" value="${keyword}">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>
    
    <!-- 관리자 버튼 -->
    <c:if test="${sessionScope.loginUser.isAdmin}">
        <div class="admin-actions">
            <a href="${pageContext.request.contextPath}/product/add" class="btn btn-primary">상품 등록</a>
        </div>
    </c:if>
    
    <!-- 상품 목록 -->
    <div class="product-grid">
        <c:forEach items="${products}" var="product">
            <div class="product-card">
                <a href="${pageContext.request.contextPath}/product/${product.productID}">
                    <div class="product-image">
                        <c:choose>
                            <c:when test="${not empty product.imageURL}">
                                <img src="${pageContext.request.contextPath}${product.imageURL}" alt="${product.productName}">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/images/no-image.png" alt="이미지 없음">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="product-info">
                        <h3>${product.productName}</h3>
                        <p class="category">${product.category}</p>
                        <p class="price"><fmt:formatNumber value="${product.price}" pattern="#,###"/>원</p>
                        <p class="stock">재고: ${product.stock}개</p>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty products}">
        <div class="no-data">
            <p>등록된 상품이 없습니다.</p>
        </div>
    </c:if>
</div>

<style>
.product-container {
    max-width: 1200px;
    margin: 0 auto;
}

.filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 2rem 0;
    padding: 1rem;
    background-color: #f8f9fa;
    border-radius: 8px;
}

.category-filter {
    display: flex;
    gap: 0.5rem;
}

.category-btn {
    padding: 0.5rem 1rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    text-decoration: none;
    color: #333;
    background-color: white;
    transition: all 0.3s;
}

.category-btn:hover,
.category-btn.active {
    background-color: #3498db;
    color: white;
    border-color: #3498db;
}

.search-form {
    display: flex;
    gap: 0.5rem;
}

.search-form input {
    padding: 0.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 250px;
}

.admin-actions {
    margin-bottom: 2rem;
    text-align: right;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 2rem;
}

.product-card {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.15);
}

.product-card a {
    text-decoration: none;
    color: inherit;
}

.product-image {
    width: 100%;
    height: 200px;
    overflow: hidden;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.product-info {
    padding: 1rem;
}

.product-info h3 {
    margin: 0 0 0.5rem 0;
    font-size: 1.1rem;
    color: #2c3e50;
}

.product-info .category {
    color: #7f8c8d;
    font-size: 0.9rem;
    margin: 0.25rem 0;
}

.product-info .price {
    font-size: 1.2rem;
    font-weight: bold;
    color: #e74c3c;
    margin: 0.5rem 0;
}

.product-info .stock {
    color: #27ae60;
    font-size: 0.9rem;
}

.no-data {
    text-align: center;
    padding: 4rem 0;
    color: #666;
}
</style>

<%@ include file="../common/footer.jsp" %>