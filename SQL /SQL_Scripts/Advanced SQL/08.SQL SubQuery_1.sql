/*=======================================================================================================
			ADVANCE  SQL TECHNIQUES : ( 1. SUBQUERY )
========================================================================================================*/

-- A) RESULT TYPE SUBQUERY :  SCALER SUBQUERY , ROW SUBQUERY , TABLE SUBQUERY 

-- TASK 1 :  RETURN A SINGLE VALUE (SCALER SUBQUERY - Return Single value in Result  )

select avg(sales) from sales.orders 

-- Task 2 : Return a Single Column of Values ( Row Subquery - Multiple Rows and Single Column )

select 
	customerid
from sales.orders 

-- Task 3 : Return Multiple columns and rows ( Table SubQuery - Multiple rows and Multiple Columns )

select
	orderid,
	orderdate
from sales.orders 

-- B) SUBQUERY ( LOCATION | CLAUSES ) : 

-- a) FROM CLAUSE : 

-- TASK 1 : Find the Prodcuts that have price higher than the average price of all products

-- Main Query :
select 
	*
from
-- SubQuery
	( select
		productid,
		price,
		avg(price) over() as Avg_price
	from sales.products 
	) t
where price > Avg_price

-- Task 2 : Rank Customers based on their total amount of sales

-- Main Query 
select 
	*,
	rank() over( order by totalSales desc ) as Customer_rank
from 
-- SubQuery
	(select
		customerid,
		sum(sales) As totalSales
	from sales.orders 
	group by customerid
	) t

-- b) SELECT CLAUSE : 

-- TASK 3 :Show the product id , product names, prices, and total no. of orders 

select
	productid,
	product,
	price,
	(select count(*) from sales.orders) As TotalOrders
from sales.products 

-- C) Join Clause : 

-- Task 4 : Show all customer details with their total sales

select
	c.*,
	t.Totalsales
from sales.customers as c
left join 
-- Sub Query 
	(select
		customerid,
		sum(sales) As TotalSales
	from sales.orders
	group by customerid 
	) t
on c.customerid = t.CustomerID

-- Task 5 : Show all Customer Details and find the total orders of each customer
-- Main Query 
select
	c.*,
	o.TotalOrders
from sales.customers as c
left join 
-- SubQuery 
	(select
		customerid,
		count(*) as  TotalOrders
	from sales.orders 
	group by customerid 
	) As o
on c.customerid = o.customerid 

-- Task 6 : Find the Prodcuts that have price higher than the average price of all products
-- Main Query 
select
	productid,
	price,
-- SubQyery 
	(select avg(price) from sales.products) AS avg_price
from sales.Products
where price > (select avg(price) from sales.products) 

-- Task 7 : Show the Details of Orders Made by the Customer in Germany

-- Main Query
select *
from sales.orders 
where customerid IN (
-- Sub Query 
			select
				customerid
			from sales.customers
			where country = 'Germany'
			)

-- Task 8 : Show the Details of Orders Made by the Customer Not in Germany

select *
from sales.orders 
where customerid IN  (
-- Sub Query 
			select
				customerid
			from sales.customers
			where country != 'Germany'
			)

-- Task 9 : Find the Female Employees Whose Salaries are Greater than the salaries of any male Employees (Any Operator ) 
select 
	EmployeeID,
	firstName,
	salary
from sales.employees 
where Gender = 'F'
and salary > any (
	select
		salary 
	from sales.Employees
	where Gender = 'M'
	)

-- Task 10 : Show all Customer Details and find the total orders for each Customers
-- Correlated SubQuery 

-- Main Query 
select 
	*,
-- SubQuery
 (select count(*)
 from sales.orders as o
 where o.customerid = c.customerid
 ) as TotalOrders 
from sales.customers as c

-- Task 11 : Show the Order Details for Customers in Germany 
-- Correlated SubQuery 
-- Main Query 
select *
from sales.orders as o
where exists (
-- SubQuery 
		select
			*
		from sales.customers as c
		where country = 'Germany'
		and o.customerid = c.customerid
		)

-- Non Correlated SubQuery 
select
	*
from sales.orders 
where customerid IN
			( select
				customerid
			from sales.customers 
			where country = 'Germany'
			)







	


