/*============================================================================

ADVANCE JOIN - (LEFT ANTI JOIN, RIGHT ANTI JOIN , FULL ANTI JOIN , CROSS JOIN )

=============================================================================*/


-- A) LEFT ANTI JOIN :

-- TASK 1 : Get all Customers who have not placed any orders

SELECT * 
FROM customers AS C
LEFT JOIN orders AS O
	ON C.id = O.customer_id
WHERE O.customer_id IS NULL


-- B) RIGHT ANTI JOIN 

-- TASK 1 : Get all Orders without Matching Customers


SELECT *
FROM customers AS C
RIGHT JOIN orders AS O
	ON C.id = O.customer_id
WHERE C.id IS NULL


-- Alternative to Right Anti Joins (Left Join)

-- TASK 1: Get all Orders without Matching Customers

SELECT *
FROM orders AS O
LEFT JOIN customers AS C
	ON C.id = O.customer_id
WHERE C.id IS NULL


-- C) FULL ANTI JOIN : 

-- TASK 1 : Find Customers without Orders and Orders without Customers

SELECT *
FROM customers AS C
FULL JOIN orders AS O
	ON C.id = O.customer_id
WHERE O.customer_id IS NULL OR C.id IS NULL

-- D) CROSS JOIN :

-- TASK 1 : Generate all Possible Combinations of Customers and Orders 

SELECT * FROM customers;
SELECT * FROM orders;


SELECT *
FROM customers
CROSS JOIN orders


SELECT *
FROM orders
CROSS JOIN customers


