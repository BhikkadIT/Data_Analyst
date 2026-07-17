/*=============================================================================
	Difference Between NULL VS Empty String vs Blank Space
===============================================================================*/

-- Task 1 : Demonstrate Difference Between Null vs Empty String vs Blank Space
WITH Orders As (
SELECT 1 AS id, 'A' as Category UNION
SELECT 2      ,  NULL           UNION
SELECT 3      , ''              UNION
SELECT 4      , ' '
)
SELECT 
	*,
	DATALENGTH(Category) As LenCategory,
	TRIM(category)       As Policy1,
	NULLIF(TRIM(category),'') As Policy2,
	COALESCE(NULLIF(TRIM(category),''),'Unknown') As Policy3
FROM Orders
