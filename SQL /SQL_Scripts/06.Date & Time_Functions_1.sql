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


-- TASK 2 : Aggregate Orders by Year using DateTrunc

SELECT 
	DATETRUNC(YEAR,CreationTime) AS Creation,
	COUNT(*) As OrderCount
FROM Sales.Orders
GROUP BY DATETRUNC(YEAR,CreationTime)

-- EOMONTH : (FIND END DATE OF MONTH )

-- TASK 1 : Display the end-of-month date for each order's creation Time

SELECT
	Orderid,
	creationTime,
	EOMONTH(creationTime) As EndofMonth,
	CAST(DATETRUNC(MONTH,CreationTime) AS DATE) As StartOfMonth
FROM Sales.Orders


-- TASK 2 : How Many Orders were placed each Year?

SELECT 
	YEAR(OrderDate) As OrderYear,
	COUNT(*) As TotalOrder
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

-- TASK 3 : How Many Orders were placed each Month?

SELECT 
	MONTH(OrderDate) As OrderMonth,
	COUNT(*) As TotalOrder
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- TASK 3 : Show Order Per Month using Friendly Month names

SELECT 
	DATENAME(MONTH,OrderDate) AS OrderMonth,
	COUNT(*) As TotalOrder
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate)

-- Task 4 : Show all Orders Placed in February

SELECT *
FROM Sales.Orders
WHERE Month(OrderDate) = 2






