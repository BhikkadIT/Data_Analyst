/*===========================================================================================
			Advance SQL Techniques : VIEW 
=============================================================================================*/

-- TASK 1 : Find the Running Total Sales for each Months

-- Create View --

CREATE VIEW sales.V_Monthly_Summary As (
select
	datetrunc(month,orderdate) AS OrderMonth,
	sum(sales) AS TotalSales,
	count(orderid) AS TotalOrders,
	sum(quantity) AS TotalQuantities
from sales.orders 
group by datetrunc(month,orderdate)
)

-- Query the View 
select * from sales.V_Monthly_Summary

-- Use View in the Query --
select
	ordermonth,
	totalSales,
	sum(totalSales) over( order by OrderMonth) As Running_Total_Sales
from sales.V_Monthly_Summary

-- Drop the View
if object_id ('sales.V_Monthly_Summary','V') IS NOT NULL  -- ( T- SQL Commands ) 
	DROP VIEW Sales.V_Monthly_Summary

-- Recreate with Modified Logic (few Columns)

CREATE VIEW sales.V_Monthly_Summary As (
select
	datetrunc(month,orderdate) AS OrderMonth,
	sum(sales) AS TotalSales,
	count(orderid) AS TotalOrders
from sales.orders 
group by datetrunc(month,orderdate)
)

-- Task 2 : Create the View that join Orders, Products, Customers and Employees 
-- into one clean view  ( Hide Complexity ) 

CREATE VIEW sales.V_Order_Details As (
select 
	O.orderid,
	O.orderdate,
	P.product,
	P.category,
	coalesce(C.FirstName,'')+ ' ' + coalesce(C.LastName,'') as CustomerName,
	C.country,
	E.Department,
	coalesce(E.FirstName,'') + ' ' + coalesce(E.LastName,'') as SalesPersonName
from sales.orders As O
left join sales.Products As P
on P.productid = O.productid 
left join sales.customers As C
on C.customerid = O.CustomerID
left join sales.Employees AS E
on E.EmployeeID = O.SalesPersonID
)

-- Query the View ---
select * from sales.V_Order_Details

-- Task 3 : Provide the View for EU Sales Team 
-- that Combine Details from all Tables
-- and Excludes data related to the USA ( Security usecase ) 

CREATE VIEW sales.V_Order_Details_EU As (
select 
	O.orderid,
	O.orderdate,
	P.product,
	P.category,
	coalesce(C.FirstName,'')+ ' ' + coalesce(C.LastName,'') as CustomerName,
	C.country,
	E.Department,
	coalesce(E.FirstName,'') + ' ' + coalesce(E.LastName,'') as SalesPersonName
from sales.orders As O
left join sales.Products As P
on P.productid = O.productid 
left join sales.customers As C
on C.customerid = O.CustomerID
left join sales.Employees AS E
on E.EmployeeID = O.SalesPersonID
Where C.Country != 'USA'
)

-- Query the View --
select * from sales.V_Order_Details_EU







