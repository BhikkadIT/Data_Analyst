-- This is a single line Comment

/* This
	is
	a Multi-line 
	Comment 
*/

/*
==============================================================
Chapter NO - 2 SQL SELECT QUERY  ( Data Query Language)
===============================================================
*/


-- A) SELECT ALL COLUMNS 

-- TASK 1 : Retrive all Customers Data

use MyDatabase 

SELECT *
FROM dbo.customers 

-- TASK 2 : Retrive all Orders Data

SELECT * 
FROM dbo.orders

-- B) SELECT SPECIFIC COLUMNS

-- TASK1 : Retrive each customers name, country, and score

SELECT 
	first_name,
	country,
	score
FROM dbo.customers

-- C) WHERE CLAUSE

-- TASK1 : Retrive Customer with a Score not Equal to 0

SELECT *
FROM dbo.customers
WHERE score != 0

-- TASK2 : Retrive Customers from Germany

SELECT *
FROM DBO.customers
WHERE country = 'Germany'

-- Task 3 : Retrive the name and Country of Customers from Germany

SELECT 
	first_name,
	country
FROM dbo.customers
WHERE country = 'Germany'

-- Task4 : Retrive the name, score of Customers from Germany

SELECT 
	first_name,
	score,
	country
FROM dbo.customers
WHERE country = 'Germany'


-- D) ORDER BY CLAUSE : TO SORT THE DATA FROM THE TABLE IN ASC OR DESC ORDER

-- Task 1 :Retrive All Customer and Sort the Result by the highest score First

SELECT *
FROM dbo.customers
ORDER BY score DESC

-- TASK 2 : Retrive All Customers and Sort the result by the lowest score First
 
SELECT *
FROM dbo.customers
ORDER BY score ASC


-- TAKS 3 : Retrive All Customers and Sort the result by the Country and then by the highest score

SELECT * 
FROM dbo.customers
ORDER BY country ASC, score DESC

-- TASK 4 : Retrive the name , Country, and Score of Customers whose score is not equal to 0 and 
-- Sort the result by the highest score First.

SELECT 
	first_name,
	country,
	score
FROM dbo.customers
WHERE score != 0
ORDER BY score DESC


-- E) GROUP BY CLAUSE : TO GROUP COLUMN

-- TASK 1 : Find the Total Score for Each Country

SELECT
country,
first_name,
SUM(score) AS Total_score
FROM dbo.customers
GROUP BY country

-- TASK 2 : Find the Total Score and Total Number of Customers for Each Country

SELECT 
country,
SUM(score) as Total_score,
COUNT(id) As Total_customer
FROM dbo.customers
GROUP BY country


--  F) HAVING CLAUSE ( USE WITH GROUP BY CLAUSE, AFTER AGGREGATION )

-- TAKS 1 : Find the Average Score for each Country and return 
-- only those Countries with an average score greater than 430

SELECT
country,
AVG(score) as avg_score
FROM customers
GROUP BY country
HAVING AVG(score) > 430

-- Task 2 : Find the average Score of each country considering only customers 
-- with a score not equal to 0 and return only those countries 
-- with an average score greater than 430.

SELECT
country,
AVG(score) as avg_score
FROM dbo.customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430

-- G) DISTINCT CLAUSE (TO GET UNIQUE VALUES FROM COLUMN)

-- TASK1 : Return Unique List of all Countries

SELECT DISTINCT country
FROM dbo.customers

-- H) TOP CLAUSE ( TO GET TOP ROWS FROM THE TABLE )

-- TASK1 : Return Only 3 Customers

SELECT TOP 3 *
FROM dbo.customers

-- TASK2 : Retrive the top 3 Customers with the Highest Scores

SELECT TOP 3 *
FROM dbo.customers
ORDER BY score DESC

-- TASK 3 : Retrive the Lowest 2 Customers based on the Scores

SELECT TOP 2 *
FROM dbo.customers
ORDER BY score ASC

-- TASK 4 : Get the Two Most Recent Orders

SELECT TOP 2 * 
FROM dbo.orders
ORDER BY order_date DESC

-- TASK (ALL TOGETHER )---
-- Calculate Average Scores for each Country Considering only Customers 
-- with a score not equal to 0 and Return Only  those Countries with 
-- an average score greater than 430 and sort the result by the highest 
-- average score first.

SELECT 
country,
AVG(score) as Avg_score
FROM dbo.customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430
ORDER BY AVG(score) DESC


-- Execute mulitple queries at once

SELECT * 
FROM DBO.customers;

SELECT *
FROM dbo.orders

-- SELECT STATIC/CONSTANT VALUE WITHOUT A TABLE

SELECT 123 AS static_number;
SELECT 'Hello' As static_string;


-- Assign a constant value to a column in a query

SELECT
id,
first_name,
'New Customer' As customer_type
FROM dbo.customers


























