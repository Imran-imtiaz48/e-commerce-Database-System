USE [master]
GO

-- Create Database
CREATE DATABASE [e-commerce_DB]
ON PRIMARY 
( NAME = N'e-commerce_DB', FILENAME = N'C:\Data\e-commerce_DB.mdf', SIZE = 8192KB, MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
LOG ON 
( NAME = N'e-commerce_DB_log', FILENAME = N'C:\Data\e-commerce_DB_log.ldf', SIZE = 8192KB, MAXSIZE = 2048GB, FILEGROWTH = 65536KB )
WITH CATALOG_COLLATION = DATABASE_DEFAULT;
GO

ALTER DATABASE [e-commerce_DB] SET COMPATIBILITY_LEVEL = 150;
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
    EXEC [e-commerce_DB].[dbo].[sp_fulltext_database] @action = 'enable';
END
GO

-- Database Options
ALTER DATABASE [e-commerce_DB] 
SET ANSI_NULL_DEFAULT OFF, 
    ANSI_NULLS OFF, 
    ANSI_PADDING OFF, 
    ANSI_WARNINGS OFF, 
    ARITHABORT OFF, 
    AUTO_CLOSE OFF, 
    AUTO_SHRINK OFF, 
    AUTO_UPDATE_STATISTICS ON, 
    CURSOR_CLOSE_ON_COMMIT OFF, 
    CURSOR_DEFAULT GLOBAL, 
    CONCAT_NULL_YIELDS_NULL OFF, 
    NUMERIC_ROUNDABORT OFF, 
    QUOTED_IDENTIFIER OFF, 
    RECURSIVE_TRIGGERS OFF, 
    DISABLE_BROKER, 
    AUTO_UPDATE_STATISTICS_ASYNC OFF, 
    DATE_CORRELATION_OPTIMIZATION OFF, 
    TRUSTWORTHY OFF, 
    ALLOW_SNAPSHOT_ISOLATION OFF, 
    PARAMETERIZATION SIMPLE, 
    READ_COMMITTED_SNAPSHOT OFF, 
    HONOR_BROKER_PRIORITY OFF, 
    RECOVERY SIMPLE, 
    MULTI_USER, 
    PAGE_VERIFY CHECKSUM, 
    DB_CHAINING OFF, 
    FILESTREAM(NON_TRANSACTED_ACCESS = OFF), 
    TARGET_RECOVERY_TIME = 60 SECONDS, 
    DELAYED_DURABILITY = DISABLED, 
    ACCELERATED_DATABASE_RECOVERY = OFF, 
    QUERY_STORE = OFF;
GO

USE [e-commerce_DB]
GO

-- Create Tables
CREATE TABLE [dbo].[Users](
    [UserID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NOT NULL,
      NOT NULL,
    [CreatedAt] [datetime] NOT NULL DEFAULT (getdate()),
    PRIMARY KEY CLUSTERED ([UserID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Orders](
    [OrderID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
    [OrderDate] [datetime] NOT NULL DEFAULT (getdate()),
    [TotalAmount] [decimal](10, 2) NOT NULL,
      NOT NULL DEFAULT ('Pending'),
    PRIMARY KEY CLUSTERED ([OrderID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Products](
    [ProductID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    [Description] [text] NULL,
    [Price] [decimal](10, 2) NOT NULL,
    [CategoryID] [int] NULL,
    [SupplierID] [int] NULL,
    PRIMARY KEY CLUSTERED ([ProductID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

CREATE TABLE [dbo].[Reviews](
    [ReviewID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [UserID] [int] NOT NULL,
    [Rating] [int] CHECK ([Rating] >= 1 AND [Rating] <= 5),
    [Comment] [text] NULL,
    PRIMARY KEY CLUSTERED ([ReviewID] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

CREATE TABLE [dbo].[Suppliers](
    [SupplierID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
      NULL,
    PRIMARY KEY CLUSTERED ([SupplierID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[OrderDetails](
    [OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
    [OrderID] [int] NOT NULL,
    [ProductID] [int] NOT NULL,
    [Quantity] [int] NOT NULL,
    [Price] [decimal](10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([OrderDetailID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Addresses](
    [AddressID] [int] IDENTITY(1,1) NOT NULL,
    [UserID] [int] NOT NULL,
      NULL,
      NULL,
      NULL,
      NULL,
      NULL,
      NULL,
    PRIMARY KEY CLUSTERED ([AddressID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Categories](
    [CategoryID] [int] IDENTITY(1,1) NOT NULL,
      NOT NULL,
    PRIMARY KEY CLUSTERED ([CategoryID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Inventory](
    [InventoryID] [int] IDENTITY(1,1) NOT NULL,
    [ProductID] [int] NOT NULL,
    [Quantity] [int] NOT NULL,
    PRIMARY KEY CLUSTERED ([InventoryID] ASC)
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Payments](
    [PaymentID] [int] IDENTITY(1,1) NOT NULL,
    [OrderID] [int] NOT NULL,
    [PaymentDate] [datetime] NOT NULL DEFAULT (getdate()),
    [Amount] [decimal](10, 2) NOT NULL,
      NULL,
    PRIMARY KEY CLUSTERED ([PaymentID] ASC)
) ON [PRIMARY];
GO

-- Create Views
CREATE VIEW [dbo].[UserOrderSummary] AS
SELECT u.Username, o.OrderID, o.OrderDate, o.TotalAmount
FROM [dbo].[Users] u
JOIN [dbo].[Orders] o ON u.UserID = o.UserID;
GO

CREATE VIEW [dbo].[ProductReviews] AS
SELECT p.Name AS ProductName, r.Rating, r.Comment
FROM [dbo].[Products] p
JOIN [dbo].[Reviews] r ON p.ProductID = r.ProductID;
GO

CREATE VIEW [dbo].[SupplierProducts] AS
SELECT s.SupplierName, p.ProductID, p.Name AS ProductName, p.Price
FROM [dbo].[Suppliers] s
JOIN [dbo].[Products] p ON s.SupplierID = p.SupplierID;
GO

CREATE VIEW [dbo].[OrderDetailsSummary] AS
SELECT o.OrderID, o.OrderDate, u.Username, p.Name AS ProductName, od.Quantity, od.Price
FROM [dbo].[Orders] o
JOIN [dbo].[OrderDetails] od ON o.OrderID = od.OrderID
JOIN [dbo].[Products] p ON od.ProductID = p.ProductID
JOIN [dbo].[Users] u ON o.UserID = u.UserID;
GO

CREATE VIEW [dbo].[UserAddressDetails] AS
SELECT u.Username, a.AddressLine1, a.AddressLine2, a.City, a.State, a.PostalCode, a.Country
FROM [dbo].[Users] u
JOIN [dbo].[Addresses] a ON u.UserID = a.UserID;
GO

CREATE VIEW [dbo].[CategoryProductCount] AS
SELECT c.CategoryName, COUNT(p.ProductID) AS ProductCount
FROM [dbo].[Categories] c
LEFT JOIN [dbo].[Products] p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;
GO

CREATE VIEW [dbo].[LowInventoryProducts] AS
SELECT p.ProductID, p.Name AS ProductName, i.Quantity
FROM [dbo].[Products] p
JOIN [dbo].[Inventory] i ON p.ProductID = i.ProductID
WHERE i.Quantity < 10;
GO

CREATE VIEW [dbo].[PendingOrders] AS
SELECT o.OrderID, o.OrderDate, u.Username, o.TotalAmount
FROM [dbo].[Orders] o
JOIN [dbo].[Users] u ON o.UserID = u.UserID
WHERE o.Status = 'Pending';
GO

-- Create Stored Procedures
CREATE PROCEDURE [dbo].[AddProductReview] 
    @ProductID INT,
    @UserID INT,
    @Rating INT,
    @Comment TEXT
AS
BEGIN
    INSERT INTO [dbo].[Reviews] (ProductID, UserID, Rating, Comment)
    VALUES (@ProductID, @UserID, @Rating, @Comment);
END;
GO

CREATE PROCEDURE [dbo].[CreateOrder] 
    @UserID INT,
    @TotalAmount DECIMAL(10,2),
    @OrderDate DATETIME = NULL
AS
BEGIN
    IF @OrderDate IS NULL
    BEGIN
        SET @OrderDate = GETDATE();
    END
    
    INSERT INTO [dbo].[Orders] (UserID, OrderDate, TotalAmount, Status)
    VALUES (@UserID, @OrderDate, @TotalAmount, 'Pending');
END;
GO
