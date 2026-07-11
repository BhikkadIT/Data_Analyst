/*=======================================================================
	SQL DATE & TIME FUNCTIONS : (APPLY ON DATE & TIME DATA )
=========================================================================*/


-- A) EXTRACT DATE PARTS : 

-- TASK 1 : Display OrderID, CreationTime, a hard-coded date, and Today's Date 

SELECT 
	orderid,
	orderdate,
	shipdate,
	creationtime
FROM sales.Orders


SELECT 
	orderid,
	creationtime,
	'2025-08-20' As HardCoded,
	GETDATE() As Today
FROM sales.Orders


-- TASK 2 : Extract Various Parts of CreationTime

SELECT
	OrderID,
	creationTime,
------------------------------------- DateTrunc(Part, Date)---------------------------------
	DATETRUNC(YEAR,CreationTime) As year_dt,
	DATETRUNC(DAY,CreationTime) As day_dt,
	DATETRUNC(MINUTE,creationTime) As minute_dt,
	DATETRUNC(HOUR,creationTime) As hour_dt,
	DATETRUNC(SECOND,creationtime) As second_dt,
------------------------------------ DateName(Part, Date)------------------------------------
	DATENAME(MONTH,CreationTime) As Month_dn,
	DATENAME(DAY,CreationTime) As Day_dn,
	DATENAME(weekday,CreationTime) As weekday_dn,
------------------------------------ DATEPART( Part, Date) -----------------------------------
	DATEPART(YEAR,creationTime) As year_dp,
	DATEPART(MONTH,creationtime) As Month_dp,
	DATEPART(DAY,creationTime) As Day_dp,
---------------------------------- DAY, MONTH, YEAR -------------------------------------------
	YEAR(creationTime) As Year,
	Month(creationTime) As Month,
	DAY(creationtime) As Day
FROM Sales.Orders

