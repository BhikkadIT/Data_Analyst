/*===========================================================
	chatper No - 3 : ROW LEVEL FUNCTIONS 
=============================================================*/

-- A) SINGLE ROW FUNCTIONS :

-- a) STRING FUNCTIONS : 

-- 1) CONCAT : STRING CONCATENATION 

-- TASK 1 : Show a list of Customers first name together with their country in one column

SELECT 
	first_name,
	country,
	CONCAT(first_name,' - ',country) as full_info
FROM dbo.customers


-- 2) LOWER() & UPPER() - CASE TRANSFORMATION

-- TASK 1 : Transforms the Customer first name to lower Case

SELECT 
	first_name,
	LOWER(first_name) as lower_case
FROM dbo.customers

-- TASK 2 : Transfroms the Customer first name to Upper Case

SELECT 
	first_name,
	UPPER(first_name) as upper_case
FROM dbo.customers


-- C) TRIM() :- REMOVE LEADING AND TRAILING SPACES

-- TASK 1 : find the Customers whose first name contains leading or trailing spaces

SELECT 
	first_name
from dbo.customers
WHERE first_name !=  TRIM(first_name)


SELECT 
	first_name,
	LEN(first_name) AS len_name,
	LEN(TRIM(first_name)) AS len_trim_name,
	LEN(first_name) - LEN(TRIM(first_name)) AS flag
FROM dbo.customers
WHERE LEN(first_name) != LEN(TRIM(first_name))


-- D) REPLACE : REPLACE OR REMOVE A VALUE

-- TASK 1 : Remove dashesh from phone number / replace with slash

SELECT 
	'123-456-7890' AS phone,
	REPLACE('123-456-7890','-','/') AS clean_phone

-- TASK 2 : Replace file extensions from .txt to .csv

SELECT 
	'report.txt'  As old_filename,
	REPLACE('report.txt','.txt','.csv') AS new_filename

-- E) LEN : CALCULATE STRING LENGTH

-- TASK 1 : Calculate the length of each  customer's first name

SELECT 
	first_name,
	LEN(first_name) AS name_length
FROM DBO.customers

-- F) LEFT() & RIGHT() : EXTRACT SUBSTRING FROM MAIN STRING

-- TASK 1 : Retrive the first 2 characters of each first name

SELECT 
	first_name,
	LEFT(TRIM(first_name),2) AS first_2_char
FROM dbo.customers


-- TASK 2 : Retrive the last 2 characters of each first name

SELECT 
	first_name,
	RIGHT(first_name,2) AS last_2_char
FROM dbo.customers


-- G) SUBSTRING() : EXTRACT SUBSTRING 

-- TASK 1 : Retrive a list of Customer's first name after removing the first characters

SELECT 
	first_name,
	SUBSTRING(first_name,2,LEN(first_name)) AS Trimmed_name
FROM dbo.customers


-- Task 2 :  Nesting Functions ( Nest lower inside upper)

SELECT 
	first_name,
	UPPER(LOWER(first_name)) AS Nesting
FROM dbo.customers















