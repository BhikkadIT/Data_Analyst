/*=========================================================
	ADVANCE SQL TECHNIQUES : (TRIGGERS )
===========================================================*/

-- DML TRIGGER : AFTER INSERT 

-- TASK 1 : Create Log Tables

create table sales.EmployeeLogs
	(
		Logid int identity(1,1) primary key,
		EmployeeID int,
		LogMessage varchar(255),
		LogDate    date
	);

-- TASK 2 : Create Trigger on Employee Table
-- Create the AFTER INSERT Trigger on Employees

create trigger trg_afterInsert_Employee on sales.Employees
after insert
as 
Begin
	insert into sales.EmployeeLogs (EmployeeID,LogMessage,LogDate)
	select
		EmployeeID,
		'New Employee Added = ' + CAST(EmployeeID AS VARCHAR ),
		GETDATE()
	from Inserted;
End;

-- TASK 3 : Insert a New Employee
-- Insert a New Employee - this fires the Trigger

insert into sales.Employees
values
	-- (6,'Maria','Doe','HR','1988-01-12','F',80000,3)
	(7,'Jos','Buttler','Cricket','1975-05-25','M',100000,4)

select * from sales.Employees

-- Task 4 : Verify theTrigger
-- Verify theTrigger wrote to the log Table

select *
from sales.EmployeeLogs


