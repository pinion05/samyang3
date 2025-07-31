# 데이터베이스 ERD (Entity Relationship Diagram)

## Samyang3 데이터베이스 구조

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

## 테이블 설명

### User (사용자)
- 시스템의 모든 사용자 정보를 저장
- IsAdmin 필드로 관리자와 일반 사용자를 구분

### Product (상품)
- 판매되는 농산물 상품 정보
- 카테고리별로 분류 가능

### Cart (장바구니)
- 사용자별 장바구니 아이템 관리
- 사용자는 여러 상품을 장바구니에 담을 수 있음

### Orders (주문)
- 완료된 주문 정보
- 배송 정보와 주문 상태 관리

### OrderItem (주문 상품)
- 각 주문에 포함된 상품 상세 정보
- 주문 시점의 가격과 수량 저장

### Review (리뷰)
- 상품에 대한 사용자 리뷰
- 별점과 텍스트 리뷰 포함

### Post (게시글)
- 커뮤니티 게시글
- 카테고리별 분류 및 조회수 관리

### Comment (댓글)
- 게시글에 대한 댓글
- 중첩된 댓글 구조는 지원하지 않음