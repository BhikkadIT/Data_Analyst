/*==================================================================================================================
					WINDOW FUNCTIONS : AGGREGATION FUNCTION, WINDOW BASIC FUNCTION
					                   WINDOW AGGREGATION FUNCTIONS, WINDOW RANKING FUNCTIONS
									   WINDOW VALUE FUNCTIONS 
====================================================================================================================*/

 --Task 1 : Generate a report showing the total Transaction amount, average transaction amount, 
 --and transaction count for each transaction type (Aggregate Data).

 select 
	transaction_type,
	round(sum(transaction_amount),2) As Total_Amount,
	round(avg(transaction_amount),2) As Avg_Amount,
	count(*) as Txn_count
 from Transactions
 group by transaction_type
 
-- Task 2 : Find the minimum and maximum account balance for each customer segment (Aggregate & Filter Groups).
-- Only include segments with more than 5 accounts.

select 
	c.customer_segment,
	min(a.account_balance) as Min_balance,
	max(a.account_balance) as Max_balance,
	count(*) as Account_count
from customers c
inner join accounts a
on c.customer_id = a.customer_id
group by c.customer_segment
Having count(*) > 5

-- Task 3 : Find the total number of transactions overall and the total number of transactions for each account 
-- (Window Function Basics).

select
	transaction_id,account_id,transaction_date ,
	count(*) over() As Total_Transactions,
	count(*) over( partition by account_id) As TransactionByAccount
from Transactions

-- Task 4 : Check the Accounts table for duplicate Account IDs (Window Function Basics).
select *
from (
	select
		*,
		count(*) over(partition by account_id) As Duplicate_Check
	from Accounts
	) t
where Duplicate_Check > 1

--Task 5 : Find the total and average transaction amount overall and for each account (Window Aggregation Functions).

select 
	transaction_id,account_id, transaction_amount,
	sum(transaction_amount) over() As Total_Amount_Overall,
	avg(transaction_amount) over() as Avg_Amount_Overall,
	sum(transaction_amount) over( partition by account_id) As TotalTxnByAccount,
	avg(transaction_amount) over( partition by account_id) As AvgTxnByAccount
from transactions 


--Task 6 : Find the lowest and highest transaction amount for each account (Window Aggregation Functions).
--Additionally, calculate how far each transaction is from both values.

select 
	transaction_id, account_id, transaction_amount,
	min(transaction_amount) over ( partition by account_id) As Lowest_for_Account,
	max(transaction_amount) over ( partition by account_id) as Max_for_Account,
	transaction_amount - min(transaction_amount) over ( partition by account_id) As Deviation_from_Min,
	max(transaction_amount) over ( partition by account_id) - transaction_amount As Deviation_from_Max
from transactions 

-- Task 7 : Rank each account based on their balance within their customer segment, 
-- from highest to lowest (Window Ranking Functions).
-- Additionally, provide details such as Account ID and Customer Segment.

select 
	c.customer_segment,a.account_id,a.account_balance,
	row_number() over(partition by c.customer_segment order by a.account_balance desc) As row_num_rank,
	rank() over(partition by c.customer_segment order by a.account_balance desc) AS rank_rank
from customers c
inner join accounts a 
on c.customer_id = a.customer_id

-- Task 8 : Rank each account within their segment without leaving gaps when balances tie, 
-- and divide each segment's accounts into 4 equal groups based on balance (Window Ranking Functions).

select
	c.customer_segment,a.account_id,a.account_balance,
	dense_rank() over( partition by c.customer_segment order by a.account_balance desc) As Dense_rank_num,
	ntile(4) over( partition by c.customer_segment order by a.account_balance desc) As balance_quartile
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id

-- Task 9 : Find the previous and next transaction amount for each account, ordered by transaction date 
-- (Window Value Functions).
-- Additionally, provide details such as Account ID and Transaction Date.

select 
	account_id,transaction_id, transaction_date,transaction_amount,
	lag(transaction_amount) over( partition by account_id order by transaction_date ) AS Prev_Amount,
	lead(transaction_amount) over( partition by account_id order by transaction_date ) As Next_Amount
from Transactions















