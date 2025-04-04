CREATE TABLE [dbo].[Users] (
    [UserID] INT IDENTITY(1,1) PRIMARY KEY,
    [Username] NVARCHAR(100) NOT NULL UNIQUE,
    [Email] NVARCHAR(255) NOT NULL UNIQUE,
    [PasswordHash] NVARCHAR(512) NOT NULL,
    [CreatedAt] DATETIME DEFAULT (GETDATE()) NOT NULL
);

CREATE TABLE [dbo].[Categories] (
    [CategoryID] INT IDENTITY(1,1) PRIMARY KEY,
    [CategoryName] NVARCHAR(255) NOT NULL UNIQUE,
    [Description] NVARCHAR(MAX) NULL
);

CREATE TABLE [dbo].[Suppliers] (
    [SupplierID] INT IDENTITY(1,1) PRIMARY KEY,
    [CompanyName] NVARCHAR(255) NOT NULL,
    [ContactName] NVARCHAR(255) NULL,
    [ContactEmail] NVARCHAR(255) NULL UNIQUE,
    [Phone] NVARCHAR(50) NULL
);

CREATE TABLE [dbo].[Products] (
    [ProductID] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductName] NVARCHAR(255) NOT NULL,
    [CategoryID] INT NOT NULL,
    [SupplierID] INT NOT NULL,
    [Price] DECIMAL(18,2) NOT NULL CHECK (Price >= 0),
    [StockQuantity] INT NOT NULL CHECK (StockQuantity >= 0),
    [CreatedAt] DATETIME DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE,
    CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE SET NULL
);

CREATE TABLE [dbo].[Orders] (
    [OrderID] INT IDENTITY(1,1) PRIMARY KEY,
    [UserID] INT NOT NULL,
    [OrderDate] DATETIME DEFAULT (GETDATE()) NOT NULL,
    [TotalAmount] DECIMAL(18,2) NOT NULL CHECK (TotalAmount >= 0),
    [Status] NVARCHAR(50) NOT NULL DEFAULT ('Pending'),
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE [dbo].[OrderDetails] (
    [OrderDetailID] INT IDENTITY(1,1) PRIMARY KEY,
    [OrderID] INT NOT NULL,
    [ProductID] INT NOT NULL,
    [Quantity] INT NOT NULL CHECK (Quantity > 0),
    [UnitPrice] DECIMAL(18,2) NOT NULL CHECK (UnitPrice >= 0),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Payments] (
    [PaymentID] INT IDENTITY(1,1) PRIMARY KEY,
    [OrderID] INT NOT NULL,
    [PaymentDate] DATETIME DEFAULT (GETDATE()) NOT NULL,
    [AmountPaid] DECIMAL(18,2) NOT NULL CHECK (AmountPaid >= 0),
    [PaymentMethod] NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE
);

CREATE TABLE [dbo].[Reviews] (
    [ReviewID] INT IDENTITY(1,1) PRIMARY KEY,
    [ProductID] INT NOT NULL,
    [UserID] INT NOT NULL,
    [Rating] INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    [Comment] NVARCHAR(MAX) NULL,
    [CreatedAt] DATETIME DEFAULT (GETDATE()) NOT NULL,
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    CONSTRAINT FK_Reviews_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE VIEW [dbo].[UserOrderSummary] AS
SELECT 
    u.UserID, u.Username, u.Email, 
    o.OrderID, o.OrderDate, o.TotalAmount, o.Status 
FROM [dbo].[Users] u
JOIN [dbo].[Orders] o ON u.UserID = o.UserID;
