/*=================================================================================

	SET OPERATORS : UNION , UNION ALL ,EXCEPT , INTERSCT ( TO COMBINE DATA )

====================================================================================*/


-- A) UNION OPERATOR : RETURN ALL DISTINCT ROWS FROM BOTH TABLE

-- TASK 1 : Combine data from  Employees and Customers into one Table (no Duplicates)

SELECT 
	FirstName,
	LastName 
FROM Sales.Customers


UNION 

SELECT 
	FirstName,
	LastName
FROM Sales.Employees


-- B) UNION ALL : RETURN ALL ROWS , INCLUDING BOTH DUPLICATES

-- TASK 1 : Combine data from  Employees and Customers into one Table (including Duplicates)

SELECT 
	FirstName,
	LastName
FROM Sales.Customers

UNION ALL


SELECT 
	FirstName,
	LastName
FROM Sales.Employees


-- C) EXCEPT OPERATOR : RETURN UNIQUE ROWS FROM 1ST TABLE THAT ARE NOT IN SECOND TABLE

-- TASK 1 : Find Employees who are not customers at the same time

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

EXCEPT 

SELECT 
	FirstName,
	LastName
FROM Sales.Customers


-- TASK 2 : Find Customer who are not Employee at the same time

SELECT 
	FirstName,
	LastName
FROM Sales.Customers

EXCEPT

SELECT 
	FirstName,
	LastName
FROM Sales.Employees


-- D) INTERSECT OPERATOR : RETURN COMMON ROWS BETWEEN TWO TABLE

-- TASK 1 : Find the Employees who are also Customers

SELECT 
	FirstName,
	LastName
FROM Sales.Employees

INTERSECT

SELECT
	FirstName,
	LastName
FROM Sales.Customers

























