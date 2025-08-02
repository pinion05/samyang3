# 🌱 Samyang3 - 농산물 이커머스 플랫폼

간단한 CRUD 기능을 구현한 농산물 이커머스 토이 프로젝트입니다.

## 📋 목차
- [프로젝트 개요](#프로젝트-개요)
- [기술 스택](#기술-스택)
- [주요 기능](#주요-기능)
- [Use Case Diagram](#use-case-diagram)
- [Class Diagram](#class-diagram)
- [시스템 아키텍처](#시스템-아키텍처)
- [데이터베이스 구조](#데이터베이스-구조)
- [프로세스 플로우](#프로세스-플로우)
- [프로젝트 구조](#프로젝트-구조)
- [실행 방법](#실행-방법)

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

## 🎭 Use Case Diagram

시스템의 주요 액터(Actor)와 유스케이스(Use Case)를 나타낸 다이어그램입니다.

```mermaid
graph TB
    subgraph "Actors"
        Guest[비회원]
        User[회원]
        Admin[관리자]
    end
    
    subgraph "회원 관리"
        UC1[회원가입]
        UC2[로그인]
        UC3[마이페이지 조회]
        UC4[회원정보 수정]
        UC5[회원 탈퇴]
    end
    
    subgraph "상품 관리"
        UC6[상품 목록 조회]
        UC7[상품 상세 조회]
        UC8[상품 검색]
        UC9[장바구니 담기]
        UC10[장바구니 조회]
        UC11[장바구니 수정/삭제]
    end
    
    subgraph "주문 관리"
        UC12[주문하기]
        UC13[주문 내역 조회]
        UC14[주문 상태 조회]
        UC15[주문 취소]
    end
    
    subgraph "리뷰 관리"
        UC16[리뷰 작성]
        UC17[리뷰 조회]
        UC18[리뷰 수정]
        UC19[리뷰 삭제]
    end
    
    subgraph "커뮤니티"
        UC20[게시글 목록 조회]
        UC21[게시글 상세 조회]
        UC22[게시글 작성]
        UC23[게시글 수정/삭제]
        UC24[댓글 작성]
        UC25[댓글 수정/삭제]
    end
    
    subgraph "관리자 기능"
        UC26[대시보드 조회]
        UC27[회원 관리]
        UC28[상품 등록/수정/삭제]
        UC29[주문 관리]
        UC30[게시글 관리]
    end
    
    %% Guest relationships
    Guest --> UC1
    Guest --> UC2
    Guest --> UC6
    Guest --> UC7
    Guest --> UC8
    Guest --> UC20
    Guest --> UC21
    
    %% User relationships
    User --> UC2
    User --> UC3
    User --> UC4
    User --> UC5
    User --> UC6
    User --> UC7
    User --> UC8
    User --> UC9
    User --> UC10
    User --> UC11
    User --> UC12
    User --> UC13
    User --> UC14
    User --> UC15
    User --> UC16
    User --> UC17
    User --> UC18
    User --> UC19
    User --> UC20
    User --> UC21
    User --> UC22
    User --> UC23
    User --> UC24
    User --> UC25
    
    %% Admin relationships
    Admin --> UC26
    Admin --> UC27
    Admin --> UC28
    Admin --> UC29
    Admin --> UC30
    
    %% Include relationships
    UC12 -.include.-> UC10
    UC16 -.include.-> UC13
```

## 🏛️ Class Diagram

시스템의 주요 도메인 클래스와 그들 간의 관계를 나타낸 다이어그램입니다.

```mermaid
classDiagram
    class User {
        -int userID
        -String username
        -String password
        -String email
        -String fullName
        -String phone
        -String address
        -boolean isAdmin
        -DateTime createdAt
        +login()
        +logout()
        +register()
        +updateProfile()
    }
    
    class Product {
        -int productID
        -String productName
        -String category
        -String description
        -int price
        -int stock
        -String imageUrl
        -DateTime createdAt
        +getDetails()
        +updateStock()
        +checkAvailability()
    }
    
    class Cart {
        -int cartID
        -int userID
        -int productID
        -int quantity
        -DateTime createdAt
        +addItem()
        +removeItem()
        +updateQuantity()
        +clearCart()
    }
    
    class Orders {
        -int orderID
        -int userID
        -int totalAmount
        -String status
        -String shippingName
        -String shippingPhone
        -String shippingAddress
        -DateTime createdAt
        +createOrder()
        +updateStatus()
        +cancelOrder()
        +getOrderDetails()
    }
    
    class OrderItem {
        -int orderItemID
        -int orderID
        -int productID
        -String productName
        -int quantity
        -int price
        -DateTime createdAt
        +calculateSubtotal()
    }
    
    class Review {
        -int reviewID
        -int userID
        -int productID
        -String username
        -int rating
        -String title
        -String content
        -DateTime createdAt
        +createReview()
        +updateReview()
        +deleteReview()
    }
    
    class Post {
        -int postID
        -int userID
        -String username
        -String title
        -String content
        -String category
        -int viewCount
        -DateTime createdAt
        +createPost()
        +updatePost()
        +deletePost()
        +increaseViewCount()
    }
    
    class Comment {
        -int commentID
        -int postID
        -int userID
        -String username
        -String content
        -DateTime createdAt
        +createComment()
        +updateComment()
        +deleteComment()
    }
    
    %% Relationships
    User "1" --> "0..*" Cart : has
    User "1" --> "0..*" Orders : places
    User "1" --> "0..*" Review : writes
    User "1" --> "0..*" Post : creates
    User "1" --> "0..*" Comment : writes
    
    Product "1" --> "0..*" Cart : contained in
    Product "1" --> "0..*" OrderItem : ordered in
    Product "1" --> "0..*" Review : reviewed by
    
    Orders "1" --> "1..*" OrderItem : contains
    Post "1" --> "0..*" Comment : has
    
    Cart "*" --> "1" Product : references
    Cart "*" --> "1" User : belongs to
    OrderItem "*" --> "1" Product : references
    Review "*" --> "1" Product : about
    Review "*" --> "1" User : written by
    Comment "*" --> "1" Post : on
    Comment "*" --> "1" User : written by
```

## 🏗 시스템 아키텍처

프로젝트는 전통적인 MVC 패턴을 따르며, 계층형 아키텍처로 구성되어 있습니다.

### 아키텍처 다이어그램


```mermaid
graph TB
    subgraph "Client Layer"
        Browser[웹 브라우저]
    end
    
    subgraph "Presentation Layer"
        JSP[JSP Views]
        Static[Static Resources<br/>CSS/JS/Images]
    end
    
    subgraph "Controller Layer"
        HC[HomeController]
        UC[UserController]
        PC[ProductController]
        CC[CartController]
        OC[OrderController]
        RC[ReviewController]
        PoC[PostController]
        AC[AdminController]
    end
    
    subgraph "Interceptor Layer"
        LI[LoginInterceptor]
        AI[AdminInterceptor]
    end
    
    subgraph "Service Layer"
        US[UserService]
        PS[ProductService]
        CS[CartService]
        OS[OrderService]
        RS[ReviewService]
        PoS[PostService]
        ComS[CommentService]
    end
    
    subgraph "Mapper Layer"
        UM[UserMapper]
        PM[ProductMapper]
        CM[CartMapper]
        OM[OrderMapper]
        RM[ReviewMapper]
        PoM[PostMapper]
        ComM[CommentMapper]
    end
    
    subgraph "Database"
        DB[(MySQL Database)]
    end
    
    Browser --> JSP
    Browser --> Static
    JSP --> HC & UC & PC & CC & OC & RC & PoC & AC
    HC & UC & PC & CC & OC & RC & PoC & AC --> LI
    AC --> AI
    LI & AI --> US & PS & CS & OS & RS & PoS & ComS
    US --> UM
    PS --> PM
    CS --> CM
    OS --> OM
    RS --> RM
    PoS --> PoM
    ComS --> ComM
    UM & PM & CM & OM & RM & PoM & ComM --> DB
```

![Architecture Diagram](docs/architecture-diagram.md)

주요 구성 요소:
- **Controller Layer**: HTTP 요청을 처리하고 적절한 서비스를 호출
- **Service Layer**: 비즈니스 로직을 담당
- **Mapper Layer**: MyBatis를 통한 데이터베이스 접근
- **Interceptor**: 로그인 검증 및 권한 체크

## 💾 데이터베이스 구조

### ERD (Entity Relationship Diagram)
```mermaid
erDiagram
    User {
        INT UserID PK
        VARCHAR Username
        VARCHAR Password
        VARCHAR Email
        VARCHAR FullName
        VARCHAR Phone
        TEXT Address
        BOOLEAN IsAdmin
        DATETIME CreatedAt
    }
    
    Product {
        INT ProductID PK
        VARCHAR ProductName
        VARCHAR Category
        TEXT Description
        INT Price
        INT Stock
        VARCHAR ImageUrl
        DATETIME CreatedAt
    }
    
    Cart {
        INT CartID PK
        INT UserID
        INT ProductID
        INT Quantity
        DATETIME CreatedAt
    }
    
    Orders {
        INT OrderID PK
        INT UserID
        INT TotalAmount
        VARCHAR Status
        VARCHAR ShippingName
        VARCHAR ShippingPhone
        TEXT ShippingAddress
        DATETIME CreatedAt
    }
    
    OrderItem {
        INT OrderItemID PK
        INT OrderID
        INT ProductID
        VARCHAR ProductName
        INT Quantity
        INT Price
        DATETIME CreatedAt
    }
    
    Review {
        INT ReviewID PK
        INT UserID
        INT ProductID
        VARCHAR Username
        INT Rating
        VARCHAR Title
        TEXT Content
        DATETIME CreatedAt
    }
    
    Post {
        INT PostID PK
        INT UserID
        VARCHAR Username
        VARCHAR Title
        TEXT Content
        VARCHAR Category
        INT ViewCount
        DATETIME CreatedAt
    }
    
    Comment {
        INT CommentID PK
        INT PostID
        INT UserID
        VARCHAR Username
        TEXT Content
        DATETIME CreatedAt
    }
    
    User ||--o{ Cart : "has"
    User ||--o{ Orders : "places"
    User ||--o{ Review : "writes"
    User ||--o{ Post : "creates"
    User ||--o{ Comment : "writes"
    Product ||--o{ Cart : "contains"
    Product ||--o{ OrderItem : "ordered"
    Product ||--o{ Review : "reviewed"
    Orders ||--o{ OrderItem : "contains"
    Post ||--o{ Comment : "has"
```

![Database ERD](docs/database-erd.md)

### 주요 테이블
- **User**: 사용자 정보 (일반/관리자)
- **Product**: 상품 정보
- **Cart**: 장바구니
- **Orders**: 주문 정보
- **OrderItem**: 주문 상품 상세
- **Review**: 상품 리뷰
- **Post**: 게시글
- **Comment**: 댓글

## 🔄 프로세스 플로우

### 주요 처리 흐름

## 사용자 요청 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant C as Controller
    participant I as Interceptor
    participant S as Service
    participant M as Mapper
    participant D as Database
    
    U->>B: 페이지 요청
    B->>C: HTTP Request
    C->>I: 인터셉터 체크
    alt 로그인 필요
        I-->>B: 로그인 페이지로 리다이렉트
    else 인증됨
        I->>C: 요청 진행
        C->>S: 비즈니스 로직 호출
        S->>M: 데이터 조회/수정
        M->>D: SQL 실행
        D-->>M: 결과 반환
        M-->>S: VO 객체 반환
        S-->>C: 처리 결과
        C-->>B: JSP 뷰 렌더링
        B-->>U: 응답 페이지
    end
```

## 주문 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant C as CartController
    participant O as OrderController
    participant CS as CartService
    participant OS as OrderService
    participant PS as ProductService
    participant D as Database
    
    U->>C: 장바구니 조회
    C->>CS: getCartItems(userId)
    CS->>D: SELECT * FROM Cart
    D-->>CS: Cart Items
    CS-->>C: CartVO List
    C-->>U: 장바구니 페이지
    
    U->>O: 주문하기
    O->>CS: getCartItems(userId)
    CS-->>O: CartVO List
    O->>PS: checkStock(productIds)
    PS->>D: SELECT Stock FROM Product
    D-->>PS: Stock Info
    
    alt 재고 부족
        PS-->>O: OutOfStockException
        O-->>U: 재고 부족 알림
    else 재고 충분
        O->>OS: createOrder(orderInfo)
        OS->>D: INSERT INTO Orders
        OS->>D: INSERT INTO OrderItem
        OS->>PS: updateStock(products)
        PS->>D: UPDATE Product SET Stock
        OS->>CS: clearCart(userId)
        CS->>D: DELETE FROM Cart
        OS-->>O: Order Created
        O-->>U: 주문 완료 페이지
    end
```

## 관리자 인증 흐름

```mermaid
sequenceDiagram
    participant A as 관리자
    participant B as 브라우저
    participant AC as AdminController
    participant AI as AdminInterceptor
    participant S as Session
    
    A->>B: /admin/* 페이지 접근
    B->>AC: HTTP Request
    AC->>AI: preHandle()
    AI->>S: getUser()
    
    alt 비로그인 상태
        AI-->>B: 로그인 페이지로 리다이렉트
    else 일반 사용자
        S-->>AI: User(isAdmin=false)
        AI-->>B: 권한 없음 에러 페이지
    else 관리자
        S-->>AI: User(isAdmin=true)
        AI->>AC: 요청 진행 허용
        AC-->>B: 관리자 페이지 렌더링
    end
```

## 로그인 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant UC as UserController
    participant US as UserService
    participant UM as UserMapper
    participant D as Database
    participant S as Session
    
    U->>B: 로그인 정보 입력
    B->>UC: POST /login
    UC->>US: login(username, password)
    US->>UM: selectByUsername(username)
    UM->>D: SELECT * FROM User WHERE username = ?
    D-->>UM: UserVO
    UM-->>US: UserVO
    
    alt 사용자 없음
        US-->>UC: null
        UC-->>B: 로그인 실패 메시지
    else 비밀번호 불일치
        US-->>UC: null
        UC-->>B: 로그인 실패 메시지
    else 로그인 성공
        US-->>UC: UserVO
        UC->>S: setAttribute("loginUser", UserVO)
        UC->>CS: getCartCount(userId)
        CS->>S: setAttribute("cartCount", count)
        UC-->>B: 원래 요청 페이지로 리다이렉트
        B-->>U: 로그인 완료
    end
```

## 회원가입 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant UC as UserController
    participant US as UserService
    participant UM as UserMapper
    participant D as Database
    
    U->>B: 회원가입 폼 작성
    B->>UC: POST /register
    UC->>US: register(UserVO)
    
    US->>UM: selectByUsername(username)
    UM->>D: SELECT * FROM User WHERE username = ?
    D-->>UM: 결과
    
    alt 아이디 중복
        UM-->>US: UserVO exists
        US-->>UC: false
        UC-->>B: 아이디 중복 에러
    else 아이디 사용 가능
        US->>UM: selectByEmail(email)
        UM->>D: SELECT * FROM User WHERE email = ?
        D-->>UM: 결과
        
        alt 이메일 중복
            UM-->>US: UserVO exists
            US-->>UC: false
            UC-->>B: 이메일 중복 에러
        else 이메일 사용 가능
            US->>UM: insertUser(UserVO)
            UM->>D: INSERT INTO User VALUES (...)
            D-->>UM: 1 (성공)
            UM-->>US: 1
            US-->>UC: true
            UC-->>B: 회원가입 성공, 로그인 페이지로
            B-->>U: 회원가입 완료
        end
    end
```

## 장바구니 추가 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant CC as CartController
    participant CS as CartService
    participant CM as CartMapper
    participant D as Database
    participant S as Session
    
    U->>B: 장바구니 추가 버튼 클릭
    B->>CC: POST /cart/add
    CC->>S: getLoginUser()
    
    alt 비로그인
        S-->>CC: null
        CC-->>B: 로그인 페이지로 리다이렉트
    else 로그인 상태
        S-->>CC: UserVO
        CC->>CS: addToCart(CartVO)
        CS->>CM: selectByUserAndProduct(userId, productId)
        CM->>D: SELECT * FROM Cart WHERE userID = ? AND productID = ?
        D-->>CM: 결과
        
        alt 기존 상품 있음
            CM-->>CS: ExistingCartVO
            CS->>CM: updateQuantity(cartId, newQuantity)
            CM->>D: UPDATE Cart SET quantity = ? WHERE cartID = ?
            D-->>CM: 1 (성공)
        else 새로운 상품
            CS->>CM: insertCart(CartVO)
            CM->>D: INSERT INTO Cart VALUES (...)
            D-->>CM: 1 (성공)
        end
        
        CM-->>CS: 성공
        CS-->>CC: true
        CC->>S: updateCartCount()
        CC-->>B: 장바구니 추가 성공 메시지
        B-->>U: 장바구니 업데이트 완료
    end
```

## 상품 리뷰 작성 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant RC as ReviewController
    participant RS as ReviewService
    participant RM as ReviewMapper
    participant PS as ProductService
    participant D as Database
    
    U->>B: 리뷰 작성 폼 제출
    B->>RC: POST /review/write
    RC->>RS: addReview(ReviewVO)
    
    Note over RS: 구매 이력 확인 로직 필요
    
    RS->>RM: insert(ReviewVO)
    RM->>D: INSERT INTO Review VALUES (...)
    D-->>RM: 1 (성공)
    RM-->>RS: 성공
    
    RS->>PS: updateAverageRating(productId)
    PS->>RM: selectAverageRating(productId)
    RM->>D: SELECT AVG(rating) FROM Review WHERE productID = ?
    D-->>RM: 평균 평점
    RM-->>PS: 4.5
    
    PS->>D: UPDATE Product SET averageRating = ?
    D-->>PS: 성공
    
    RS-->>RC: true
    RC-->>B: 리뷰 작성 성공
    B-->>U: 리뷰 등록 완료
```

## 게시글 작성 및 댓글 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant PC as PostController
    participant PS as PostService
    participant CS as CommentService
    participant PM as PostMapper
    participant CM as CommentMapper
    participant D as Database
    participant S as Session
    
    Note over U,B: 게시글 작성
    U->>B: 게시글 작성 폼 제출
    B->>PC: POST /post/write
    PC->>S: getLoginUser()
    S-->>PC: UserVO
    PC->>PS: createPost(PostVO)
    PS->>PM: insertPost(PostVO)
    PM->>D: INSERT INTO Post VALUES (...)
    D-->>PM: PostID
    PM-->>PS: PostID
    PS-->>PC: true
    PC-->>B: redirect:/post/{postId}
    
    Note over U,B: 게시글 조회
    B->>PC: GET /post/{postId}
    PC->>PS: getPostById(postId)
    PS->>PM: selectById(postId)
    PM->>D: SELECT * FROM Post WHERE postID = ?
    D-->>PM: PostVO
    PS->>PM: increaseViewCount(postId)
    PM->>D: UPDATE Post SET viewCount = viewCount + 1
    PC->>CS: getCommentsByPost(postId)
    CS->>CM: selectByPostId(postId)
    CM->>D: SELECT * FROM Comment WHERE postID = ?
    D-->>CM: List<CommentVO>
    CM-->>CS: List<CommentVO>
    CS-->>PC: List<CommentVO>
    PC-->>B: 게시글 상세 페이지
    
    Note over U,B: 댓글 작성
    U->>B: 댓글 작성
    B->>PC: POST /post/{postId}/comment
    PC->>S: getLoginUser()
    S-->>PC: UserVO
    PC->>CS: addComment(CommentVO)
    CS->>CM: insertComment(CommentVO)
    CM->>D: INSERT INTO Comment VALUES (...)
    D-->>CM: 1 (성공)
    CM-->>CS: 성공
    CS-->>PC: true
    PC-->>B: redirect:/post/{postId}#comments
    B-->>U: 댓글 등록 완료
```

## 관리자 대시보드 조회 흐름

```mermaid
sequenceDiagram
    participant A as 관리자
    participant B as 브라우저
    participant AC as AdminController
    participant AI as AdminInterceptor
    participant US as UserService
    participant PS as ProductService
    participant OS as OrderService
    participant D as Database
    
    A->>B: /admin/dashboard 접근
    B->>AC: GET /admin/dashboard
    AC->>AI: preHandle()
    AI->>Session: getUser()
    Session-->>AI: User(isAdmin=true)
    AI->>AC: 요청 진행 허용
    
    AC->>US: getUserCount()
    US->>D: SELECT COUNT(*) FROM User
    D-->>US: 150
    
    AC->>PS: getProductCount()
    PS->>D: SELECT COUNT(*) FROM Product
    D-->>PS: 50
    
    AC->>OS: getOrderCount()
    OS->>D: SELECT COUNT(*) FROM Orders
    D-->>OS: 320
    
    AC->>OS: getPendingOrders()
    OS->>D: SELECT * FROM Orders WHERE status = 'PENDING'
    D-->>OS: List<OrderVO>
    
    AC->>OS: getRecentOrders(10)
    OS->>D: SELECT * FROM Orders ORDER BY createdAt DESC LIMIT 10
    D-->>OS: List<OrderVO>
    
    AC-->>B: 대시보드 페이지 렌더링
    B-->>A: 통계 및 주문 정보 표시
```

## 상품 검색 처리 흐름

```mermaid
sequenceDiagram
    participant U as 사용자
    participant B as 브라우저
    participant PC as ProductController
    participant PS as ProductService
    participant PM as ProductMapper
    participant D as Database
    
    U->>B: 검색어 입력 및 검색
    B->>PC: GET /product/search?keyword=토마토
    PC->>PS: searchProducts("토마토")
    PS->>PM: searchByKeyword("토마토")
    PM->>D: SELECT * FROM Product WHERE productName LIKE '%토마토%' OR description LIKE '%토마토%'
    D-->>PM: List<ProductVO>
    PM-->>PS: List<ProductVO>
    
    PS->>PM: selectCategories()
    PM->>D: SELECT DISTINCT category FROM Product
    D-->>PM: List<String>
    PM-->>PS: List<String>
    
    PS-->>PC: SearchResult
    PC-->>B: 검색 결과 페이지
    B-->>U: 검색된 상품 목록 표시
```

## 주문 상태 변경 흐름 (관리자)

```mermaid
sequenceDiagram
    participant A as 관리자
    participant B as 브라우저
    participant AC as AdminController
    participant OS as OrderService
    participant OM as OrderMapper
    participant D as Database
    
    A->>B: 주문 상태 변경 요청
    B->>AC: POST /admin/order/updateStatus
    AC->>OS: updateOrderStatus(orderId, newStatus)
    
    OS->>OM: selectById(orderId)
    OM->>D: SELECT * FROM Orders WHERE orderID = ?
    D-->>OM: OrderVO
    
    alt 취소 불가능 상태
        OM-->>OS: Order(status="SHIPPED")
        OS-->>AC: false (이미 배송 시작)
        AC-->>B: 상태 변경 불가 메시지
    else 변경 가능
        OS->>OM: updateStatus(orderId, newStatus)
        OM->>D: UPDATE Orders SET status = ? WHERE orderID = ?
        D-->>OM: 1 (성공)
        
        alt 주문 취소인 경우
            OS->>PS: restoreStock(orderItems)
            PS->>D: UPDATE Product SET stock = stock + ? WHERE productID = ?
        end
        
        OM-->>OS: 성공
        OS-->>AC: true
        AC-->>B: 상태 변경 성공
        B-->>A: 업데이트된 주문 정보 표시
    end
```

### 비즈니스 프로세스 플로우차트

## 회원가입 프로세스

```mermaid
flowchart TD
    Start([시작]) --> InputForm[회원가입 폼 입력]
    InputForm --> ValidateInput{입력값 검증}
    
    ValidateInput -->|유효하지 않음| ShowError[에러 메시지 표시]
    ShowError --> InputForm
    
    ValidateInput -->|유효함| CheckUsername{아이디 중복 확인}
    CheckUsername -->|중복됨| UsernameError[아이디 중복 에러]
    UsernameError --> InputForm
    
    CheckUsername -->|사용 가능| CheckEmail{이메일 중복 확인}
    CheckEmail -->|중복됨| EmailError[이메일 중복 에러]
    EmailError --> InputForm
    
    CheckEmail -->|사용 가능| CreateUser[사용자 정보 DB 저장]
    CreateUser --> Success[회원가입 성공]
    Success --> RedirectLogin[로그인 페이지로 이동]
    RedirectLogin --> End([종료])
```

## 상품 구매 전체 프로세스

```mermaid
flowchart TD
    Start([시작]) --> Browse[상품 브라우징]
    Browse --> SelectProduct[상품 선택]
    SelectProduct --> ViewDetail[상품 상세 보기]
    
    ViewDetail --> CheckLogin{로그인 여부}
    CheckLogin -->|비로그인| LoginPrompt[로그인 요청]
    LoginPrompt --> Login[로그인]
    Login --> ViewDetail
    
    CheckLogin -->|로그인됨| AddCart{장바구니 추가}
    AddCart --> ViewCart[장바구니 조회]
    
    ViewCart --> ContinueShopping{계속 쇼핑?}
    ContinueShopping -->|예| Browse
    ContinueShopping -->|아니오| ProceedOrder[주문 진행]
    
    ProceedOrder --> CheckStock{재고 확인}
    CheckStock -->|재고 부족| StockError[재고 부족 알림]
    StockError --> ViewCart
    
    CheckStock -->|재고 충분| InputShipping[배송 정보 입력]
    InputShipping --> ConfirmOrder[주문 확인]
    ConfirmOrder --> CreateOrder[주문 생성]
    
    CreateOrder --> UpdateStock[재고 차감]
    UpdateStock --> ClearCart[장바구니 비우기]
    ClearCart --> OrderComplete[주문 완료]
    OrderComplete --> End([종료])
```

## 리뷰 작성 프로세스

```mermaid
flowchart TD
    Start([시작]) --> ViewProduct[상품 페이지 조회]
    ViewProduct --> CheckPurchase{구매 이력 확인}
    
    CheckPurchase -->|구매 이력 없음| NoPurchase[리뷰 작성 불가 알림]
    NoPurchase --> End1([종료])
    
    CheckPurchase -->|구매 이력 있음| CheckExisting{기존 리뷰 확인}
    CheckExisting -->|리뷰 있음| ShowExisting[기존 리뷰 표시]
    ShowExisting --> EditOption{수정/삭제 선택}
    
    EditOption -->|수정| EditReview[리뷰 수정]
    EditOption -->|삭제| DeleteReview[리뷰 삭제]
    EditOption -->|취소| End2([종료])
    
    CheckExisting -->|리뷰 없음| WriteReview[리뷰 작성]
    WriteReview --> InputReview[평점 및 내용 입력]
    
    InputReview --> ValidateReview{유효성 검사}
    ValidateReview -->|유효하지 않음| ReviewError[에러 메시지]
    ReviewError --> InputReview
    
    ValidateReview -->|유효함| SaveReview[리뷰 저장]
    EditReview --> SaveReview
    SaveReview --> UpdateRating[상품 평점 업데이트]
    UpdateRating --> Success[작성/수정 완료]
    
    DeleteReview --> UpdateRating2[상품 평점 재계산]
    UpdateRating2 --> DeleteSuccess[삭제 완료]
    
    Success --> End3([종료])
    DeleteSuccess --> End4([종료])
```

## 상품 관리 프로세스 (관리자)

```mermaid
flowchart TD
    Start([시작]) --> AdminLogin[관리자 로그인]
    AdminLogin --> CheckAdmin{관리자 권한 확인}
    
    CheckAdmin -->|권한 없음| AccessDenied[접근 거부]
    AccessDenied --> End1([종료])
    
    CheckAdmin -->|권한 있음| AdminDashboard[관리자 대시보드]
    AdminDashboard --> SelectAction{작업 선택}
    
    SelectAction -->|상품 등록| NewProduct[새 상품 정보 입력]
    NewProduct --> ValidateProduct{상품 정보 검증}
    ValidateProduct -->|유효하지 않음| ProductError[에러 메시지]
    ProductError --> NewProduct
    ValidateProduct -->|유효함| SaveProduct[상품 저장]
    
    SelectAction -->|상품 수정| SelectProduct[상품 선택]
    SelectProduct --> EditProduct[상품 정보 수정]
    EditProduct --> ValidateEdit{수정 내용 검증}
    ValidateEdit -->|유효하지 않음| EditError[에러 메시지]
    EditError --> EditProduct
    ValidateEdit -->|유효함| UpdateProduct[상품 업데이트]
    
    SelectAction -->|상품 삭제| SelectDelete[삭제할 상품 선택]
    SelectDelete --> CheckOrders{주문 이력 확인}
    CheckOrders -->|주문 있음| DeleteWarning[삭제 불가 알림]
    DeleteWarning --> AdminDashboard
    CheckOrders -->|주문 없음| ConfirmDelete{삭제 확인}
    ConfirmDelete -->|취소| AdminDashboard
    ConfirmDelete -->|확인| DeleteProduct[상품 삭제]
    
    SelectAction -->|재고 관리| SelectStock[상품 선택]
    SelectStock --> UpdateStock[재고 수량 수정]
    UpdateStock --> SaveStock[재고 업데이트]
    
    SaveProduct --> Success[작업 완료]
    UpdateProduct --> Success
    DeleteProduct --> Success
    SaveStock --> Success
    
    Success --> AdminDashboard
```

![Flow Diagram](docs/flow-diagram.md)

시스템의 주요 프로세스:
1. **사용자 요청 처리**: 인터셉터를 통한 인증/인가 후 요청 처리
2. **주문 처리**: 장바구니 → 재고 확인 → 주문 생성 → 재고 차감
3. **관리자 인증**: 관리자 권한 확인 후 관리 페이지 접근
4. **회원가입**: 입력값 검증 → 중복 확인 → 사용자 생성
5. **상품 구매**: 상품 선택 → 장바구니 → 주문 → 결제 완료
6. **리뷰 작성**: 구매 확인 → 리뷰 작성/수정 → 평점 업데이트
7. **상품 관리**: 권한 확인 → 상품 CRUD → 재고 관리

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

## 📝 라이센스

이 프로젝트는 학습 목적의 토이 프로젝트입니다.
