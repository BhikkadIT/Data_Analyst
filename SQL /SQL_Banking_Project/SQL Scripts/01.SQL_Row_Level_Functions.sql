/*=========================================================================================
		SQL BANKING DOMAIN PROJECT : (CUSTOMERS, ACCOUNT, TRANSACTIONS )
===========================================================================================*/

-- A) SQL ROW LEVEL FUNCTIONS :

--TASK 1 : Display the full name of each customer in a single field by merging their first and last names
--in uppercase (Handle Text Formatting).
--Additionally, generate a short username using the first letter of the first name plus the last name
--in lowercase, and provide the length of each first name.
select 
	customer_id,
	upper(concat(trim(first_name),' ',trim(last_name))) as Clean_full_name,
	lower(concat(left(first_name,1),last_name)) As username,
	len(trim(first_name)) as first_name_length
from customers

--Task 2 : Update each transaction description by replacing the word 'Cash' with 'CASH' (Modify Text).

select 
	transaction_id,
	description,
	replace(description,'Cash','CASH') As Description_updated
from transactions 

-- Task 3 : Round every account balance to the nearest hundred (Handle Numeric Rounding).

select 
	account_id,
	account_balance,
	round(account_balance,-2) as rounded_to_nearest_100
from accounts 

-- Task 4 : Round each account's interest rate to 1 decimal place (Handle Numeric Rounding).

select 
	account_id,
	interest_rate,
	round(interest_rate,1) As rounded_interest_rate,
	round(coalesce(interest_rate,0),1) as Clean_interest_rate
from accounts 

-- Task 5 : Extract the day, month, year, month name, and quarter from each transaction date, 
-- along with the last date of that month (Extract Date Parts).

select 
	transaction_id,transaction_date,
	day(transaction_date) as Txn_day,
	month(transaction_date) as Txn_Month,
	year(transaction_date) as Txn_year,
	datename(month,transaction_date) as Month_name,
	datepart(quarter, transaction_date) as Txn_Quarter,
	eomonth(transaction_date) as Month_end_date
from Transactions

--Task 6 : Calculate the number of days since each account was opened and the date 30 days after opening (Date Calculations).
--Additionally, find the start of that month, and format, convert, cast, and validate the opening date.

select 
	account_id,open_date,
	datediff(day,open_date,GETDATE()) As days_since_opening,
	dateadd(day,30,open_date) as grace_period,
	Datetrunc(month,open_date) as starty_of_that_Month,
	format(open_date,'dd-MM-yyyy') as Nicely_formated_date,
	convert(varchar,open_date,103) as Converted_date,
	cast(open_date as datetime ) as Cast_as_datetime,
	isdate(convert(varchar,open_date)) as is_valid_date
from accounts 

-- Task 7: "Find accounts with a missing interest rate and replace it with 0, 
-- using both ISNULL and COALESCE (Handle Null Values).
-- Additionally, provide details such as Account ID and Account Type."

select 
	customer_id,
	interest_rate,
	account_type,
	isnull(interest_rate,0)   As  Using_Is_Null,
	coalesce(interest_rate,0) As Clear_column
from Accounts

-- Task 8:Flag transactions of exactly 1000 by converting the amount to NULL 
-- (Handle Null Values Using NULLIF).
-- Additionally, filter the results to only transactions where the merchant category is known.

select 
account_id,
transaction_amount,
merchant_category,
nullif(transaction_amount,1000) As amount_unless_exactly_1000
from Transactions
where merchant_category is not null

--- Task 9: Generate a report categorizing each account by balance (Categorize Data):
--- Balance > 100000 : High Balance
--- Balance Between 10000 and 100000 : Medium Balance
--- Balance < 10000 : Low Balance
--- Sort the result from lowest to highest balance.

select * from Accounts
SELECT
	account_id, account_balance,
	ROUND(account_balance, -3) AS rounded_balance,
	CASE
		WHEN ROUND(account_balance, -3) < 10000
			THEN 'Low Balance'
		WHEN ROUND(account_balance, -3) BETWEEN 10000 AND 100000
			THEN 'Medium Balance'
	ELSE 'High Balance'
	END AS balance_category
FROM Accounts
order  by account_balance asc

-- Task 10 :Label each transaction as MONEY IN, MONEY OUT, or TRANSFER based on its transaction type,
--and display the label in uppercase (Categorize Data).


select 
	transaction_id,
	transaction_type,
	Upper(case 
		when Transaction_type in ('Deposit','Interest Credit')
			Then 'Money In'
		when transaction_type in ('Withdrawal','Fee')
			Then 'Money Out'
		when transaction_type = 'Transfer' Then 'Transfer'
	End) as Plain_English_Tag
from Transactions
















