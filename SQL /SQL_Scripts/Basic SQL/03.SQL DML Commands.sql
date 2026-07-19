
/* ==========================================================
CHAPTER NO 4 - DATA MANIPULATION LANGUAGE  (DML Commands)
==============================================================*/

-- 1) INSERT COMMAND - ADDING DATA TO TABLES

-- Method 1 : Manual Insert using values 

Use MyDatabase


-- TASK 1 : Insert new record into the customers table

SELECT *
FROM dbo.customers

INSERT INTO customers (id, first_name, country,score)
VALUES
	( 6,'Anna','USA', NULL),
	( 7, 'Sam', NULL , 100)

SELECT *
FROM dbo.customers

-- TASK 2 : Insert a new record with full column values

INSERT INTO customers (id,first_name,country,score)
VALUES 
	( 8, 'Max', 'USA', 368 )

SELECT *
FROM dbo.customers

-- TAKS 3 : Insert without specifying column names (not recommended)

INSERT INTO customers
VALUES
	( 9, 'Andreas','Germany', NULL)

SELECT *
FROM dbo.customers

-- TAKS 4 : Insert with only Id and first_name (others column will be null or default)

INSERT INTO customers (id,first_name)
VALUES 
	( 10 , 'Sahra' )

SELECT *
FROM dbo.customers

----------------------------------------------------------

INSERT INTO customers (id,first_name,country,score)
VALUES 
	( 11, 'USA', 'Anna', 368 )

SELECT *
FROM dbo.customers


-- METHOD 2 : INSERT DATA USING SELECT ( MOVING DATA FROM ONE TABLE TO ANOTHER )

-- TASK 1 : Copy data from 'customers' table into 'persons'

USE MyDatabase

CREATE TABLE persons (
id INT NOT NULL,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (id)
)


INSERT INTO persons ( id, person_name,birth_date,phone )
SELECT 
id,
first_name,
NULL,
'Unknown'
FROM dbo.customers

SELECT *
FROM persons


-- 2) UPDATE COMMAND : - MODIFYING EXISTING TABLES DATA

-- TASK 1 : Change the score of customer with id 6 to 0.

SELECT *
FROM dbo.customers

UPDATE customers
SET score = 0
WHERE id = 6

SELECT *
FROM DBO.customers
WHERE id = 6

-- TASK 2 : change the score of customer with id 10 to 0 and Update the Country to 'UK'

SELECT *
FROM dbo.customers

UPDATE customers
SET score = 0,
	country = 'UK'
WHERE id = 10

SELECT *
FROM dbo.customers
WHERE id = 10

-- TASK 3 : Update all Customers with a Null Score by setting their score to 0.

SELECT * 
FROM dbo.customers

UPDATE customers
SET score = 0
WHERE score IS NULL

SELECT *
FROM dbo.customers
WHERE score IS NULL


-- DELETE COMMAND :- REMOVING DATA FROM TABLE

-- TASK 1 : Delete all Customers with an ID Greater than 5

SELECT * 
FROM dbo.customers

DELETE FROM customers
WHERE id > 5

SELECT *
FROM dbo.customers

-- TASK 2 : Delete all data from persons table

SELECT *
FROM dbo.persons

DELETE FROM persons

-- TASK 3 : Faster Method to delete all rows (greate for large tables)

TRUNCATE TABLE persons















