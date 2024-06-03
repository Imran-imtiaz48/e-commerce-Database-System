USE [master]
GO
/****** Object:  Database [e-commerce_DB]    Script Date: 6/3/2024 9:26:15 AM ******/
CREATE DATABASE [e-commerce_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'e-commerce_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\e-commerce_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'e-commerce_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS03\MSSQL\DATA\e-commerce_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [e-commerce_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [e-commerce_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [e-commerce_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [e-commerce_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [e-commerce_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [e-commerce_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [e-commerce_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [e-commerce_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [e-commerce_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [e-commerce_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [e-commerce_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [e-commerce_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [e-commerce_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [e-commerce_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [e-commerce_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [e-commerce_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [e-commerce_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [e-commerce_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [e-commerce_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [e-commerce_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [e-commerce_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [e-commerce_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [e-commerce_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [e-commerce_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [e-commerce_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [e-commerce_DB] SET  MULTI_USER 
GO
ALTER DATABASE [e-commerce_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [e-commerce_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [e-commerce_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [e-commerce_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [e-commerce_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [e-commerce_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [e-commerce_DB] SET QUERY_STORE = OFF
GO
USE [e-commerce_DB]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[CreatedAt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[OrderDate] [datetime] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserOrderSummary]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create Views

-- UserOrderSummary: Summary of user orders
CREATE VIEW [dbo].[UserOrderSummary] AS
SELECT u.Username, o.OrderID, o.OrderDate, o.TotalAmount
FROM Users u
JOIN Orders o ON u.UserID = o.UserID;
GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [text] NULL,
	[Price] [decimal](10, 2) NOT NULL,
	[CategoryID] [int] NULL,
	[SupplierID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reviews]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reviews](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[UserID] [int] NULL,
	[Rating] [int] NULL,
	[Comment] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ProductReviews]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ProductReviews: List of product reviews
CREATE VIEW [dbo].[ProductReviews] AS
SELECT p.Name AS ProductName, r.Rating, r.Comment
FROM Products p
JOIN Reviews r ON p.ProductID = r.ProductID;
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [varchar](100) NOT NULL,
	[ContactEmail] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SupplierProducts]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SupplierProducts: List all products supplied by each supplier
CREATE VIEW [dbo].[SupplierProducts] AS
SELECT s.SupplierName, p.ProductID, p.Name AS ProductName, p.Price
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID;
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[OrderDetailsSummary]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- OrderDetailsSummary: Summary of order details including product names and quantities
CREATE VIEW [dbo].[OrderDetailsSummary] AS
SELECT o.OrderID, o.OrderDate, u.Username, p.Name AS ProductName, od.Quantity, od.Price
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
JOIN Users u ON o.UserID = u.UserID;
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[AddressLine1] [varchar](100) NULL,
	[AddressLine2] [varchar](100) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[PostalCode] [varchar](20) NULL,
	[Country] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[PaymentDate] [datetime] NULL,
	[Amount] [decimal](10, 2) NOT NULL,
	[PaymentMethod] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reviews]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[AddProductReview]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- AddProductReview: Add a new review for a product
CREATE PROCEDURE [dbo].[AddProductReview] @productId INT, @userId INT, @rating INT, @comment TEXT
AS
BEGIN
    INSERT INTO Reviews (ProductID, UserID, Rating, Comment)
    VALUES (@productId, @userId, @rating, @comment);
END;
GO
/****** Object:  StoredProcedure [dbo].[GetProductInventory]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- GetProductInventory: Retrieve the inventory quantity for a specific product
CREATE PROCEDURE [dbo].[GetProductInventory] @productId INT
AS
BEGIN
    SELECT p.Name, i.Quantity
    FROM Products p
    JOIN Inventory i ON p.ProductID = i.ProductID
    WHERE p.ProductID = @productId;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUserOrders]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create Stored Procedures

-- GetUserOrders: Retrieve orders for a specific user
CREATE PROCEDURE [dbo].[GetUserOrders] @userId INT
AS
BEGIN
    SELECT o.OrderID, o.OrderDate, o.TotalAmount, p.Name AS ProductName, od.Quantity, od.Price
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.UserID = @userId;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 6/3/2024 9:26:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- UpdateOrderStatus: Update the status of an order
CREATE PROCEDURE [dbo].[UpdateOrderStatus] @orderId INT, @status VARCHAR(50)
AS
BEGIN
    UPDATE Orders
    SET Status = @status
    WHERE OrderID = @orderId;
END;
GO
USE [master]
GO
ALTER DATABASE [e-commerce_DB] SET  READ_WRITE 
GO
