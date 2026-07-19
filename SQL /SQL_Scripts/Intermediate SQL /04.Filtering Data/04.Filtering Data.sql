/* =====================================================================

CHAPTER NO - 1 : SQL FILTERING DATA 

========================================================================*/

-- A) COMPARISION OPERATOR : ( =, <> OR != , >, >=, <, <= )

USE MyDatabase

-- TASK 1 : Retrive all Customers from Germany (=)

SELECT * 
FROM customers
WHERE country = 'Germany'

-- Task 2 : Retrive all Customers who are not from Germany (<> or !=)

SELECT *
FROM customers
WHERE country != 'Germany'

-- TASK 3 : Retrive all Customers with a score Greater than 500 (>)

SELECT *
FROM customers
WHERE score > 500

-- TASK 4 : Retrive all Customers with a score of 500 or More (>=)

SELECT * 
FROM customers
WHERE SCORE >= 500

-- TASK 5 : Retrive all Customers with a score less than 500 (<)

SELECT *
FROM customers
WHERE score < 500

-- TASK 6 : Retrive all Customers with a score 500 or Less (<=)

SELECT *
FROM customers
WHERE score <= 500


-- B) LOGICAL OPERATORS : ( AND , OR , NOT )

-- a) AND OPERATOR : IF BOTH CONDITION IS TRUE THEN FINAL RESULT IS TRUE OTHERWISE FALSE

-- TASK 1 : Retrive all Customers who are from the USA and have a score greater than 500 (AND)

SELECT *
FROM customers
WHERE country = 'USA' AND score > 500

SELECT * 
FROM customers


-- b) OR OPERATOR : ( IF ONE OF CONDITION IS TRUE THEN RESULT IS TRUE,
--                   IF BOTH CONDITION IS FALSE THEN RESULT IS FALSE )

-- TAKS1  : Retrive all Customers who are either from the USA or have a score Greater than 500 (OR)

SELECT *
FROM customers
WHERE country = 'USA' OR  score > 500


-- c) NOT OPERATOR : REVERSE THE RESULT 

-- TASK 1 : Retrive all Customers with a  score not less than 500 (NOT)

SELECT *
FROM customers
WHERE NOT score < 500

SELECT * 
FROM dbo.customers


--  C) RANGE OPERATOR :  (BETWEEN - GIVE RESULT BETWEEN GIVEN RANGE INCLUDING LOWER AND UPPER LIMIT OF RANGE) 

 -- TASK 1 : Retrive all Customers whose Score falls in the range between 100 and 500 (Between)

 SELECT *
 FROM customers
 WHERE score BETWEEN 100 AND  500


 SELECT *
 FROM customers
 WHERE score >= 100 AND score <= 500


 -- D) IN OPERATOR : ( TO CHECK VALUE EXIST OR NOT )

 -- TASK 1 : Retrive all Customers from Either Germany or USA (IN, NOT IN)

 SELECT *
 FROM dbo.customers
 WHERE country IN ('Germany', 'USA')


 SELECT *
 FROM DBO.customers
 WHERE first_name IN ('Maria','Peter')

 -- E) LIKE OPERATOR : (TO SEARCH RESULT BASED ON GIVEN PATTERN )

 -- TASK 1 : Find all Customers whose first name starts with 'M' (Like)

 SELECT *
 FROM dbo.customers
 WHERE first_name LIKE 'M%'


 -- TASK 2 : Find All Customers whose first name ends with 'n'

 SELECT *
 FROM dbo.customers
 WHERE first_name LIKE '%n'

 -- TASK 3 : Find All Customers whose First name contains 'r'

 SELECT *
 FROM dbo.customers
 WHERE first_name LIKE '%r%'

 -- TASK 4 : Find the Customers whose name having 'r' in the third Position

 SELECT * 
 FROM dbo.customers
 WHERE first_name LIKE '__r%'


 SELECT * 
 FROM dbo.customers
 WHERE first_name LIKE '____r%'


  SELECT * 
 FROM dbo.customers
 WHERE first_name LIKE '_ar%'



















