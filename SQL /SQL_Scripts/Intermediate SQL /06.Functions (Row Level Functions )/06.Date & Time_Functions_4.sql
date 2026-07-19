/*================================================================================

	CHAPTER 3 : DATE & TIME FUNCTIONS ( FORMAT, CONVERT, CAST )

=================================================================================*/

-- A) FORMAT : Format a date or time value (Value, Format)

-- TASK 1 : Format CreationTime into various string representations

SELECT 
	orderid,
	creationTime,
	FORMAT(CreationTime,'MM-dd-yyyy') As USA_Format,
	FORMAT(CreationTime,'dd-MM-yyyy') As EURO_FORMAT,
	FORMAT(creationTime,'MM') As MM,
	FORMAT(creationTime,'MMM') As MMM,
	FORMAT(creationTime,'MMMM') As MMMM,
	FORMAT(creationTime,'dd') As dd,
	FORMAT(creationTime,'ddd') As ddd,
	FORMAT(creationTime,'dddd') As dddd
FROM sales.Orders


-- TASK 2 :Show Creation Time using Following Custom Format - Day Wed Jan Q1 2025 12.34.56 PM

SELECT
	orderid,
	creationTime,
	'Day ' + FORMAT(creationTime,'ddd MMM') + ' Q' + DATENAME(QUARTER,CreationTime) +
	' ' + FORMAT(CreationTime,'yyyy hh:mm:ss tt') AS CustomFormat
FROM Sales.Orders

-- TASK 3 : Show Order per Month using Following Formats : Jan 25

SELECT 
	FORMAT(Orderdate,'MMM yy') As OrderDate,
	count(*) As  TotalOrder
FROM Sales.Orders
GROUP BY FORMAT(Orderdate,'MMM yy')

-- B) CONVERT : Converts a Date and time value to a different Data Type & Formats the value (Data Type, Value )

-- TASK 1 : Demonstrate CONVERT for type casting and date formating

SELECT 
	CONVERT(INT,'123') As [string to Int],
	CONVERT(DATE,'2025-08-20') As [string to Date],
	creationTime,
	CONVERT(DATE,creationTime) As [DateTime to Date],
	CONVERT(varchar,CreationTime, 32) As [USA Style 32],
	CONVERT(varchar,CreationTime, 34) As [Euro Style 34]
FROM sales.Orders

-- C) CAST (Value as data_type) : CONVERT ANY DATA TYPE TO OTHER DATA TYPE ( Type Casting)

-- TASK 1 : Convert Data Types using Cast

SELECT 
	CAST('123' as INT) As [String to Int],
	CAST( 123 As varchar) As [Int to Varchar],
	CAST('2025-08-20' As Date) As [String to Date],
	CAST('2025-08-20' As DateTime2) As [String to Datetime],
	creationTime,
	CAST(creationTime As Date) As [DateTime to Date]
FROM Sales.Orders









