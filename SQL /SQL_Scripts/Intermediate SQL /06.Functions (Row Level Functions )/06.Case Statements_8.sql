/*===================================================================================
	CHAPTER NO : 3  ( CASE STATEMENT )
====================================================================================*/

-- TASK 1 : Generate a Report Showing the total sales for each Category : (Categorize Data)
-- Sales >50 :High
-- Sales Between 20 to 50 : Medium
-- Sales < 20 :Low
-- Sort the Result from Lowest to Highest
SELECT 
	Category,
	SUM(sales) AS TotalSales
FROM (
	SELECT 
		OrderID,
		Sales,
		CASE
			WHEN Sales > 50 THEN 'HIGH'
			WHEN Sales > 20 THEN 'MEDIUM'
			ELSE 'LOW'
		END AS Category
	FROM Sales.Orders
) AS t
GROUP BY Category
ORDER BY TotalSales

-- TASK 2 : Retrive the Customer Details with abbreviated Country Code

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
	CASE
		WHEN Country = 'Germany' Then 'DE'
		WHEN Country = 'USA'     Then 'US'
		ELSE 'n/a'
	END AS CountryAbbr
FROM Sales.Customers

-- TASK 3 : Retrive the Customer Details with abbreviated Country Code ( Quick Form )

SELECT 
	CustomerID,
	FirstName,
	LastName,
	Country,
---- FULL FORM ---------------------------------------------------------------
	CASE
		WHEN Country = 'Germany' Then 'DE'
		WHEN Country = 'USA'     Then 'US'
		ELSE 'n/a'
	END AS CountryAbbr1,
---- QUICK FORM ---------------------------------------------------------------
	CASE Country
		WHEN 'Germany' Then 'DE'
		WHEN 'USA'     Then 'US'
		ELSE 'n/a'
	END AS CountryAbbr2
FROM Sales.Customers


-- TASK 4 : Find the Average Score of the Customers and treat nulls as 0 
--          Additionaly Provide Details Such as CustomerID and LastNames


SELECT 
	CustomerID,
	LastName,
	score,
	CASE 
		WHEN Score IS NULL THEN 0
		ELSE Score
	END AS CleanScore,
	AVG(
		CASE WHEN SCORE IS NULL THEN 0 ELSE Score END
		) OVER() AS AvgCustomerScore
FROM Sales.Customers

-- TASK 5 : Count how many times each customer has made an order with sales greater than 30

SELECT
	CustomerID,
	SUM(
		CASE 
			WHEN Sales > 30 THEN 1
			ELSE 0
		END
	) AS TotalOrdersHighSales,
	COUNT(*) As TotalOrders
FROM Sales.Orders
GROUP BY CustomerID

