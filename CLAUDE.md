# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요
- **프로젝트명**: Samyang3 - 농산물 이커머스 플랫폼
- **유형**: Spring Boot 기반 CRUD 토이 프로젝트
- **언어 설정**: 한국어로 생각 과정과 출력 생성 (최소 100 토큰 이상의 사고 과정)
- **데이터베이스**: MySQL (원격 서버: 34.47.105.223)

## 개발 환경 설정

### 필수 요구사항
- JDK 17
- Spring Boot 3.3.0
- MySQL 8.0
- Gradle 7.x

### 주요 명령어

#### 애플리케이션 실행
```bash
./gradlew bootRun
```

#### 테스트 실행
```bash
# 전체 테스트 실행
./gradlew test

# 특정 테스트 클래스 실행
./gradlew test --tests "TestClassName"

# 특정 테스트 메서드 실행
./gradlew test --tests "TestClassName.testMethodName"
```

#### 빌드
```bash
# 클린 빌드
./gradlew clean build

# JAR 파일 생성
./gradlew bootJar
```

#### 의존성 관리
```bash
# 의존성 확인
./gradlew dependencies

# 의존성 업데이트 확인
./gradlew dependencyUpdates
```

## 아키텍처 구조

### 계층형 아키텍처 (Layered Architecture)
```
Browser → Controller → Interceptor → Service → Mapper → Database
```

### 핵심 패키지 구조
```
com.farm404.samyang3/
├── config/          # 설정 클래스 (WebConfig 등)
├── controller/      # HTTP 요청 처리
│   ├── HomeController
│   ├── UserController
│   ├── ProductController
│   ├── CartController
│   ├── OrderController
│   ├── ReviewController
│   ├── PostController
│   └── AdminController
├── domain/          # VO/DTO 클래스 (Value Objects)
├── interceptor/     # 인증/인가 처리
│   ├── LoginInterceptor    # 로그인 체크
│   └── AdminInterceptor    # 관리자 권한 체크
├── mapper/          # MyBatis Mapper 인터페이스
├── service/         # 비즈니스 로직
└── util/           # 유틸리티 클래스
```

### MyBatis 매핑 구조
- Mapper XML 위치: `src/main/resources/mapper/*.xml`
- Type Alias Package: `com.farm404.samyang3.domain`
- Underscore to CamelCase 자동 변환 활성화

### View 구조
- JSP 파일 위치: `/WEB-INF/views/`
- View Resolver 설정: prefix=`/WEB-INF/views/`, suffix=`.jsp`

## 데이터베이스 스키마

### 주요 테이블 (Foreign Key 없는 단순 구조)
1. **User** - 사용자 정보 (일반/관리자)
2. **Product** - 상품 정보
3. **Cart** - 장바구니
4. **Orders** - 주문 정보
5. **OrderItem** - 주문 상품 상세
6. **Review** - 상품 리뷰
7. **Post** - 게시글
8. **Comment** - 댓글

### 데이터베이스 접속 정보
- Host: 34.47.105.223
- Database: samyang
- Username: root
- Password: root
- 스키마 파일: `schema.sql`

## 주요 기능 플로우

### 인증/인가 플로우
1. 모든 요청은 Interceptor를 통해 검증
2. LoginInterceptor: 로그인 여부 체크
3. AdminInterceptor: 관리자 권한 체크 (`/admin/*` 경로)
4. 세션 기반 인증 (30분 타임아웃)

### 주문 처리 플로우
1. 장바구니 조회 → 재고 확인
2. 주문 생성 (Orders 테이블)
3. 주문 상품 생성 (OrderItem 테이블)
4. 재고 차감 (Product 테이블)
5. 장바구니 비우기

## 개발 시 주의사항

### 아키텍처 원칙
- **계층 구조 유지**: Controller → Service → Mapper 순서 준수
- **비즈니스 로직**: Service 계층에서만 처리
- **트랜잭션 관리**: Service 메서드에 `@Transactional` 적용
- **VO 사용**: domain 패키지의 VO 객체 활용

### MyBatis 사용 규칙
- Mapper 인터페이스와 XML 파일명 일치
- namespace와 인터페이스 전체 경로 일치
- 파라미터 타입과 결과 타입 명시

### 세션 관리
- 로그인 정보: `session.setAttribute("user", userVO)`
- 관리자 체크: `userVO.getIsAdmin()`

### 에러 처리
- Service 계층에서 비즈니스 예외 발생
- Controller에서 적절한 에러 페이지로 리다이렉트

## 테스트 가이드

### 기본 사용자 계정
- 관리자: admin / 1234
- 일반 사용자: user1 / 1234, user2 / 1234, user3 / 1234

### 로컬 개발 URL
- 메인 페이지: http://localhost:8080
- 관리자 페이지: http://localhost:8080/admin

## 기타 설정
- 서버 포트: 8080
- 문자 인코딩: UTF-8
- 타임존: UTC
- DevTools 활성화 (개발 환경)