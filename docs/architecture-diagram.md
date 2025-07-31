# 시스템 아키텍처 다이어그램

## 전체 시스템 구조

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

## 설명

이 다이어그램은 Samyang3 프로젝트의 전체 시스템 아키텍처를 보여줍니다.

- **Client Layer**: 사용자가 웹 브라우저를 통해 시스템에 접근
- **Presentation Layer**: JSP 뷰와 정적 리소스로 구성
- **Controller Layer**: 각 도메인별 컨트롤러가 요청을 처리
- **Interceptor Layer**: 로그인 검증 및 관리자 권한 체크
- **Service Layer**: 비즈니스 로직 처리
- **Mapper Layer**: MyBatis를 사용한 데이터베이스 접근
- **Database**: MySQL 데이터베이스