# 프로세스 플로우

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