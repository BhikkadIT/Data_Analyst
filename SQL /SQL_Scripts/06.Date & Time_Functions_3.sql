/*================================================================================
		CHAPTER 3 : DATE & TIME FUNCTIONS ( DATEADD, DATEDIFF , ISDATE)
==================================================================================*/

-- A) DATEADD: add or subtract as specific time interval to\from a date 
--    SYNATX : DATEADD(part, interval, date)

-- TASK 1 : Perform Date Arithmatic on OrderDate (Before 10 Days, After three Months, After 2 Years)

SELECT 
	orderid,
	orderdate,
	DATEADD(DAY,-10,orderdate) As TenDaysBefore,
	DATEADD(month,3,orderdate) As ThreeMonthsLater,
	DATEADD(year,2,orderdate) As TwoYearsLater
FROM Sales.Orders


-- B) DateDiff: Find the Difference between two dates (Part, Starting Date, End Date)

-- TASK 1 : Calculate the Age of Employees in the year

SELECT 
	EmployeeID,
	BirthDate,
	DATEDIFF(year,BirthDate,GETDATE() ) As Age
FROM Sales.Employees

-- TASK 2 : Find the Average Shipping duration in days for each months

SELECT 
	MONTH(OrderDate) AS OrderMonth,
	AVG(DATEDIFF(day,OrderDate,ShipDate)) As AvgShipday
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

-- C) ISDATE(value)  : TO CHECK VALID DATE 

-- TASK 1 : Date Validation : To Check Date Data type

SELECT 
	ISDATE('123') As DateCheck1,
	ISDATE('2025-08-20') As DateCheck2,
	ISDATE('20-08-2025') As DateCheck3,
	ISDATE('2025') As DateCheck4





 



