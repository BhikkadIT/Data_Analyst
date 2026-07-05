/*==================================================================

CHAPTER NO - SQL JOINS (COMBINING DATA ) 

==================================================================*/

-- A) BASIC JOINS : (NO JOINS, INNER JOIN , LEFT JOIN, RIGHT JOIN, FULL JOIN )

-- a) NO JOINS :

-- TASK 1 : Retrive Data from Customers and Orders Table in two different results

SELECT * FROM customers;
SELECT * FROM orders;

-- b) INNER JOIN :

-- TASK 1 : Get all Customers along with their orders, but only for Customers who have placed an orders

SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
INNER JOIN orders AS O
	ON C.id = O.customer_id

-- c) LEFT JOIN :

-- TASK 1 : Get All Customers along with their orders including those without orders

SELECT 
	C.ID,
	C.FIRST_NAME,
	O.ORDER_ID,
	O.SALES
FROM customers AS C
LEFT JOIN orders AS O
	ON C.ID = O.customer_id


SELECT 
	C.ID,
	C.FIRST_NAME,
	O.ORDER_ID,
	O.SALES
FROM orders AS O
LEFT JOIN  customers AS C
	ON C.ID = O.customer_id


-- d) RIGHT JOIN :

-- TASK 1 : Get all Customers along with their orders , including orders without matching customers

SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM customers AS C
RIGHT JOIN orders AS O
	ON C.id = O.customer_id

-- Alternatie RIGHT JOIN USING LEFT JOIN 

-- TASK 2 : Get all Customers along with their orders , including orders without matching customers
SELECT 
	C.id,
	C.first_name,
	O.order_id,
	O.sales
FROM orders AS O
LEFT JOIN  customers AS C
	ON C.id = O.customer_id

-- e) FULL JOIN : 

-- TASK 1 : Get all Customers and all Orders, even if there's no match

SELECT 
	C.id,
	C.first_name,
	O.customer_id,
	O.sales
FROM customers AS C
FULL JOIN orders AS O
	ON C.id = O.customer_id


SELECT 
	C.id,
	C.first_name,
	O.customer_id,
	O.sales
FROM orders AS O
FULL JOIN  customers AS C
	ON C.id = O.customer_id







