/*==========================================================================================================
 CHAPTER NO  4 : AGGREGATION & ANALYTICAL FUNCTIONS :
 ==========================================================================================================*/

 -- A) COUNT FUNCTION : 

 -- TASK 1 : Find the total number of customers 

 select 
	count(*) as total_customers
 from sales.Customers

 -- B) SUM FUNCTION : 

 -- TASK 1 : Find the total sales of all orders 

 select 
	sum(sales) as total_sales
 from sales.orders

 -- C) AVG FUNCTION :

 -- TASK 1 : Find average sales of all orders 

 select 
	avg(sales) as avg_sales
 from sales.orders

 -- D) MAX FUNCTION : 

 -- TASK 1 : Find the highest scores among customers 

 select 
	max(score) as Max_Score
 from sales.Customers

 -- E) MIN FUNCTION : 

 -- TASK 1 : Find the lowest scores among customers

 select
	min(score) as Min_Score
 from sales.Customers

 -- Task : GROUP BY ( GROUPED AGGREGATION )

 -- Find Orders, total_sales, avg_sales, highest and lowest sales per customer

 select 
	CustomerID,
	count(*) as Total_Orders,
	sum(sales) as Total_Sales,
	avg(sales) as avg_sales,
	max(sales) as max_sales,
	min(sales) as min_sales
 from sales.orders
 group by CustomerID

 