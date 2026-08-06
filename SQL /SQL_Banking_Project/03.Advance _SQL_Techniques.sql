/*==============================================================================
		BANKING DOMAIN PROJECT : SUBQUERY , CTE (COMMON TABLE EXPRESSION )
								 VIEWS 
================================================================================*/

-- A) SUBQUERY : 

--TASK 1 : Find accounts with a balance greater than the average balance of all accounts 
--(Use Subquery).
	select account_id,account_type,account_balance
	from accounts 
	where account_balance > (
						select avg(account_balance) from accounts 
                       );

-- Task 2 : Find customers who own at least one account (Use Subquery with IN).
select customer_id,first_name,last_name, customer_segment
from customers
where customer_id IN (
					select customer_id from accounts
					);

--Task 3 : Find the highest balance recorded at each account's branch (Use Correlated Subquery).
--Additionally, provide details such as Account ID and Branch Name.

select 
	account_id, branch_name,account_balance,
	( select max(a2.account_balance)
	  from accounts a2
	  where a2.branch_name = a1.branch_name
	) As Branch_highest_balance
from accounts a1

-- Task 4: Find customers whose total balance across all accounts is greater than 500000 (Use CTE).

WITH CTE_CustomerTotals As (
select 
	c.customer_id, c.first_name, c.last_name,
	sum(a.account_balance) As Total_balance
from customers c
inner join accounts a
on c.customer_id = a.customer_id
group by c.customer_id, c.first_name, c.last_name
)
select *
from CTE_CustomerTotals
where total_balance > 500000;

-- Task 5 : Find the top account by balance in each customer segment (Use CTE with Window Function).
WITH CTE_Account_Rank As (
select 
	c.customer_segment, a.account_id, a.account_balance,
	row_number() over (
	partition by c.customer_segment
	order by a.account_balance desc 
	) As Ranking
from customers c
inner join accounts a
on c.customer_id = a.customer_id 
)
select *
from CTE_Account_Rank
where Ranking = 1;

-- Task 6 : Calculate the net cash flow (total deposits minus total withdrawals) for each account (Use Multiple CTEs).
-------------------------- Total Deposite --------------------------------------------
With CTE_Deposite As (
select 
	account_id, sum(transaction_amount) As Total_Deposite
from transactions
where transaction_type = 'Deposit'
group by account_id
),
--------------------------- Total Withdrawal -----------------------------------------
CTE_Withdrawal As (
select 
	account_id, sum(transaction_amount) As Total_Withdrawal
from transactions
where transaction_type = 'Withdrawal'
group by account_id
)
select
	d.account_id, d.total_deposite, w.total_withdrawal,
	d.total_deposite - isnull(w.total_withdrawal,0) AS Net_Cash_Flow
from CTE_Deposite d
left join CTE_Withdrawal w
on d.account_id = w.account_id






