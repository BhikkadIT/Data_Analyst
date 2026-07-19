/*============================================================================
	CHAPTER NO : 4  SQL WINDOW AGGREGATION FUNCTIONS 
==============================================================================*/

-- A) COUNT FUNCTIONS :

-- TASK 1 : Find the Total No of Orders 
-- Find the Total No of Orders for each Customers
-- Additionaly Provide Details Such as Order ID, Order Date

select
	orderid,orderdate,customerid,
	count(*) over() as Total_Orders,
	count(*) over(partition by customerid ) as OrdersByCustomerID
from sales.orders 

-- Task 2 : Find the Total No. of Customers
-- Find the Total No of Scores for the Customers
-- Find the Total No of Countries for the Customers
-- Additionaly provide all customers details

select 
	*,
	count(*) over() as total_customers,
	count(score) over() as Total_score,
	count(country) over() as total_country
from sales.Customers

-- Task 3 : Check Whether the table OrdersArchive Contains any Duplicate Rows
select *
from (
	select
		orderid,
		count(*) over( partition by orderid ) as CheckDuplicates
	from sales.OrdersArchive
	) as t
where CheckDuplicates > 1

-- B) SUM FUNCTIONS : 

-- Task 4 : Find the Total Sales for all Orders
-- Find the Total Sales  for each Product
-- Additionaly Provide Details Such as Order ID, Order Date

select 
	orderid, orderdate, sales, productid,
	sum(sales) over() As TotalSales,
	sum(sales) over( partition by productid ) As SalesByProduct
from sales.orders

-- Task 5 : Find the % Contribution of each Products Sales to the total Sales

select 
	orderid, productid,sales,
	sum(sales) over() As TotalSales,
	round(cast(sales as Float) / sum(sales) over() * 100,2) As PercentageofTotalSales
from sales.orders 

-- C) AVG FUNCTIONS : 

-- Task 6 : Find the Average Sales for all Orders
-- Find the Average Sales  for each Product
-- Additionaly Provide Details Such as Order ID, Order Date

select
	orderid, orderdate, sales, productid,
	avg(sales) over() As AvgSales,
	avg(sales) over( partition by productid ) As AvgSalesByProduct
from sales.orders 


-- Task 7 : Find the Average Scores of the Customers ( with & Without Nulls )
-- Additionaly provide details such as Customer ID and LastName

select
	customerid, lastname, score,
	coalesce(score,0) As CustomerScore,
	avg(score) over() As AvgScore,
	avg(coalesce(score,0)) over() As AvgScorewthoutNull
from sales.customers

-- Task 8 : Find all orders where sales are higher than the avg sales across all orders
select *
from (
	select
		orderid,productid,sales,
		avg(sales) over() As AvgSales
	from sales.orders 
	) As t
where sales > AvgSales


-- D) MIN / MAX FUNCTIONS :

-- Task 10: Find the Highest and Lowest sales for all Orders
-- Find the Highest and Lowest sales for each Products
-- Additionaly provide details such as OrderID and Order Date

select
	orderid,productid, orderdate, sales,
	max(sales) over() As HighestSales,
	min(sales) over() AS LowestSales,
	max(Sales) over( partition by productid ) As MaxSalesByProduct,
	min(sales) over( partition by productid ) As MinSalesByProdcut
from sales.orders 

-- Task 11 : Show the Employees who have highest salaries
select *
from (
	select 
		*,
		max(salary) over() As HighestSalary
	from sales.Employees
	) As t
where salary = HighestSalary

-- Task 12 : Find the deviation of each sales from the Minimum & Maximum Amounts 

select
	orderid, orderdate, productid, sales,
	max(sales) over() As HighestSales,
	min(Sales) over() AS LowestSales,
	sales - min(sales) over() As DeviationFromMin,
	max(sales) over() - sales As DeviationFromMax
from sales.orders 

-- Task 13 : Calculate Moving Averages of Sales for each Prodcuts over time (Running Average) 

select 
	orderid, productid,orderdate, sales,
	avg(sales) over( partition by productid ) As AvgByProdcut,
	avg(sales) over( partition by productid order by orderdate ) As MovingAvg
from sales.orders 

-- Task 14 : Calculate Moving Average of Sales for each Product Over Time, Including Only the Next Order

select 
	orderid, productid,orderdate, sales,
	avg(sales) over( partition by productid ) As AvgByProdcut,
	avg(sales) over( partition by productid order by orderdate 
	rows between current row and 1 following ) As MovingAvg
from sales.orders 













