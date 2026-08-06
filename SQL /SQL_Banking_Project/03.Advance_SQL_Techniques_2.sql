/*==========================================================================================================
			SQL ADVANCE TECHNIQUES : VIEWS , CTAS ( CREATE TABLE AS SELECT ) & TEMP TABLES 
===========================================================================================================*/


-- A) VIEWS : 
-- TASK 7 : Create a view showing the total balance for each customer (Create View).

Create View V_CustomerTotalBalance AS
select 
	c.customer_id, c.first_name, c.last_name, c.customer_segment,
	sum(a.account_balance) as Total_balance
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id
group by c.customer_id,c.first_name,c.last_name,c.customer_segment;

select * from V_CustomerTotalBalance

-- Task 8 : Create a view showing accounts that have never had a transaction (Create View).

Create View V_DormantAccount AS 
select 
	a.account_id,a.account_type,a.account_status,a.open_date,
	t.transaction_id
from accounts as a
left join Transactions as t
on a.account_id = t.account_id
where t.transaction_id IS NULL;

select * from V_DormantAccount

-- Task 9 : Create a view showing successful transactions along with customer and account details (Create View).

Create View V_SuccessfullTransactions As 
select 
	t.transaction_id,t.transaction_date,t.transaction_amount, t.transaction_channel,t.transaction_status,
	a.account_type,
	c.first_name, c.last_name,c.customer_segment
from Transactions t
inner join accounts a
on t.account_id = a.account_id
inner join customers c
on a.customer_id = c.customer_id
where t.transaction_status = 'Success';

select * from V_SuccessfullTransactions
where transaction_channel = 'Mobile App';

-- Task 10 : Create a new table containing only Premium-segment customers (Use CTAS).

select
	customer_id,first_name,last_name,customer_segment,annual_income
into PremiumCustomers 
from customers
where customer_segment = 'Premium'

-- Task 11 : Store the total transaction amount for each account in a temporary table (Use Temp Table).
--Additionally, find accounts with total transactions greater than 200000, then drop the temp table.

select
	account_id,sum(transaction_amount) As total_Amount
into #AccountActivity
from transactions
group by account_id;

select
	a.account_id, a.account_type,a.account_balance,
	act.total_Amount
from accounts a
inner join #AccountActivity act
on a.account_id = act.account_id
where act.total_Amount > 200000;

drop table #AccountActivity







