/*==========================================================================================
		WINDOW FUNCTIONS : ( Aggregation Functions, Window Functions Basics )
============================================================================================*/

--Task 1: Generate a report showing the total sales amount, average transaction amount, and
--transaction count for each transaction type (Aggregate Data).

select
	transaction_type,
	sum(transaction_amount) as total_amount,
	avg(transaction_amount) as avg_amount,
	count(*) as account_count
from transactions
group by transaction_type 

-- Task 2: Find the minimum and maximum account balance for each customer segment
-- (Aggregate & Filter Groups).
-- Only include segments with more than 5 accounts.

select
	c.customer_segment,
	min(a.account_balance) as min_balance,
	max(a.account_balance) as max_balance,
	count(*) as account_count
from customers c
inner join accounts a
on c.customer_id = a.customer_id
group by c.customer_segment
having count(*)  > 5 ;

-- Task 3: Find the total number of transactions overall and the total number of transactions
-- for each account (Window Function Basics).

select
	transaction_id, account_id, transaction_date,
	count(*) over() as total_transactions,
	count(*) over(partition by account_id) as transactions_by_account
from transactions 

--  Task 4: Check the Accounts table for duplicate Account IDs (Window Function Basics).
select *
from (
	select
		account_id ,
		count(*) over( partition by account_id) as duplicate_check
	from accounts 
	)t 
where duplicate_check > 1;

-- Task 5: Find the total and average transaction amount overall and for each account
-- (Window Aggregation Functions).

select
	transaction_id,account_id, transaction_amount,
	sum(transaction_amount) over() as Total_amount_Overall,
	avg(transaction_amount) over() as Avg_Amount_Overall,
	sum(transaction_amount) over(partition by account_id) as TotalAmount_by_Account,
	avg(transaction_amount) over(partition by account_id) as AvgAmount_by_Account
from Transactions

-- Task 6: Find the lowest and highest transaction amount for each account (Window
-- Aggregation Functions).
-- Additionally, calculate how far each transaction is from both values.

select
	transaction_id, account_id, transaction_amount,
	min(transaction_amount) over(partition by account_id) as lowest_for_account,
	max(transaction_amount) over(partition by account_id) as highest_for_account,
	transaction_amount - min(transaction_amount) over(partition by account_id) as deviation_from_Min,
	max(transaction_amount) over(partition by account_id) - transaction_amount as Deviation_from_Max
from Transactions

-- Task 7: Rank each account based on their balance within their customer segment, from
-- highest to lowest (Window Ranking Functions).
-- Additionally, provide details such as Account ID and Customer Segment.

select
	c.customer_segment,
	c.customer_id,
	a.account_id,a.account_balance,
	row_number() over(partition by c.customer_segment Order by a.account_balance desc) as Rank_row_num,
	rank() over(partition by c.customer_segment Order by a.account_balance desc) as Rank_rank
from customers c
inner join accounts a
on c.customer_id = a.customer_id

-- Task 8: Rank each account within their segment without leaving gaps when balances tie,
-- and divide each segment's accounts into 4 equal groups based on balance (Window Ranking
-- Functions).

select
	c.customer_segment,a.account_id,a.account_balance,
	dense_rank() over (
		partition by c.customer_segment
		order by a.account_balance desc ) as dense_rank_num,
	ntile(4) over (partition by c.customer_segment
	order by a.account_balance desc) as balance_quartile
from customers c
inner join accounts a 
on c.customer_id = a.customer_id

-- Task 9: Find the previous and next transaction amount for each account, ordered by
-- transaction date (Window Value Functions).
-- Additionally, provide details such as Account ID and Transaction Date.

select
	account_id,transaction_id, transaction_date,transaction_amount,
	lag(transaction_amount) over ( partition by account_id order by transaction_date) as previous_amount,
	lead(transaction_amount) over( partition by account_id order by transaction_date) as next_amount
from Transactions

-- Task 10: Find the first and last transaction amount for each account (Window Value
-- Functions).

select
	account_id, transaction_id, transaction_date, transaction_amount,
	first_value(transaction_amount) over(partition by account_id order by transaction_date) as first_amount,
	last_value(transaction_amount) 
	over (
	       partition by account_id 
	       order by transaction_date
	       rows between unbounded preceding and unbounded following) as last_transaction_amount
from Transactions



















