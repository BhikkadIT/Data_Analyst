/*=============================================================================
		TEMPORARY TABLE ( TEMP TABLE ) :
===============================================================================*/

-- USE CASE : DATA MIGRATION ( DATA TRANSFORMATION ) USING A TEMP TABLE

-- a) CREATE TEMP TABLE (#Orders)  ( Extract - E) 

select *
into #Orders 
from sales.orders 

-- Clean Data in the Temporary table  (Transformation - T ) 

delete from #Orders
where orderstatus = 'Delivered'

-- Load Cleaned Data into Permanent Table  (Load - L) 

select *
into sales.OrdersTest
from #Orders



select * from sales.OrdersTest
