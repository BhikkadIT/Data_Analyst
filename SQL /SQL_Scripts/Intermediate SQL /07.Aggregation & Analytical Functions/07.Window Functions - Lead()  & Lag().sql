-- Analyze the MoM (Month over Month) Performance by Finding the Percentage change 
-- in the sales between current and previours months

select 
	*,
	currentMonthsales - previousmonthsales as MOM_change,
	round(cast((CurrentMonthsales - PreviousMonthSales) as float) / PreviousMonthSales * 100,1) as MOM_perc
	from(
	select
		month(orderdate) as OrderMonth,
		sum(sales) as CurrentMonthsales,
		Lag(sum(sales)) over( order by Month(orderdate)) as PreviousMonthSales
	from sales.orders
	group by month(orderdate)
	) as MonthlySales

-- Analyze Customer Loyalty,
-- By Ranking Customers Based on the Average Number of days between Orders
select
	customerid,
	avg(daynextorder) as avgdays,
	rank() over( order by coalesce(avg(daynextorder),9999999) )  as rankavg
	from (
	select
		orderid, customerid, 
		orderdate as currentorder,
		lead(orderdate) over( partition by customerid order by orderdate ) as NextOrder,
		datediff( day,orderdate, lead(orderdate)  
		over( partition by customerid order by orderdate )) as DayNextOrder
	from sales.orders 
	) as CustomersorderswithNext
group by customerid 


-- Find the Lowest and Highest Sales for each products.
-- Find the Difference in sales Between the Current and the Lowest Sales

select
	orderid, productid, sales,
	min(sales) over( partition by productid ) as MinSales,
	max(sales) over( partition by productid ) as maxsales,
	first_value(sales) over ( partition by productid order by sales ) as lowestSales,
	last_value(sales) over ( partition by productid order by sales 
	rows between current row and unbounded following) as highestsales,
	sales - first_value(sales) over( partition by productid order by sales ) as SalesDifference
from sales.orders 
