/*=================================================================
			CREATE TABLE AS SELECT ( CTAS ) 
===================================================================*/

-- A) CREATE CTAS : 
-- TASK 1 : Find the Total Orders Per Months Using Friendly Month Names into MonthlyOrderes Table 
-- (Use CTAS Commands)

select
	datename(month,orderdate) OrderMonth,
	count(orderid) AS TotalOrders
Into sales.MonthlyOrders
FROM sales.orders
group by datename(month,orderdate)


select * from sales.MonthlyOrders

-- How to Refresh CTAS Table 

if OBJECT_ID('sales.MonthlyOrders','U') is Not Null  -- ( T - SQL commands) 
	drop table sales.MonthlyOrders

select
	datename(month,orderdate) OrderMonth,
	count(orderid) AS TotalOrders
Into sales.MonthlyOrders
FROM sales.orders
group by datename(month,orderdate)


