# E-Commerce-Database-System
Overview
This database system is designed to manage an e-commerce platform. It covers various aspects such as user management, product cataloging, orders, payments, reviews, addresses, and inventory management. The schema consists of ten interrelated tables, along with stored procedures and views to facilitate data operations and reporting.

Database Tables and Relationships
Users Table

Purpose: To store user account information.
Primary Key: UserID
Related Tables: Orders, Reviews, Addresses
Categories Table

Purpose: To store product categories.
Primary Key: CategoryID
Related Tables: Products
Suppliers Table

Purpose: To store supplier information.
Primary Key: SupplierID
Related Tables: Products
Products Table

Purpose: To store product details.
Primary Key: ProductID
Related Tables: OrderDetails, Reviews, Inventory
Foreign Keys: CategoryID, SupplierID
Orders Table

Purpose: To store order information.
Primary Key: OrderID
Related Tables: OrderDetails, Payments
Foreign Key: UserID
OrderDetails Table

Purpose: To store detailed information about each product in an order.
Primary Key: OrderDetailID
Related Tables: Orders, Products
Foreign Keys: OrderID, ProductID
Payments Table

Purpose: To store payment information for orders.
Primary Key: PaymentID
Related Tables: Orders
Foreign Key: OrderID
Reviews Table

Purpose: To store user reviews for products.
Primary Key: ReviewID
Related Tables: Products, Users
Foreign Keys: ProductID, UserID
Addresses Table

Purpose: To store addresses associated with users.
Primary Key: AddressID
Related Tables: Users
Foreign Key: UserID
Inventory Table

Purpose: To store inventory levels for products.
Primary Key: InventoryID
Related Tables: Products
Foreign Key: ProductID
Stored Procedures
GetUserOrders

Purpose: Retrieve orders for a specific user.
Parameters: @userId INT
GetProductInventory

Purpose: Retrieve the inventory quantity for a specific product.
Parameters: @productId INT
AddProductReview

Purpose: Add a new review for a product.
Parameters: @productId INT, @userId INT, @rating INT, @comment TEXT
UpdateOrderStatus

Purpose: Update the status of an order.
Parameters: @orderId INT, @status VARCHAR(50)
Views
UserOrderSummary

Purpose: Provides a summary of user orders, showing username, order ID, order date, and total amount.
Base Tables: Users, Orders
ProductReviews

Purpose: Lists product reviews, showing product name, rating, and comments.
Base Tables: Products, Reviews
SupplierProducts

Purpose: Lists all products supplied by each supplier, showing supplier name, product ID, product name, and price.
Base Tables: Suppliers, Products
OrderDetailsSummary

Purpose: Provides a summary of order details including order ID, order date, username, product name, quantity, and price.
Base Tables: Orders, OrderDetails, Products, Users
Usage
User Management: Handles user registrations, storing credentials, and contact information.
Product Management: Organizes products into categories, tracks suppliers, manages product details, and inventory levels.
Order Processing: Records orders, order details, and payment information. Allows updating order statuses.
Customer Feedback: Collects and stores reviews for products.
Address Management: Stores multiple addresses for users for order delivery purposes.
Reporting: Provides views for summarizing orders, reviews, supplier products, and detailed order information.
This database system is designed to be robust, ensuring data integrity through the use of primary and foreign keys, and facilitating efficient data retrieval and manipulation through stored procedures and views.
