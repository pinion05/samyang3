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
flowchart TD
    Start([시작]) --> Request[사용자가 페이지 요청]
    Request --> HTTPReq[브라우저가 HTTP Request 전송]
    HTTPReq --> Controller[Controller가 요청 수신]
    Controller --> Interceptor{Interceptor 체크}
    
    Interceptor -->|로그인 필요| CheckLogin{로그인 여부 확인}
    CheckLogin -->|비로그인| SaveURL[원래 요청 URL 저장]
    SaveURL --> RedirectLogin[로그인 페이지로 리다이렉트]
    RedirectLogin --> LoginEnd([로그인 필요])
    
    CheckLogin -->|로그인됨| CheckAuth{권한 확인}
    CheckAuth -->|권한 없음| AccessDenied[접근 거부 페이지]
    AccessDenied --> AuthEnd([권한 없음])
    
    CheckAuth -->|권한 있음| ProceedRequest[요청 진행]
    Interceptor -->|로그인 불필요| ProceedRequest
    
    ProceedRequest --> CallService[Service 비즈니스 로직 호출]
    CallService --> CallMapper[Mapper 데이터 조회/수정]
    CallMapper --> ExecuteSQL[SQL 실행]
    ExecuteSQL --> ReturnData[데이터 반환]
    ReturnData --> ReturnVO[VO 객체 반환]
    ReturnVO --> ProcessResult[처리 결과 생성]
    ProcessResult --> RenderJSP[JSP 뷰 렌더링]
    RenderJSP --> SendResponse[응답 페이지 전송]
    SendResponse --> End([완료])
```

## 주문 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> ViewCart[장바구니 조회 요청]
    ViewCart --> GetCartItems[CartService.getCartItems 호출]
    GetCartItems --> SelectCart[Cart 테이블 조회]
    SelectCart --> ReturnCart[장바구니 상품 목록 반환]
    ReturnCart --> ShowCart[장바구니 페이지 표시]
    
    ShowCart --> ClickOrder{주문하기 클릭}
    ClickOrder -->|예| LoadCart[장바구니 상품 다시 조회]
    ClickOrder -->|아니오| ContinueShopping[쇼핑 계속]
    ContinueShopping --> End1([종료])
    
    LoadCart --> CheckStock[재고 확인]
    CheckStock --> QueryStock[Product 테이블에서 재고 조회]
    QueryStock --> StockResult{재고 충분?}
    
    StockResult -->|재고 부족| ShowStockError[재고 부족 알림]
    ShowStockError --> BackToCart[장바구니로 돌아가기]
    BackToCart --> ShowCart
    
    StockResult -->|재고 충분| CreateOrder[주문 생성]
    CreateOrder --> InsertOrder[Orders 테이블에 주문 정보 저장]
    InsertOrder --> InsertOrderItems[OrderItem 테이블에 상품별 정보 저장]
    InsertOrderItems --> UpdateStock[재고 차감]
    UpdateStock --> UpdateProduct[Product 테이블 stock 업데이트]
    UpdateProduct --> ClearCart[장바구니 비우기]
    ClearCart --> DeleteCart[Cart 테이블에서 해당 사용자 데이터 삭제]
    DeleteCart --> OrderComplete[주문 완료 페이지 표시]
    OrderComplete --> End2([완료])
```

## 관리자 인증 흐름

```mermaid
flowchart TD
    Start([시작]) --> AdminAccess[/admin/* 페이지 접근]
    AdminAccess --> SendRequest[HTTP Request 전송]
    SendRequest --> InterceptorCheck[AdminInterceptor.preHandle 실행]
    InterceptorCheck --> GetSession[세션에서 사용자 정보 조회]
    
    GetSession --> CheckUser{사용자 정보 확인}
    
    CheckUser -->|비로그인| NoUser[사용자 정보 없음]
    NoUser --> RedirectLogin[로그인 페이지로 리다이렉트]
    RedirectLogin --> LoginRequired([로그인 필요])
    
    CheckUser -->|로그인됨| HasUser[사용자 정보 있음]
    HasUser --> CheckAdmin{관리자 권한 확인}
    
    CheckAdmin -->|일반 사용자| NotAdmin[isAdmin = false]
    NotAdmin --> ShowError[권한 없음 에러 페이지]
    ShowError --> AccessDenied([접근 거부])
    
    CheckAdmin -->|관리자| IsAdmin[isAdmin = true]
    IsAdmin --> AllowRequest[요청 진행 허용]
    AllowRequest --> ProcessRequest[AdminController 처리]
    ProcessRequest --> RenderPage[관리자 페이지 렌더링]
    RenderPage --> End([완료])
```

## 로그인 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> InputLogin[로그인 정보 입력]
    InputLogin --> SubmitLogin[로그인 폼 제출]
    SubmitLogin --> PostRequest[POST /login 요청]
    PostRequest --> CallLogin[UserService.login 호출]
    
    CallLogin --> SelectUser[username으로 사용자 조회]
    SelectUser --> QueryUser[User 테이블에서 SELECT]
    QueryUser --> UserExists{사용자 존재?}
    
    UserExists -->|사용자 없음| NoUser[사용자 정보 없음]
    NoUser --> LoginFail1[로그인 실패 메시지]
    LoginFail1 --> BackToLogin1[로그인 페이지로]
    BackToLogin1 --> End1([실패])
    
    UserExists -->|사용자 있음| CheckPassword{비밀번호 확인}
    CheckPassword -->|불일치| PasswordWrong[비밀번호 불일치]
    PasswordWrong --> LoginFail2[로그인 실패 메시지]
    LoginFail2 --> BackToLogin2[로그인 페이지로]
    BackToLogin2 --> End2([실패])
    
    CheckPassword -->|일치| LoginSuccess[로그인 성공]
    LoginSuccess --> SetSession[세션에 UserVO 저장]
    SetSession --> GetCartCount[장바구니 개수 조회]
    GetCartCount --> SetCartCount[세션에 cartCount 저장]
    SetCartCount --> CheckOriginalURL{원래 요청 URL 있음?}
    
    CheckOriginalURL -->|있음| RedirectOriginal[원래 요청 페이지로 리다이렉트]
    CheckOriginalURL -->|없음| RedirectHome[메인 페이지로 리다이렉트]
    
    RedirectOriginal --> End3([로그인 완료])
    RedirectHome --> End4([로그인 완료])
```

## 회원가입 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> InputForm[회원가입 폼 작성]
    InputForm --> ValidateInput{입력값 유효성 검사}
    
    ValidateInput -->|유효하지 않음| ShowValidError[유효성 검사 에러 표시]
    ShowValidError --> InputForm
    
    ValidateInput -->|유효함| SubmitForm[폼 제출]
    SubmitForm --> PostRegister[POST /register 요청]
    PostRegister --> CallRegister[UserService.register 호출]
    
    CallRegister --> CheckUsername[아이디 중복 확인]
    CheckUsername --> QueryUsername[username으로 User 테이블 조회]
    QueryUsername --> UsernameExists{아이디 중복?}
    
    UsernameExists -->|중복됨| UsernameError[아이디 중복 에러]
    UsernameError --> ShowUsernameError[아이디 중복 메시지 표시]
    ShowUsernameError --> InputForm
    
    UsernameExists -->|사용 가능| CheckEmail[이메일 중복 확인]
    CheckEmail --> QueryEmail[email로 User 테이블 조회]
    QueryEmail --> EmailExists{이메일 중복?}
    
    EmailExists -->|중복됨| EmailError[이메일 중복 에러]
    EmailError --> ShowEmailError[이메일 중복 메시지 표시]
    ShowEmailError --> InputForm
    
    EmailExists -->|사용 가능| SetUserRole[일반 사용자로 설정]
    SetUserRole --> InsertUser[User 테이블에 INSERT]
    InsertUser --> SaveSuccess{저장 성공?}
    
    SaveSuccess -->|실패| SaveError[데이터베이스 에러]
    SaveError --> ShowSaveError[저장 실패 메시지]
    ShowSaveError --> InputForm
    
    SaveSuccess -->|성공| RegisterComplete[회원가입 완료]
    RegisterComplete --> RedirectLogin[로그인 페이지로 리다이렉트]
    RedirectLogin --> End([완료])
```

## 장바구니 추가 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> ClickAdd[장바구니 추가 버튼 클릭]
    ClickAdd --> PostCart[POST /cart/add 요청]
    PostCart --> CheckLogin{로그인 상태 확인}
    
    CheckLogin -->|비로그인| NotLoggedIn[세션에 사용자 정보 없음]
    NotLoggedIn --> RedirectLogin[로그인 페이지로 리다이렉트]
    RedirectLogin --> End1([로그인 필요])
    
    CheckLogin -->|로그인됨| LoggedIn[사용자 정보 확인]
    LoggedIn --> CallAddCart[CartService.addToCart 호출]
    CallAddCart --> CheckExisting[기존 장바구니 상품 확인]
    CheckExisting --> QueryCart[userID와 productID로 Cart 조회]
    
    QueryCart --> CartExists{기존 상품 존재?}
    
    CartExists -->|존재함| ExistingItem[기존 장바구니 상품]
    ExistingItem --> CalcNewQty[기존 수량 + 새 수량 계산]
    CalcNewQty --> UpdateQuantity[수량 업데이트]
    UpdateQuantity --> UpdateCart[Cart 테이블 UPDATE]
    
    CartExists -->|없음| NewItem[새로운 상품]
    NewItem --> InsertCart[장바구니에 새로 추가]
    InsertCart --> InsertIntoCart[Cart 테이블 INSERT]
    
    UpdateCart --> UpdateSession[세션 장바구니 개수 업데이트]
    InsertIntoCart --> UpdateSession
    
    UpdateSession --> ShowSuccess[장바구니 추가 성공 메시지]
    ShowSuccess --> End2([완료])
```

## 상품 리뷰 작성 흐름

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
    
    CheckExisting -->|리뷰 없음| WriteReview[리뷰 작성 폼]
    WriteReview --> InputReview[평점 및 내용 입력]
    
    InputReview --> ValidateReview{유효성 검사}
    ValidateReview -->|유효하지 않음| ReviewError[에러 메시지]
    ReviewError --> InputReview
    
    ValidateReview -->|유효함| SubmitReview[리뷰 제출]
    EditReview --> SubmitReview
    
    SubmitReview --> CallAddReview[ReviewService.addReview 호출]
    CallAddReview --> InsertReview[Review 테이블에 INSERT]
    InsertReview --> SaveSuccess{저장 성공?}
    
    SaveSuccess -->|실패| SaveError[저장 실패 메시지]
    SaveError --> End3([실패])
    
    SaveSuccess -->|성공| UpdateRating[평균 평점 업데이트]
    UpdateRating --> CalcAvgRating[평균 평점 계산]
    CalcAvgRating --> UpdateProduct[Product 테이블 평점 업데이트]
    UpdateProduct --> ReviewComplete[리뷰 작성/수정 완료]
    
    DeleteReview --> DeleteFromDB[Review 테이블에서 DELETE]
    DeleteFromDB --> RecalcRating[평균 평점 재계산]
    RecalcRating --> UpdateProduct2[Product 테이블 평점 업데이트]
    UpdateProduct2 --> DeleteComplete[리뷰 삭제 완료]
    
    ReviewComplete --> End4([완료])
    DeleteComplete --> End5([완료])
```

## 게시글 작성 및 댓글 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> SelectAction{작업 선택}
    
    SelectAction -->|게시글 작성| WritePost[게시글 작성 폼]
    WritePost --> CheckLoginWrite{로그인 상태 확인}
    CheckLoginWrite -->|비로그인| RedirectLogin1[로그인 페이지로]
    RedirectLogin1 --> End1([로그인 필요])
    
    CheckLoginWrite -->|로그인됨| InputPost[게시글 내용 입력]
    InputPost --> SubmitPost[게시글 제출]
    SubmitPost --> CreatePost[PostService.createPost 호출]
    CreatePost --> InsertPost[Post 테이블에 INSERT]
    InsertPost --> GetPostId[생성된 PostID 획득]
    GetPostId --> RedirectDetail[게시글 상세 페이지로 리다이렉트]
    
    SelectAction -->|게시글 조회| ViewPost[게시글 상세 조회]
    RedirectDetail --> ViewPost
    ViewPost --> GetPost[PostService.getPostById 호출]
    GetPost --> SelectPost[Post 테이블에서 조회]
    SelectPost --> IncreaseView[조회수 증가]
    IncreaseView --> UpdateView[viewCount + 1 업데이트]
    UpdateView --> GetComments[댓글 목록 조회]
    GetComments --> SelectComments[Comment 테이블에서 조회]
    SelectComments --> ShowDetail[게시글과 댓글 표시]
    
    ShowDetail --> CommentAction{댓글 작업?}
    CommentAction -->|작성| WriteComment[댓글 작성]
    CommentAction -->|조회만| End2([종료])
    
    WriteComment --> CheckLoginComment{로그인 상태 확인}
    CheckLoginComment -->|비로그인| RedirectLogin2[로그인 페이지로]
    RedirectLogin2 --> End3([로그인 필요])
    
    CheckLoginComment -->|로그인됨| InputComment[댓글 내용 입력]
    InputComment --> SubmitComment[댓글 제출]
    SubmitComment --> AddComment[CommentService.addComment 호출]
    AddComment --> InsertComment[Comment 테이블에 INSERT]
    InsertComment --> CommentSuccess[댓글 등록 성공]
    CommentSuccess --> RedirectComments[게시글 페이지 #comments로]
    RedirectComments --> ShowDetail
    
    SelectAction -->|게시글 수정/삭제| ModifyPost[게시글 수정/삭제]
    ModifyPost --> CheckOwner{작성자 확인}
    CheckOwner -->|본인 아님| AccessDenied[접근 거부]
    AccessDenied --> End4([권한 없음])
    
    CheckOwner -->|본인 또는 관리자| ModifyAction{수정/삭제?}
    ModifyAction -->|수정| UpdatePost[게시글 수정]
    ModifyAction -->|삭제| DeletePost[게시글 삭제]
    
    UpdatePost --> SaveUpdate[Post 테이블 UPDATE]
    DeletePost --> DeleteFromDB[Post 테이블에서 DELETE]
    
    SaveUpdate --> End5([수정 완료])
    DeleteFromDB --> End6([삭제 완료])
```

## 관리자 대시보드 조회 흐름

```mermaid
flowchart TD
    Start([시작]) --> AccessDashboard[관리자 대시보드 접근]
    AccessDashboard --> AdminRequest[GET /admin/dashboard 요청]
    AdminRequest --> AdminInterceptor[관리자 인터셉터 체크]
    AdminInterceptor --> CheckAdminAuth{관리자 권한 확인}
    
    CheckAdminAuth -->|권한 없음| DenyAccess[접근 거부]
    DenyAccess --> End1([권한 없음])
    
    CheckAdminAuth -->|관리자 확인| AllowAccess[요청 진행 허용]
    AllowAccess --> LoadStats[통계 데이터 로드]
    
    LoadStats --> GetUserCount[회원 수 조회]
    GetUserCount --> QueryUserCount[SELECT COUNT(*) FROM User]
    QueryUserCount --> UserCount[150명]
    
    UserCount --> GetProductCount[상품 수 조회]
    GetProductCount --> QueryProductCount[SELECT COUNT(*) FROM Product]
    QueryProductCount --> ProductCount[50개]
    
    ProductCount --> GetOrderCount[주문 수 조회]
    GetOrderCount --> QueryOrderCount[SELECT COUNT(*) FROM Orders]
    QueryOrderCount --> OrderCount[320건]
    
    OrderCount --> GetPendingOrders[대기 중 주문 조회]
    GetPendingOrders --> QueryPending[SELECT * FROM Orders WHERE status = 'PENDING']
    QueryPending --> PendingList[대기 주문 목록]
    
    PendingList --> GetRecentOrders[최근 주문 조회]
    GetRecentOrders --> QueryRecent[SELECT * FROM Orders ORDER BY createdAt DESC LIMIT 10]
    QueryRecent --> RecentList[최근 주문 10건]
    
    RecentList --> PrepareData[대시보드 데이터 준비]
    PrepareData --> RenderDashboard[대시보드 페이지 렌더링]
    RenderDashboard --> ShowDashboard[통계 및 주문 정보 표시]
    ShowDashboard --> End2([완료])
```

## 상품 검색 처리 흐름

```mermaid
flowchart TD
    Start([시작]) --> InputKeyword[검색어 입력]
    InputKeyword --> SubmitSearch[검색 버튼 클릭]
    SubmitSearch --> SendRequest[GET /product/search?keyword=토마토]
    SendRequest --> CallSearch[ProductService.searchProducts 호출]
    
    CallSearch --> QueryProducts[상품 검색 쿼리 실행]
    QueryProducts --> SearchByName[productName LIKE '%토마토%']
    SearchByName --> SearchByDesc[OR description LIKE '%토마토%']
    SearchByDesc --> ExecuteQuery[Product 테이블에서 조회]
    
    ExecuteQuery --> GetResults[검색 결과 획듍]
    GetResults --> CheckResults{검색 결과 있음?}
    
    CheckResults -->|결과 없음| NoResults[검색 결과 없음 메시지]
    CheckResults -->|결과 있음| HasResults[검색 결과 있음]
    
    HasResults --> GetCategories[카테고리 목록 조회]
    NoResults --> GetCategories
    GetCategories --> QueryCategories[SELECT DISTINCT category FROM Product]
    QueryCategories --> CategoriesList[카테고리 목록]
    
    CategoriesList --> PrepareResult[검색 결과 준비]
    PrepareResult --> RenderResults[검색 결과 페이지 렌더링]
    RenderResults --> ShowResults[검색된 상품 목록 표시]
    ShowResults --> End([완료])
```

## 주문 상태 변경 흐름 (관리자)

```mermaid
flowchart TD
    Start([시작]) --> SelectOrder[변경할 주문 선택]
    SelectOrder --> SelectStatus[새로운 상태 선택]
    SelectStatus --> SubmitChange[상태 변경 요청]
    SubmitChange --> PostRequest[POST /admin/order/updateStatus]
    
    PostRequest --> CallUpdate[OrderService.updateOrderStatus 호출]
    CallUpdate --> GetOrder[주문 정보 조회]
    GetOrder --> QueryOrder[SELECT * FROM Orders WHERE orderID = ?]
    QueryOrder --> CheckStatus{현재 상태 확인}
    
    CheckStatus -->|이미 배송 시작| ShippedStatus[status = "SHIPPED"]
    ShippedStatus --> CannotCancel[취소 불가능]
    CannotCancel --> ShowError[상태 변경 불가 메시지]
    ShowError --> End1([변경 불가])
    
    CheckStatus -->|변경 가능| CanChange[상태 변경 가능]
    CanChange --> UpdateStatus[주문 상태 업데이트]
    UpdateStatus --> UpdateOrder[UPDATE Orders SET status = ?]
    
    UpdateOrder --> CheckCancellation{주문 취소인가?}
    CheckCancellation -->|아니오| NotCancellation[일반 상태 변경]
    CheckCancellation -->|예| IsCancellation[주문 취소 처리]
    
    IsCancellation --> GetOrderItems[주문 상품 목록 조회]
    GetOrderItems --> RestoreStock[재고 복원]
    RestoreStock --> UpdateStock[UPDATE Product SET stock = stock + ?]
    
    UpdateStock --> UpdateSuccess[상태 변경 성공]
    NotCancellation --> UpdateSuccess
    UpdateSuccess --> RefreshOrder[주문 정보 새로고침]
    RefreshOrder --> ShowUpdated[업데이트된 주문 정보 표시]
    ShowUpdated --> End2([완료])
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
