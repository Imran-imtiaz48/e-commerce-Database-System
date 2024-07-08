## E-Commerce-Database-System

### Overview
The E-Commerce-Database-System is crafted to manage a comprehensive e-commerce platform, encompassing user management, product cataloging, order processing, payment handling, customer reviews, address management, and inventory control. Its schema comprises ten interconnected tables, complemented by stored procedures and views that streamline data operations and reporting.

### Database Tables and Relationships

#### Users Table
- **Purpose**: Stores user account details.
- **Primary Key**: `UserID`
- **Related Tables**: Orders, Reviews, Addresses

#### Categories Table
- **Purpose**: Manages product categories.
- **Primary Key**: `CategoryID`
- **Related Tables**: Products

#### Suppliers Table
- **Purpose**: Stores supplier information.
- **Primary Key**: `SupplierID`
- **Related Tables**: Products

#### Products Table
- **Purpose**: Contains detailed product information.
- **Primary Key**: `ProductID`
- **Related Tables**: OrderDetails, Reviews, Inventory
- **Foreign Keys**: `CategoryID`, `SupplierID`

#### Orders Table
- **Purpose**: Records order details.
- **Primary Key**: `OrderID`
- **Related Tables**: OrderDetails, Payments
- **Foreign Key**: `UserID`

#### OrderDetails Table
- **Purpose**: Stores specifics of each product within an order.
- **Primary Key**: `OrderDetailID`
- **Related Tables**: Orders, Products
- **Foreign Keys**: `OrderID`, `ProductID`

#### Payments Table
- **Purpose**: Manages payment transactions.
- **Primary Key**: `PaymentID`
- **Related Tables**: Orders
- **Foreign Key**: `OrderID`

#### Reviews Table
- **Purpose**: Stores customer reviews on products.
- **Primary Key**: `ReviewID`
- **Related Tables**: Products, Users
- **Foreign Keys**: `ProductID`, `UserID`

#### Addresses Table
- **Purpose**: Records user addresses.
- **Primary Key**: `AddressID`
- **Related Tables**: Users
- **Foreign Key**: `UserID`

#### Inventory Table
- **Purpose**: Tracks product inventory levels.
- **Primary Key**: `InventoryID`
- **Related Tables**: Products
- **Foreign Key**: `ProductID`

### Stored Procedures

#### GetUserOrders
- **Purpose**: Retrieves orders for a specific user.
- **Parameters**: `@userId INT`

#### GetProductInventory
- **Purpose**: Fetches the inventory quantity for a specific product.
- **Parameters**: `@productId INT`

#### AddProductReview
- **Purpose**: Adds a new review for a product.
- **Parameters**: `@productId INT`, `@userId INT`, `@rating INT`, `@comment TEXT`

#### UpdateOrderStatus
- **Purpose**: Updates the status of an order.
- **Parameters**: `@orderId INT`, `@status VARCHAR(50)`

#### AddProduct
- **Purpose**: Adds a new product to the catalog.
- **Parameters**: `@Name VARCHAR(100)`, `@Description TEXT`, `@Price DECIMAL(10, 2)`, `@CategoryID INT`, `@SupplierID INT`

#### UpdateProduct
- **Purpose**: Updates details of an existing product.
- **Parameters**: `@ProductID INT`, `@Name VARCHAR(100)`, `@Description TEXT`, `@Price DECIMAL(10, 2)`, `@CategoryID INT`, `@SupplierID INT`

#### DeleteProduct
- **Purpose**: Removes a product from the catalog.
- **Parameters**: `@ProductID INT`

#### AddOrder
- **Purpose**: Creates a new order.
- **Parameters**: `@UserID INT`, `@TotalAmount DECIMAL(10, 2)`

#### AddOrderDetail
- **Purpose**: Adds a detail to an existing order.
- **Parameters**: `@OrderID INT`, `@ProductID INT`, `@Quantity INT`, `@Price DECIMAL(10, 2)`

### Views

#### UserOrderSummary
- **Purpose**: Provides a summary of user orders, displaying username, order ID, order date, and total amount.
- **Base Tables**: Users, Orders

#### ProductReviews
- **Purpose**: Lists product reviews, showing product name, rating, and comments.
- **Base Tables**: Products, Reviews

#### SupplierProducts
- **Purpose**: Lists products supplied by each supplier, showing supplier name, product ID, product name, and price.
- **Base Tables**: Suppliers, Products

#### OrderDetailsSummary
- **Purpose**: Provides a detailed summary of order details including order ID, order date, username, product name, quantity, and price.
- **Base Tables**: Orders, OrderDetails, Products, Users

### Usage
- **User Management**: Facilitates user registration, credential storage, and contact details.
- **Product Management**: Organizes products into categories, manages suppliers, tracks product details, and monitors inventory.
- **Order Processing**: Records orders, manages order details, tracks payment transactions, and updates order statuses.
- **Customer Feedback**: Captures and stores product reviews provided by customers.
- **Address Management**: Maintains multiple addresses per user for accurate order deliveries.
- **Reporting**: Utilizes views to generate reports summarizing orders, product reviews, supplier products, and detailed order information.

This database system ensures robust data integrity through primary and foreign key relationships, supporting efficient data retrieval and manipulation via stored procedures and views.
