# 🌱 Samyang3 - 농산물 이커머스 플랫폼

간단한 CRUD 기능을 구현한 농산물 이커머스 토이 프로젝트입니다.

## 📋 목차
- [프로젝트 개요](#프로젝트-개요)
- [기술 스택](#기술-스택)
- [주요 기능](#주요-기능)
- [프로젝트 구조](#프로젝트-구조)
- [실행 방법](#실행-방법)
- [프로젝트 문서](#프로젝트-문서)

## 🎯 프로젝트 개요

Samyang3는 농산물(씨앗, 모종 등)을 판매하는 간단한 이커머스 플랫폼입니다. Spring Boot와 MyBatis를 기반으로 구현되었으며, 기본적인 쇼핑몰 기능과 커뮤니티 기능을 제공합니다.

## 🛠 기술 스택

### Backend
- **Java 17**
- **Spring Boot 3.3.0**
- **MyBatis 3.0.3**
- **MySQL 8.0**

### Frontend
- **JSP / JSTL**
- **HTML5 / CSS3**
- **JavaScript**

### Build Tool
- **Gradle 7.x**

## ✨ 주요 기능

### 사용자 기능
- **회원 관리**: 회원가입, 로그인, 마이페이지
- **상품 브라우징**: 카테고리별 상품 조회, 상품 상세 정보
- **장바구니**: 상품 추가/삭제/수량 변경
- **주문**: 주문 생성, 주문 내역 조회, 배송 정보 입력
- **리뷰**: 상품 리뷰 작성/수정/삭제
- **커뮤니티**: 게시글 작성/조회, 댓글 기능

### 관리자 기능
- **대시보드**: 주요 통계 확인
- **회원 관리**: 회원 목록 조회 및 관리
- **상품 관리**: 상품 등록/수정/삭제
- **주문 관리**: 주문 상태 변경, 배송 관리
- **게시글 관리**: 커뮤니티 게시글 관리

## 📁 프로젝트 구조

```
samyang3/
├── src/
│   ├── main/
│   │   ├── java/com/farm404/samyang3/
│   │   │   ├── config/          # 설정 클래스
│   │   │   ├── controller/      # 컨트롤러
│   │   │   ├── domain/          # VO 클래스
│   │   │   ├── interceptor/     # 인터셉터
│   │   │   ├── mapper/          # MyBatis 매퍼
│   │   │   ├── service/         # 서비스 클래스
│   │   │   └── util/            # 유틸리티
│   │   ├── resources/
│   │   │   ├── mapper/          # MyBatis XML
│   │   │   ├── static/          # 정적 리소스
│   │   │   └── application.properties
│   │   └── webapp/WEB-INF/views/ # JSP 뷰
│   └── test/                    # 테스트 코드
├── docs/                        # 문서 및 다이어그램
├── build.gradle                 # Gradle 빌드 설정
└── schema.sql                   # 데이터베이스 스키마
```

## 🚀 실행 방법

### 사전 요구사항
- JDK 17 이상
- MySQL 8.0 이상
- Gradle 7.x 이상

### 실행 단계

1. **데이터베이스 설정**
   ```sql
   -- schema.sql 파일 실행하여 데이터베이스 및 테이블 생성
   mysql -h localhost -u root -p < schema.sql
   ```

2. **애플리케이션 설정**
   ```properties
   # src/main/resources/application.properties 수정
   spring.datasource.url=jdbc:mysql://localhost:3306/samyang
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   ```

3. **애플리케이션 실행**
   ```bash
   ./gradlew bootRun
   ```

4. **접속**
   - 일반 사용자: http://localhost:8080
   - 관리자: http://localhost:8080/admin
   - 기본 관리자 계정: admin / 1234

## 📚 프로젝트 문서

### 다이어그램
- [Use Case Diagram](docs/use-case-diagram.md) - 시스템의 주요 액터와 유스케이스
- [Class Diagram](docs/class-diagram.md) - 도메인 클래스와 관계
- [Architecture Diagram](docs/architecture-diagram.md) - 시스템 아키텍처
- [Database ERD](docs/database-erd.md) - 데이터베이스 구조

### 프로세스 플로우
- [Process Flows](docs/process-flows.md) - 주요 시스템 처리 흐름
- [Business Processes](docs/business-processes.md) - 비즈니스 프로세스 플로우차트

## 📝 라이센스

이 프로젝트는 학습 목적의 토이 프로젝트입니다.