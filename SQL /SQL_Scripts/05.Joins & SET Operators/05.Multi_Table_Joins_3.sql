/*==========================================================================

	MULTI TABLE JOINS (4 TABLES ) USING LEFT JOIN  ( DATA MODELLING )

============================================================================*/

-- TASK : Using SalesDB, retrive a list of all orders with related customers, product, 
-- and Employee details. Display :Order ID, Customer name, Product name, Sales Amount, 
-- Product Price, Salesperson name.

USE SalesDB;

SELECT 
	O.OrderID,
	O.Sales,
	C.FirstName AS CustomerFirstName,
	C.LastName AS CustomerLastName,
	P.Product AS ProductName,
    P.Price,
	E.FirstName AS EmployeeFirstName,
	E.LastName AS EmployeeLastName
FROM Sales.Orders AS O
LEFT JOIN Sales.Customers AS C
	ON O.CustomerID = C.CustomerID
LEFT JOIN Sales.Products AS P
	ON O.ProductID = P.ProductID
LEFT JOIN Sales.Employees AS E
	ON O.SalesPersonID = E.EmployeeID
