/*======================================================================

	SQL NUMBER FUNCTIONS : (APPLY ON NUMERIC DATA )

=======================================================================*/

-- A) ROUND FUNCTIONS - ROUNDING THE NUMBER

-- TASK 1 : Rounding 3.516 to different decimal places

SELECT 
	3.516 AS Original_number,
	ROUND(3.516,2) AS Round_2,
	ROUND(3.516,1) AS Round_1,
	ROUND(3.516,0) AS Round_0

-- B) ABS() : ABSOLUTE VALUE (POSITIVE VALUE)

-- TASK 1 : Return the absolute (Positive) value of a number

SELECT 
	-10  AS Original_number,
	ABS(-10) As Absolute_negative_number,
	ABS(10)  As Absolute_positive_number

