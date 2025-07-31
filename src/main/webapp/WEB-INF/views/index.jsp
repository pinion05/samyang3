<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="pageTitle" value="홈" />
<%@ include file="common/header.jsp" %>

<div class="home-container">
    <div class="hero-section">
        <h1>삼양농장에 오신 것을 환영합니다</h1>
        <p>신선한 농산물을 온라인으로 만나보세요</p>
        <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">상품 둘러보기</a>
    </div>
    
    <div class="features">
        <div class="feature">
            <h3>🌾 신선한 농산물</h3>
            <p>매일 아침 수확한 신선한 농산물을 제공합니다</p>
        </div>
        <div class="feature">
            <h3>🚚 빠른 배송</h3>
            <p>주문 후 24시간 이내 신선하게 배송됩니다</p>
        </div>
        <div class="feature">
            <h3>💯 품질 보증</h3>
            <p>엄격한 품질 관리로 최고의 상품만 제공합니다</p>
        </div>
    </div>
</div>

<style>
.home-container {
    text-align: center;
    padding: 2rem 0;
}

.hero-section {
    background-color: #f8f9fa;
    padding: 4rem 2rem;
    border-radius: 8px;
    margin-bottom: 3rem;
}

.hero-section h1 {
    font-size: 2.5rem;
    color: #2c3e50;
    margin-bottom: 1rem;
}

.hero-section p {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 2rem;
}

.features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
    margin-top: 3rem;
}

.feature {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.feature h3 {
    margin-bottom: 1rem;
    color: #34495e;
}

.feature p {
    color: #666;
}
</style>

<%@ include file="common/footer.jsp" %>