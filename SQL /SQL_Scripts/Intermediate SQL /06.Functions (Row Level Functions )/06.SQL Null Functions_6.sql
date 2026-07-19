/*========================================================================================
		IS NULL FUNCTIONS ( ISNULL, COALESCE , NULLIF , IS NULL , IS NOT NULL )
==========================================================================================*/

-- A)  IsNull : Replace Null with Specified Value (value, replacement_value)


-- B) COALESCE: Returns first non null values from a list (value1, value2,value3)

--  TASK 1 : Find the Average Scores of the customers ( Handle Null Data Aggregation)

SELECT 
	CustomerID,
	Score,
	COALESCE(score,0) As Score2,
	AVG(COALESCE(score,0)) over() Avg_Score2,
	AVG(score) over() as Avg_Score
FROM Sales.Customers


-- Task 2 : Display full name of customers in single fields by merging their first and last names 
-- and add 10 bonus points to each customer scores (Handle Null Mathematical Operations)

SELECT 
	CustomerID,
	FirstName,
	LastName,
	FirstName + ' ' + COALESCE(LastName,'')  As full_name,
	Score,
	COALESCE(Score,0) + 10 AS ScorewithBonus
FROM Sales.Customers

-- TASK 3 : Sort the Customers from lowest to highest scores, with null appearing last

SELECT 
	CustomerID,
	Score,
	COALESCE(Score,9999999)
FROM Sales.Customers
ORDER BY COALESCE(Score,9999999)


SELECT 
	CustomerID,
	Score,
	CASE WHEN SCORE IS NULL THEN 1 ELSE 0 END AS Flag
FROM Sales.Customers
ORDER BY CASE WHEN SCORE IS NULL THEN 1 ELSE 0 END,Score


-- NULLIF(): Compare Two Expressions returns, Null if they are equal, 
--            First Value if they are not Equal. NullIF(Value1, Value2)

-- TASK 1 : Find the Sales Price for each order by dividing the sales by the Quantity. 
-- (Use Case - Prevent Division by zero Error)

SELECT 
	OrderID,
	Sales,
	Quantity,
	Sales/ NULLIF(Quantity,0) AS Price
FROM Sales.Orders

-- IS NULL (Return True if Null, Otherwise is False) (value Is Null)

-- TASK 1 : Identify the Customers who have no scores (Searching For Missing Information)

SELECT *
FROM SALES.Customers
WHERE Score IS NULL

-- TASK 2 : List All Customers who have a Scores (Searching for Missing Information )

SELECT *
FROM sales.Customers
WHERE SCORE IS NOT NULL

-- TASK 3 :  List all Details For customers who have not placed any orders - 
-- (Find the Unmatched Rows between two tables  (Left Anti joins / Right Anti Joins)

SELECT 
C.*,
O.OrderID
FROM sales.Customers As c
LEFT JOIN Sales.Orders As O
ON c.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL












