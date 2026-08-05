
USE SalesDB;

Create Schema Sales;

ALTER SCHEMA sales TRANSFER dbo.Customers;
ALTER SCHEMA sales TRANSFER dbo.Employees;
ALTER SCHEMA sales TRANSFER dbo.Orders;
ALTER SCHEMA sales TRANSFER dbo.OrdersArchive;
ALTER SCHEMA sales TRANSFER dbo.Products;


