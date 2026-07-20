/*=============================================================================================
	CHAPTER NO : 4  : - WINDOW RANKING FUNCTIONS 
==============================================================================================*/


-- A) ROW_NUMBER() , RANK() , DENSE_RANK()

-- TASK 1 : Rank the Orders based on their Sales from highest to lowest orders (Compare All Three Ranking Functions )

select 
	orderid, productid, sales,
	row_number() over( order by sales desc ) As SalesRank_row,
	rank()       over( order by sales desc ) As SalesRank_rank,
	dense_rank() over( order by sales desc ) As SalesRank_dens
from sales.orders 

-- Task 2 : Find the Top Highest Sales for Each Prodcuts ( Top N Analysis )
select *
from (
	select
		orderid, productid, sales,
		row_number() over ( partition by productid order by sales desc ) AS RankByProduct
	from sales.orders
	) As TopProdcutSales
where RankByProduct = 1

-- Task 3 : Find the Lowest 2 Customers Based on their Total Sales
select *
from (
	select 
		customerid,
		sum(sales) As TotalSales,
		row_number() over( order by sum(sales) ) AS CustomerRank
	from sales.orders
	group by customerid
	) As BottomCustomers 
where CustomerRank <= 2 

-- Task 4 : Assign Unique ID's to the rows of the 'Orders Archive ' table

select
	ROW_NUMBER() over ( order by orderid, orderdate ) As UniqueID,
	*
from sales.OrdersArchive 

-- Task 5 : Identify the Duplicates rows from the table OrdersArchive and return a clean result without any duplicates
select *
from (
	select 
		row_number() over ( 
		partition by orderid order by creationtime desc ) as Rn,
		*
	from sales.OrdersArchive
	) As UniqueOrdersArchive
where rn = 1

-- Task 6 : Divide the Orders into 1,2,3,4 Buckets by Sales  ( NTILE() ) 

select 
	orderid, sales,
	ntile(1) over( order by sales ) As OneBucket,
	ntile(2) over( order by sales ) As TwoBucket,
	ntile(3) over( order by sales ) As ThreeBucket,
	ntile(4) over( order by sales ) As FourBucket
from sales.orders  


-- Task 7 : Segments all Orders into 3 Categories : High , Medium, Low   ( Sales )
select 
	*,
 case 
	when Bucket = 1 then 'High'
	when Bucket = 2 then 'Medium'
	when Bucket = 3 then 'Low'
 end As SalesSegmentation
 from (
	select 
		orderid, sales,
		ntile(3) over( order by sales desc ) As Bucket
	from sales.orders
 ) As SalesBuckets 

-- Task 8 : Use Cum_Dist() for RankDistribution & Percent_rank() for Percentrank 
-- for Price Distribution showing Highest Prices at top

select 
	product, price,
	cume_dist() over( order by price desc ) AS DistRank,
	percent_rank() over( order by price desc ) As PercentRank
from sales.Products   

