/* ==========================================================

CHAPTER NO - 3 : SQL DDL COMMANDS (DATA DEFINITION LANGUAGE)

 =========================================================== */


-- A) CREATE COMMAND : CREATE TABLE 

Use MyDatabase;

-- TASK1 : Create a new table called persons with columns: 
-- id, person_name,birth_date and phone

CREATE TABLE persons (
id INT NOT NULL,
person_name VARCHAR(50) NOT NULL,
birth_date DATE,
phone VARCHAR(15) NOT NULL,
CONSTRAINT pk_persons PRIMARY KEY (id)
)

SELECT *
FROM dbo.persons

-- ALTER COMMANDS :( MODIFYING TABLE STRUCTURE )

-- TASK 1 : Add a new column called email to the persons table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

SELECT * 
FROM dbo.persons

-- TASK 2 : Remove the column phone from the persons table

ALTER TABLE persons
DROP COLUMN phone

SELECT *
FROM dbo.persons

-- C) DROP COMMANDS : REMOVING TABLES

-- TASK 1 : Delete the table persons from the database

DROP TABLE persons




