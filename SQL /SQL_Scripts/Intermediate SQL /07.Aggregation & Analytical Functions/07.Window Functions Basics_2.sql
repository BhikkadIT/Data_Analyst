/*===========================================================================
	WINDOW FUNCTIONS : ( BASIC WINDOW FUNCTIONS - AGGREGATION FUNCTIONS )
============================================================================*/

-- TASK 1 : Find the Total Sales across all Orders
select 
	sum(sales) as Total_Sales
from sales.orders

-- Task 2 : Total Sales for Each Product (Group by)

select 
	productid,
	sum(sales) as Total_sales
from sales.orders
group by productid

-- Task 3 : Find the Total Sales across all Orders  ( Over Clause )

select 
	orderid,
	orderdate,
	ProductID,
	sales,
	sum(sales) over() as Total_sales
from sales.orders

-- Task 4 : Find the Total Sales for Each Product, Additionaly Provide Details such as Order Id and Order Date
-- (Partition By Clause)

select 
orderid,
orderdate,
productid,
sales,
sum(sales) over() As Total_Sales,
sum(sales) over( partition by productid ) As product_by_sales
from sales.orders

-- Task 5 : Find the Total Sales overall, Per Product, and per Prodcut + Order Status

select 
orderid,
productid,
orderdate,
sales,
Orderstatus,
sum(sales) over() As Total_Sales,
sum(sales) over( partition by productid) As totalSales_by_product,
sum(sales) over( partition by productid, orderstatus) As totalSales_by_Prodcut_status
from sales.Orders

-- Task 6 : Rank  Each Order Based on  Their Sales, from Highest to Lowest Additionaly provide details such as Order ID & Order Date

select 
	orderid,orderdate,sales,
	rank() over( order by sales desc ) as rank_sales 
from sales.orders

-- Task 7 : Running Total Current Row and Next Two Rows (order by order date, for each orderstatus )

select
	orderid, orderdate, orderstatus, sales,
	sum(sales) over(
	partition by orderstatus
	order by orderdate
	rows between current row and 2 following ) As total_sales
from sales.orders

-- Task 8 : Rolling Total Previous 2 rows and current row (order by order date, for each orderstatus )

select
	orderid,orderdate, orderstatus,sales,
	sum(sales) over(
	partition by orderstatus
	order by orderdate
	rows between 2 preceding and current row ) As Total_sales
from sales.orders

-- Task 9 : Previous 2 rows only (order by order date, for each orderstatus )

select
	orderid, orderdate,orderstatus,sales,
	sum(sales) over(
	partition by orderstatus
	order by orderdate
	rows 2 preceding ) AS Total_sales
from sales.Orders

-- Task 10 : Cummulative Total from start to current Row (order by order date, for each orderstatus )

select 
	orderid, orderdate, orderstatus, sales,
	sum(sales) over(
	partition by orderstatus
	order by orderdate
	rows between unbounded preceding and current row ) As Total_sales
from sales.orders 

-- Task 11 : find the Total Sales for Each Order Status only for the two products 101 and 102.
-- ( Window Fucnctions After Where Clause )

select
	orderid, orderdate, orderstatus, productid, sales,
	sum(sales) over(
	partition by orderstatus
	) As Total_sales
from sales.orders
where productid in (101,102)

-- Task 12 : Rank Customers based on their total sales
--  Window Functions with Group by Clause

select
	customerid,
	sum(sales) As total_sales,
	rank() over( order by sum(sales) desc ) As Rank_Customer
from sales.orders
group by customerid 

-- Rule 1 : Window Functions can only be used in select and order by clauses

select 
	orderid , sales,
	sum(sales) over( partition by orderstatus ) As Total_sales
from sales.orders
where sum(sales) over( partition by orderstatus ) > 100

-- Rule 2 : Nested Window Functions is not allowed 

select
	sum ( sum(sales) over( partition by orderstatus)) over( partition by orderstatus)
from sales.orders










