/*=====================================================
		ADVANCE SQL TECHNIQUES : STORE PROCEDURE
=======================================================*/

-- A) Write  a Basic Query 
-- Task 1 : For US Customers find the total no. of Customers and the Avg. Score

select 
	COUNT(*) as TotalCustomers,
	AVG(score) As AvgScore
from sales.Customers
where country = 'USA'

-- B) Create Basic Store Procedures : Create & Execute
-- Task 2 : For US Customers find the total no. of Customers and the Avg. Score

CREATE PROCEDURE GetCustomerSummary As
BEGIN
	select 
		COUNT(*) as TotalCustomers,
		AVG(score) As AvgScore
	from sales.Customers
	where country = 'USA'
END 

-- Execute StoreProcedure 
EXEC GetCustomerSummary

-- C) Write a Store Procedures 
-- Task 3 :  For Germany  Customers find the total no. of Customers and the Avg. Score

CREATE PROCEDURE GetCustomerSummaryGermany As
BEGIN
	select 
		COUNT(*) as TotalCustomers,
		AVG(score) As AvgScore
	from sales.Customers
	where country = 'Germany'
END 

EXEC GetCustomerSummaryGermany

-- Drop StoreProcedure
Drop procedure GetCustomerSummaryGermany

-- D) Store Procedures  with Parameters (Default Values )
-- Task 4: For Germany  Customers find the total no. of Customers and the Avg. Score


ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN
	select
		count(*) As TotalCustomers,
		AVG(Score) As AvgScore
	from sales.customers 
	where country = @country
END

EXEC GetCustomerSummary @country = 'Germany' 
EXEC GetCustomerSummary @country = 'USA' 
EXEC GetCustomerSummary

-- E) Store Procedures with Multiple SQL Statements : 
-- Task 5:  For Germany customers find the total no of Customers and the Avg. Score.
--          Find the Total No of Orders and total Sales for Germany

ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN

-- Task : For Germany customers find the total no of Customers and the Avg. Score.
	select
		count(*) As TotalCustomers,
		AVG(Score) As AvgScore
	from sales.customers 
	where country = @country;

-- Task : Find the Total No of Orders and total Sales for Germany
	select
		count(Orderid) AS TotalOrders,
		sum(sales) AS TotalSales
	from sales.orders As O
	join sales.Customers As C
	on C.customerId = O.Customerid
	where C.country = @country ;

END


EXEC GetCustomerSummary @country = 'Germany'
EXEC GetCustomerSummary @country = 'USA'

-- F) Store Procedure With Variables :
-- Task 6:  Declair Variables, Capture Query Results , print to console :
--          For Germany Customers find the total no. of customers and the Avg. Score

ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN

	DECLARE @TotalCustomers INT , @AvgScore FLOAT;

	select
		@TotalCustomers = count(*) ,
		@AvgScore = AVG(Score) 
	from sales.customers 
	where country = @country

	PRINT('Total Customers from' + @country + ':' +  CAST(@TotalCustomers AS NVARCHAR ) );
	PRINT('Average Score from' + @country + ':' +  CAST(@AvgScore AS NVARCHAR ) );
END


EXEC GetCustomerSummary @country = 'Germany'
EXEC GetCustomerSummary

-- Store Procedures : Control Flow (IF - Else ) :
-- Task 7 :  Check for Null Scores and Update before Generating Report : 
-- Declair Variables, Capture Query Results , print to console :
-- For USA Customers find the total no. of customers and the Avg. Score

ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN
	DECLARE @TotalCustomers INT, @AvgScore FLOAT ;

	-- prepare & cleanup 

	IF EXISTS(
			SELECT * FROM sales.Customers
			WHERE Score IS NULL AND COUNTRY = @country
			)
	BEGIN
		PRINT('UPDATING NULL SCORE TO 0');
		UPDATE sales.Customers
		SET Score = 0
		WHERE SCORE IS NULL  AND COUNTRY = @country
	END

	ELSE
		PRINT('No Null Score Found')


	-- Report Generation
	SELECT
		@TotalCustomers = COUNT(*),
		@AvgScore       = AVG(SCORE)
	FROM sales.Customers
	WHERE country = @country
	
	PRINT('TotalCustomers:'+  cast(@TotalCustomers AS NVARCHAR) );
	PRINT('AvgScore:'      +  cast(@AvgScore As NVARCHAR));

END

EXEC GetCustomerSummary @country = 'USA'
EXEC GetCustomerSummary @country = 'Germany'

-- Store Procedure : Error Handling (TRY - CATCH)
-- Task 8: Wrap Entire Procedure body in Try/Catch for robust error handling
-- :  For Germany customers find the total no of Customers and the Avg. Score.
--    Find the Total No of Orders and total Sales for Germany

ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN
	BEGIN TRY
			DECLARE @TotalCustomers INT, @AvgScore FLOAT;
		-- Task : For Germany customers find the total no of Customers and the Avg. Score.
			select
				@TotalCustomers = count(*), 
				@AvgScore = AVG(Score) 
			from sales.customers 
			where country = @country;

			PRINT('TotalCustomers:' + cast(@TotalCustomers As NVARCHAR));
			PRINT('AvgScore:'       + cast(@AvgScore As NVARCHAR ));

		-- Task : Find the Total No of Orders and total Sales for Germany
			select
				count(Orderid) AS TotalOrders,
				sum(sales) AS TotalSales,
				1/0        AS FaultyCalculation ------ intension Generate Error
			from sales.orders As O
			join sales.Customers As C
			on C.customerId = O.Customerid
			where C.country = @country ;

	END TRY

	BEGIN CATCH
		PRINT('An Error Occured.');
		PRINT('Error Message: ' + ERROR_MESSAGE() );
		PRINT('Error Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR ) );
		PRINT('Error Line   : ' + CAST(ERROR_LINE()   AS NVARCHAR ) );
		PRINT('Error Procedure :' + ERROR_PROCEDURE() );
	END CATCH

END

EXEC GetCustomerSummary @country = 'Germany' 
EXEC GetCustomerSummary


--------------------------------------------------------------------------------------------------------------------------------------

ALTER PROCEDURE GetCustomerSummary
	@country NVARCHAR(50) = 'USA'
AS
BEGIN
	
			DECLARE @TotalCustomers INT, @AvgScore FLOAT;
		-- Task : For Germany customers find the total no of Customers and the Avg. Score.
			select
				@TotalCustomers = count(*), 
				@AvgScore = AVG(Score) 
			from sales.customers 
			where country = @country;

			PRINT('TotalCustomers:' + cast(@TotalCustomers As NVARCHAR));
			PRINT('AvgScore:'       + cast(@AvgScore As NVARCHAR ));

		-- Task : Find the Total No of Orders and total Sales for Germany
			select
				count(Orderid) AS TotalOrders,
				sum(sales) AS TotalSales,
				1/0        AS FaultyCalculation ------ intension Generate Error
			from sales.orders As O
			join sales.Customers As C
			on C.customerId = O.Customerid
			where C.country = @country 

END

EXEC GetCustomerSummary @country = 'Germany'












		


