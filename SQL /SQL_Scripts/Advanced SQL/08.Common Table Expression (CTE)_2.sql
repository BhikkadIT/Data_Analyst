/*=================================================================================================
			ADVANCE SQL TECHNIQUES : ( SQL COMMON TABLE EXPRESSIONS - CTE )
===================================================================================================*/

-- TYPES OF CTE : A) NON RECURSIVE CTE  B) RECURSIVE CTE 

-- A) NON RECURSIVE CTE : a) Standalone CTE b) Nested CTE 

-- Mini Project : 
-- step 1 : Find the Total Sales Per Customers ( Use Standalone CTE )

WITH CTE_Total_Sales As (
	select
		customerid,
		sum(sales)  As TotalSales
	from sales.orders 
	group by customerid
	)
-- Step 2 : Find the Last Order date for each Customers
	, CTE_Last_Order As (
	select
		customerid,
		max(orderdate) As Last_order
	from sales.orders
	group by customerid
	)
-- Step 3 : Rank  Customers Based on total Sales Per Customers  (Nested CTE ) 
   , CTE_Customer_Rank AS (
	select
		customerid,
		TotalSales,
		rank() over(order by TotalSales desc  ) As Customer_Rank
	from CTE_Total_Sales
	)
-- step 4 : Segments the Customers Based on Their Total Sales
	, CTE_Customer_Segments As (
	select
		customerid,
		TotalSales,
		case
			when TotalSales > 100 then 'High'
			when TotalSales > 80  then 'Medium'
			else 'Low'
		end As CustomerSegments
	from CTE_Total_Sales
   )
-- Main Query ---------------------
select 
	c.customerid,c.FirstName,c.LastName,
	cts.TotalSales,
	clo.Last_order,
	ccr.Customer_Rank,
	ccs.CustomerSegments
from sales.customers as c
left join CTE_Total_sales As cts
on cts.customerid = c.customerid
left join CTE_Last_order As clo
on clo.customerid = c.customerid
left join CTE_Customer_Rank As ccr
on ccr.customerid = c.customerid
left join CTE_Customer_Segments As ccs
on ccs.customerid = c.customerid 
order by totalSales desc;

-- B ) Recursive CTE : 

-- Task 1 : Generate a Sequence of Numbers from 1 to 20
  With Series As (
	-- Anchor Query
	select 1 As MyNumber
	UNION ALL
	-- Recursive Query 
	select MyNumber + 1
	from Series
	where MyNumber < 1000
	)
-- Main Query -----------------------------------
select *
from Series
option(MaxRecursion 5000);


