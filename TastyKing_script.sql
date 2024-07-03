-- Tạo cơ sở dữ liệu TastyKing
CREATE DATABASE TastyKing;
USE TastyKing;

-- Tạo bảng users
CREATE TABLE users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FullName NVARCHAR(32),
    UserName VARCHAR(32),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Password VARCHAR(32),
    Role VARCHAR(10),
    Active BOOLEAN,
    Otp VARCHAR(10),
    GenerateOtpTime DATETIME
    -- Nếu cần thêm cột Provider và ProviderId, bỏ chú thích dòng dưới đây
    --, Provider VARCHAR(50),
    --, ProviderId VARCHAR(100)
);

-- Tạo bảng rewardpoint
CREATE TABLE rewardpoint (
    RewardPointID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Balance FLOAT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES users(UserID)
);

-- Tạo bảng slide
CREATE TABLE slide (
    SlideID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Image VARCHAR(100) NOT NULL,
    SlidePosition INT NOT NULL,
    FOREIGN KEY (UserID) REFERENCES users(UserID)
);

-- Tạo bảng voucher
CREATE TABLE voucher (
    VoucherID VARCHAR(50) PRIMARY KEY,
    VoucherTitle VARCHAR(32) NOT NULL,
    VoucherDiscount INT NOT NULL,
    VoucherQuantity INT NOT NULL,
    VoucherExchangeValue DOUBLE NOT NULL,
    VoucherStartDate DATE NOT NULL,
    VoucherDueDate DATE NOT NULL,
    VoucherImage VARCHAR(100),
    VoucherDescribe TEXT
);

-- Tạo bảng voucherexchange
CREATE TABLE voucherexchange (
    VoucherExchangeID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    VoucherID VARCHAR(50) NOT NULL,
    ExchangeDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    FOREIGN KEY (VoucherID) REFERENCES voucher(VoucherID)
);

-- Tạo bảng tableposition
CREATE TABLE tableposition (
    TablePositionID INT AUTO_INCREMENT PRIMARY KEY,
    TableQuantity INT NOT NULL,
    TablePosition VARCHAR(10) NOT NULL
);

-- Tạo bảng tables
CREATE TABLE tables (
    TableID INT AUTO_INCREMENT PRIMARY KEY,
    TablePositionID INT NOT NULL,
    TableStatus VARCHAR(10) NOT NULL,
    NumOfChair INT NOT NULL,
    FOREIGN KEY (TablePositionID) REFERENCES tableposition(TablePositionID)
);

-- Tạo bảng orders
CREATE TABLE orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    TableID INT NOT NULL,
    VoucherID VARCHAR(50),
    Status NVARCHAR(50) NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(18, 2),
    Note NVARCHAR(1000),
    NumberOfCustomer INT,
    NumberPhone NVARCHAR(15) NOT NULL,
    CustomerName NVARCHAR(32) NOT NULL,
    DateTime DATE,
    FOREIGN KEY (VoucherID) REFERENCES voucher(VoucherID),
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    FOREIGN KEY (TableID) REFERENCES tables(TableID)
);

-- Tạo bảng category
CREATE TABLE category (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(32) NOT NULL
);

-- Tạo bảng food
CREATE TABLE food (
    FoodID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryID INT NOT NULL,
    FoodName NVARCHAR(32) NOT NULL,
    FoodPrice DECIMAL(18, 2) NOT NULL,
    FoodCost DECIMAL(18, 2) NOT NULL,
    Description NVARCHAR(1000) NULL,
    Unit VARCHAR(50) NOT NULL,
    FoodImage VARCHAR(100) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES category(CategoryID)
);

-- Tạo bảng review
CREATE TABLE review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    FoodID INT NOT NULL,
    ReviewText NVARCHAR(500),
    ReviewDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    FOREIGN KEY (FoodID) REFERENCES food(FoodID)
);

-- Tạo bảng combo
CREATE TABLE combo (
    ComboID INT AUTO_INCREMENT PRIMARY KEY,
    ComboTitle VARCHAR(32) NULL,
    OldPrice DOUBLE NOT NULL,
    NewPrice DOUBLE NOT NULL,
    OpenDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    ComboImage VARCHAR(100) NULL,
    ComboDescription NVARCHAR(500)
);

-- Tạo bảng combofood
CREATE TABLE combofood (
    ComboID INT,
    FoodID INT,
    Quantity INT,
    PRIMARY KEY (ComboID, FoodID),
    FOREIGN KEY (ComboID) REFERENCES combo(ComboID) ON DELETE CASCADE,
    FOREIGN KEY (FoodID) REFERENCES food(FoodID)
);

-- Tạo bảng orderdetail
CREATE TABLE orderdetail (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    FoodID INT NOT NULL,
    TotalPrice DECIMAL(18, 2),
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
    FOREIGN KEY (FoodID) REFERENCES food(FoodID)
);

-- Tạo bảng bill
CREATE TABLE bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    BillStatus NVARCHAR(10) NOT NULL,
    BillReleaseDate DATETIME NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);

-- Tạo bảng payment
CREATE TABLE payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    BillID INT NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentType NVARCHAR(50) NOT NULL,
    PaymentStatus NVARCHAR(50) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES users(UserID),
    FOREIGN KEY (BillID) REFERENCES bill(BillID)
);
