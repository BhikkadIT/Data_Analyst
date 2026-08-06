/*=================================================================
		ADVANCE SQL TECHNIQUES : ( STORE PROCEDURE , TRIGGER ) 
=====================================================================*/

-- TASK 12: Create a new permanent table combining each account's details with its total transaction amount (Use CTAS).

select 
	a.account_id, a.account_type,a.account_balance,
	isnull(sum(t.transaction_amount),0) As total_transaction_amount
into AccountSummary
from accounts as a
left join transactions as t
	on a.account_id = t.account_id
group by a.account_id,a.account_type, a.account_balance 

select * from AccountSummary

-- Store Prodcedure :
-- Task 13 : Create a stored procedure to retrieve customers based on a given customer segment (Create Stored Procedure).

CREATE PROCEDURE GetCustomerBySegment
	@Segment Varchar(20) 
AS
BEGIN
	select
		customer_id, first_name, last_name, customer_segment 
	from customers
	where customer_segment = @Segment;
END;

EXEC GetCustomerBySegment @Segment = 'Corporate';

-- TASK 14 : Create a stored procedure to retrieve the transaction history for a given Account ID (Create Stored Procedure).

CREATE PROCEDURE GetAccountTransactionHistory
	@AccountId INT = 1002
AS
BEGIN
	select
		transaction_id, transaction_date, transaction_type ,transaction_amount, transaction_status,account_id 
	from transactions
	where account_id = @AccountId
	order by transaction_date asc
END;

EXEC GetAccountTransactionHistory;
EXEC GetAccountTransactionHistory @AccountId = 1003;

-- TASK 15 : Create a stored procedure to retrieve accounts with a balance below a given amount (Create Stored Procedure).

CREATE PROCEDURE GetAccountBelowBalance
	@MinBalance DECIMAL(12,2) 
As
BEGIN
	select 
		account_id, account_type, account_balance 
	from accounts
	where account_balance < @MinBalance
END;

EXEC GetAccountBelowBalance @MinBalance = 500000;

ALTER PROCEDURE GetAccountBelowBalance
	@MinBalance DECIMAL(12,2) = 100000
As
BEGIN
	select 
		account_id, account_type, account_balance 
	from accounts
	where account_balance < @MinBalance
END;

EXEC GetAccountBelowBalance
EXEC GetAccountBelowBalance @MinBalance = 1000000;

-- TASK 16 : Create a trigger that automatically logs every new transaction into an audit table (Create Trigger).

CREATE TABLE TransactionAuditLog (
	audit_id INT IDENTITY(1,1) PRIMARY KEY,
	transaction_id INT,
	account_id INT,
	Transaction_amount DECIMAL(12,2),
	logged_at DATETIME DEFAULT GETDATE()
	);

CREATE TRIGGER trg_LogNewTransaction
ON Transactions
AFTER INSERT
AS
BEGIN
	INSERT INTO TransactionAuditLog (transaction_id,account_id,Transaction_amount)
	SELECT Transaction_id,account_id,transaction_amount 
	FROM Inserted;
END;

INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, transaction_amount, transaction_channel, transaction_status, balance_after_transaction, merchant_category, description)
VALUES
    (500106, 1035, '2025-10-09 04:46:12', 'Deposit', 1000.00, 'ATM', 'Success', 73534.45, NULL, 'Account maintenance / service fee')

select * from TransactionAuditLog

-- Task 17 : Create a trigger that prevents inserting a transaction with a negative amount (Create Trigger).

CREATE TRIGGER trg_PreventNegativeAmount
ON Transactions
AFTER INSERT
AS
BEGIN
	IF EXISTS (
		select * from inserted where transaction_amount < 0 
		)
	BEGIN
		RAISERROR('Transaction amount can not be negative.',16,1);
		ROLLBACK TRANSACTION;
	END
END;

select * from Transactions

-- TASK 18 : Create a trigger that automatically updates the account balance when a new transaction is inserted (Create Trigger).

CREATE TRIGGER trg_UpdateAccountBalance
ON Transactions
AFTER INSERT
AS
BEGIN
	update a 
	set a.account_balance = a.account_balance + i.transaction_amount
	from accounts as a
	inner join inserted as i
	on a.account_id = i.account_id
    where i.transaction_type IN ('Deposit','Interest Credit')
END

select * from transactions 

select * from accounts 
where account_id = 1035

-- drop trigger trg_UpdateAccountBalance

--Delete from transactions 
--where transaction_id > 500100







