-- samyang3 간단한 이커머스 데이터베이스 스키마
-- 조인과 뷰 없이 단순한 CRUD 구조

mysql server host : 34.47.105.223
user : root
password : root



-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS samyang CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE samyang;

-- 1. User 테이블 (회원)
CREATE TABLE IF NOT EXISTS User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    IsAdmin BOOLEAN DEFAULT FALSE,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Product 테이블 (상품) - Crop 대신 Product로 명확하게
CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Description TEXT,
    Price INT NOT NULL DEFAULT 0,
    Stock INT NOT NULL DEFAULT 0,
    ImageUrl VARCHAR(500),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Cart 테이블 (장바구니)
CREATE TABLE IF NOT EXISTS Cart (
    CartID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Orders 테이블 (주문)
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    TotalAmount INT NOT NULL,
    Status VARCHAR(20) DEFAULT 'pending',
    ShippingName VARCHAR(100) NOT NULL,
    ShippingPhone VARCHAR(20) NOT NULL,
    ShippingAddress TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. OrderItem 테이블 (주문상품)
CREATE TABLE IF NOT EXISTS OrderItem (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    Price INT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Review 테이블 (리뷰)
CREATE TABLE IF NOT EXISTS Review (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Rating INT NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Content TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 7. Post 테이블 (게시글)
CREATE TABLE IF NOT EXISTS Post (
    PostID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Title VARCHAR(200) NOT NULL,
    Content TEXT NOT NULL,
    Category VARCHAR(50),
    ViewCount INT DEFAULT 0,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 8. Comment 테이블 (댓글)
CREATE TABLE IF NOT EXISTS Comment (
    CommentID INT PRIMARY KEY AUTO_INCREMENT,
    PostID INT NOT NULL,
    UserID INT NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Content TEXT NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 샘플 데이터 삽입

-- 관리자 계정
INSERT INTO User (Username, Password, Email, FullName, Phone, Address, IsAdmin) VALUES
('admin', '1234', 'admin@samyang.com', '관리자', '010-0000-0000', '서울시 강남구', TRUE);

-- 일반 사용자
INSERT INTO User (Username, Password, Email, FullName, Phone, Address) VALUES
('user1', '1234', 'user1@example.com', '김농부', '010-1111-1111', '서울시 서초구'),
('user2', '1234', 'user2@example.com', '이농부', '010-2222-2222', '서울시 송파구'),
('user3', '1234', 'user3@example.com', '박농부', '010-3333-3333', '경기도 성남시');

-- 상품 데이터
INSERT INTO Product (ProductName, Category, Description, Price, Stock, ImageUrl) VALUES
('토마토 씨앗', '채소', '신선한 토마토를 재배할 수 있는 고품질 씨앗입니다.', 5000, 100, '/images/tomato.jpg'),
('상추 씨앗', '채소', '아삭한 상추를 키울 수 있는 씨앗입니다.', 3000, 150, '/images/lettuce.jpg'),
('고추 모종', '채소', '매운 고추를 재배할 수 있는 건강한 모종입니다.', 2000, 80, '/images/pepper.jpg'),
('딸기 모종', '과일', '달콤한 딸기를 수확할 수 있는 모종입니다.', 8000, 50, '/images/strawberry.jpg'),
('바질 씨앗', '허브', '향긋한 바질을 키울 수 있는 씨앗입니다.', 4000, 200, '/images/basil.jpg'),
('오이 씨앗', '채소', '시원한 오이를 재배할 수 있는 씨앗입니다.', 3500, 120, '/images/cucumber.jpg'),
('당근 씨앗', '채소', '영양가 높은 당근을 키울 수 있는 씨앗입니다.', 2500, 180, '/images/carrot.jpg'),
('블루베리 모종', '과일', '항산화 성분이 풍부한 블루베리 모종입니다.', 12000, 30, '/images/blueberry.jpg');

-- 장바구니 샘플
INSERT INTO Cart (UserID, ProductID, Quantity) VALUES
(2, 1, 2),
(2, 3, 1),
(3, 4, 1),
(3, 5, 3);

-- 주문 샘플
INSERT INTO Orders (UserID, TotalAmount, Status, ShippingName, ShippingPhone, ShippingAddress) VALUES
(2, 15000, 'delivered', '김농부', '010-1111-1111', '서울시 서초구 서초동 123-45'),
(3, 20000, 'shipping', '이농부', '010-2222-2222', '서울시 송파구 잠실동 678-90');

-- 주문상품 샘플
INSERT INTO OrderItem (OrderID, ProductID, ProductName, Quantity, Price) VALUES
(1, 1, '토마토 씨앗', 2, 10000),
(1, 2, '상추 씨앗', 1, 3000),
(1, 3, '고추 모종', 1, 2000),
(2, 4, '딸기 모종', 1, 8000),
(2, 5, '바질 씨앗', 3, 12000);

-- 리뷰 샘플
INSERT INTO Review (UserID, ProductID, Username, Rating, Title, Content) VALUES
(2, 1, 'user1', 5, '정말 좋아요!', '발아율이 높고 튼튼한 토마토가 자랐습니다.'),
(3, 1, 'user2', 4, '만족합니다', '배송도 빠르고 품질도 좋네요.'),
(2, 3, 'user1', 5, '최고의 고추 모종', '작년에 이어 올해도 구매했습니다. 수확량이 많아요!'),
(3, 4, 'user2', 5, '달콤한 딸기', '아이들이 정말 좋아해요. 재구매 의사 있습니다.'),
(2, 5, 'user1', 4, '향이 좋아요', '파스타 요리에 사용하니 향이 정말 좋네요.');

-- 게시글 샘플
INSERT INTO Post (UserID, Username, Title, Content, Category, ViewCount) VALUES
(2, 'user1', '토마토 재배 팁 공유합니다', '토마토를 재배하면서 알게 된 꿀팁들을 공유합니다. 물주기는 아침에 하는 것이 좋아요.', '재배팁', 45),
(3, 'user2', '처음 텃밭 시작하는 분들께', '도시농부 3년차입니다. 처음 시작하시는 분들을 위한 조언을 드려요.', '초보가이드', 123),
(2, 'user1', '올해 수확한 채소들', '올해 텃밭에서 수확한 채소들 자랑합니다. 토마토, 상추, 고추 모두 풍작이었어요!', '수확자랑', 89),
(4, 'user3', '병충해 대처법 질문드려요', '고추에 진딧물이 생겼는데 어떻게 대처하면 좋을까요?', '질문답변', 56),
(3, 'user2', '유기농 재배의 장점', '3년간 유기농으로 재배하면서 느낀 점들을 공유합니다.', '재배팁', 78);

-- 댓글 샘플
INSERT INTO Comment (PostID, UserID, Username, Content) VALUES
(1, 3, 'user2', '좋은 정보 감사합니다! 저도 아침에 물주기 시작해봐야겠어요.'),
(1, 4, 'user3', '토마토 지지대는 어떤 걸 사용하시나요?'),
(2, 2, 'user1', '초보자를 위한 좋은 글이네요. 많은 분들께 도움이 될 것 같아요.'),
(2, 4, 'user3', '저도 이제 막 시작했는데 정말 도움이 됩니다!'),
(3, 3, 'user2', '우와 정말 풍작이네요! 비결이 뭔가요?'),
(3, 4, 'user3', '부럽습니다. 저도 내년엔 이렇게 수확하고 싶어요.'),
(4, 2, 'user1', '계란 껍질을 갈아서 뿌려보세요. 천연 방충제 역할을 합니다.'),
(4, 3, 'user2', '님프 오일도 효과가 좋아요. 희석해서 뿌려보세요.'),
(5, 2, 'user1', '유기농 재배 정말 좋죠. 건강에도 좋고 맛도 더 좋은 것 같아요.');