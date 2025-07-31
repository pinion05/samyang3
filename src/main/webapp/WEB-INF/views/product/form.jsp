<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="${product.productID != null ? '상품 수정' : '상품 등록'}" />
<%@ include file="../common/header.jsp" %>

<div class="product-form-container">
    <h2>${product.productID != null ? '상품 수정' : '상품 등록'}</h2>
    
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>
    
    <form action="${pageContext.request.contextPath}/product/${product.productID != null ? 'edit/' : 'add'}${product.productID != null ? product.productID : ''}" 
          method="post" 
          enctype="multipart/form-data"
          class="product-form">
        
        <div class="form-group">
            <label for="productName">상품명</label>
            <input type="text" id="productName" name="productName" value="${product.productName}" required>
        </div>
        
        <div class="form-group">
            <label for="category">카테고리</label>
            <input type="text" id="category" name="category" value="${product.category}" required>
        </div>
        
        <div class="form-group">
            <label for="price">가격</label>
            <input type="number" id="price" name="price" value="${product.price}" min="0" required>
        </div>
        
        <div class="form-group">
            <label for="stock">재고</label>
            <input type="number" id="stock" name="stock" value="${product.stock}" min="0" required>
        </div>
        
        <div class="form-group">
            <label for="description">상품 설명</label>
            <textarea id="description" name="description" rows="5" required>${product.description}</textarea>
        </div>
        
        <div class="form-group">
            <label for="imageFile">상품 이미지</label>
            <input type="file" id="imageFile" name="imageFile" accept="image/*">
            <c:if test="${not empty product.imageURL}">
                <div class="current-image">
                    <p>현재 이미지:</p>
                    <img src="${pageContext.request.contextPath}${product.imageURL}" alt="현재 이미지">
                </div>
            </c:if>
        </div>
        
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">${product.productID != null ? '수정' : '등록'}</button>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>

<style>
.product-form-container {
    max-width: 800px;
    margin: 0 auto;
}

.product-form-container h2 {
    margin-bottom: 2rem;
    color: #2c3e50;
}

.product-form {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: 500;
    color: #34495e;
}

.form-group input[type="text"],
.form-group input[type="number"],
.form-group input[type="file"],
.form-group textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 1rem;
}

.form-group textarea {
    resize: vertical;
}

.current-image {
    margin-top: 1rem;
}

.current-image p {
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
    color: #666;
}

.current-image img {
    max-width: 200px;
    border-radius: 4px;
    border: 1px solid #ddd;
}

.form-actions {
    display: flex;
    gap: 1rem;
    margin-top: 2rem;
}
</style>

<%@ include file="../common/footer.jsp" %>