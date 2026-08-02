-- ============================================================================
-- BANKING & FINANCIAL TRANSACTIONS PROJECT -- MASTER SCHEMA + DATA
-- Database Schema + Datasets  |  SQL Server (SSMS) Compatible
-- Business Focus: Customer Segmentation & Account Profitability
-- ============================================================================
-- DESIGN NOTES (read before building any topic's tasks against this data):
--   1. 6 customers deliberately have ZERO accounts (not yet onboarded) --
--      required for LEFT / RIGHT / FULL / ANTI JOIN tasks to return real rows.
--   2. ~20 accounts deliberately have ZERO transactions (dormant / unused) --
--      required for the same join types between Accounts and Transactions.
--   3. interest_rate is a genuine NULL for all Current accounts (they do not
--      earn interest) -- NOT 0.00 -- required for real NULL-function tasks
--      (ISNULL / COALESCE) on a numeric column.
--   4. merchant_category is NULL for every non-POS transaction -- required for
--      NULL-function tasks on a text column.
--   5. Accounts with transactions have between 1 and 6 transactions each --
--      enough row density per account for window ranking/value functions
--      (ROW_NUMBER, LAG, LEAD, etc.) partitioned by account_id.
--   6. All 4 account_status values (Active/Inactive/Dormant/Closed) and all
--      4 account_type values (Savings/Current/Fixed Deposit/Salary) are
--      represented with double-digit row counts each.
--   This file is the single source schema/data for ALL topics/phases of this
--   project. Do not regenerate or reshuffle it between phases -- every task
--   PDF is written to match these exact rows.
-- ============================================================================

CREATE DATABASE BankingProjectDB;
GO
USE BankingProjectDB;
GO

-- ============================================================================
-- TABLE 1: CUSTOMERS
-- ============================================================================
CREATE TABLE Customers (
    customer_id         INT PRIMARY KEY,
    first_name          VARCHAR(50)     NOT NULL,
    last_name           VARCHAR(50)     NOT NULL,
    date_of_birth       DATE            NOT NULL,
    gender              CHAR(1)         NOT NULL,
    city                VARCHAR(50)     NOT NULL,
    state               VARCHAR(50)     NOT NULL,
    annual_income       DECIMAL(12,2)   NOT NULL,
    customer_segment    VARCHAR(20)     NOT NULL,
    registration_date   DATE            NOT NULL
);
GO

-- Insert Customers Data
INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, gender, city, state, annual_income, customer_segment, registration_date)
VALUES
    (1, 'Kavya', 'Sharma', '1979-04-08', 'M', 'Indore', 'Madhya Pradesh', 448537.36, 'Retail', '2024-07-02'),
    (2, 'Priya', 'Patel', '1975-04-17', 'M', 'Ahmedabad', 'Gujarat', 700954.64, 'Premium', '2018-08-19'),
    (3, 'Divya', 'Sharma', '1972-12-14', 'F', 'Hyderabad', 'Telangana', 587356.29, 'Premium', '2016-02-13'),
    (4, 'Arjun', 'Rao', '1984-10-09', 'M', 'Indore', 'Madhya Pradesh', 1383693.18, 'Retail', '2021-02-18'),
    (5, 'Amit', 'Bhatt', '1985-10-07', 'M', 'Mumbai', 'Maharashtra', 1912509.89, 'Premium', '2016-04-28'),
    (6, 'Arjun', 'Chopra', '1979-08-21', 'F', 'Nashik', 'Maharashtra', 1149874.13, 'Retail', '2019-12-22'),
    (7, 'Vikram', 'Bhatt', '2002-03-18', 'M', 'Nashik', 'Maharashtra', 1391121.76, 'Premium', '2023-04-22'),
    (8, 'Suresh', 'Verma', '1976-01-26', 'F', 'Delhi', 'Delhi', 881481.10, 'Retail', '2024-12-11'),
    (9, 'Ananya', 'Desai', '1987-11-15', 'M', 'Hyderabad', 'Telangana', 545831.44, 'Premium', '2024-07-19'),
    (10, 'Deepika', 'Rao', '1976-03-17', 'F', 'Pune', 'Maharashtra', 2160149.25, 'Premium', '2017-11-06'),
    (11, 'Nisha', 'Bhatt', '1966-07-13', 'F', 'Ahmedabad', 'Gujarat', 838704.99, 'Retail', '2016-11-18'),
    (12, 'Divya', 'Singh', '1969-05-14', 'M', 'Jaipur', 'Rajasthan', 188502.73, 'Retail', '2019-09-25'),
    (13, 'Meera', 'Pillai', '1968-11-10', 'M', 'Nashik', 'Maharashtra', 1159654.29, 'Retail', '2023-09-01'),
    (14, 'Sandeep', 'Singh', '1993-01-04', 'F', 'Hyderabad', 'Telangana', 807365.05, 'Retail', '2024-02-03'),
    (15, 'Simran', 'Patel', '1996-03-05', 'F', 'Ahmedabad', 'Gujarat', 612632.63, 'Premium', '2018-09-25'),
    (16, 'Sanjay', 'Kapoor', '1987-11-21', 'F', 'Jaipur', 'Rajasthan', 2536988.90, 'Premium', '2018-04-03'),
    (17, 'Anjali', 'Sharma', '1999-09-08', 'M', 'Mumbai', 'Maharashtra', 366001.89, 'Retail', '2018-02-02'),
    (18, 'Anjali', 'Patel', '1994-04-09', 'F', 'Bengaluru', 'Karnataka', 1592792.90, 'Premium', '2018-08-26'),
    (19, 'Ashok', 'Mehta', '1968-02-22', 'F', 'Chennai', 'Tamil Nadu', 1289775.99, 'Premium', '2015-11-21'),
    (20, 'Arjun', 'Verma', '1987-12-11', 'M', 'Bengaluru', 'Karnataka', 681965.99, 'Premium', '2017-07-06'),
    (21, 'Divya', 'Kulkarni', '1977-02-15', 'M', 'Mumbai', 'Maharashtra', 1888619.62, 'Premium', '2015-02-25'),
    (22, 'Pooja', 'Iyer', '1988-08-16', 'M', 'Delhi', 'Delhi', 2544400.31, 'Corporate', '2015-07-09'),
    (23, 'Preeti', 'Kapoor', '1989-12-24', 'F', 'Nashik', 'Maharashtra', 677532.41, 'Retail', '2015-10-24'),
    (24, 'Devendra', 'Verma', '1982-01-02', 'F', 'Ahmedabad', 'Gujarat', 2588794.28, 'Premium', '2015-09-03'),
    (25, 'Meera', 'Patel', '2000-02-22', 'M', 'Delhi', 'Delhi', 494102.93, 'Retail', '2024-10-02'),
    (26, 'Aarti', 'Patel', '1988-11-19', 'F', 'Hyderabad', 'Telangana', 715159.10, 'Premium', '2018-05-13'),
    (27, 'Karan', 'Kapoor', '1991-06-25', 'M', 'Mumbai', 'Maharashtra', 1380708.07, 'Retail', '2016-09-07'),
    (28, 'Yash', 'Joshi', '1970-06-03', 'M', 'Chennai', 'Tamil Nadu', 926666.96, 'Premium', '2023-12-10'),
    (29, 'Aarti', 'Pillai', '1962-11-27', 'F', 'Kolkata', 'West Bengal', 451396.64, 'Retail', '2019-02-04'),
    (30, 'Ritu', 'Reddy', '1979-05-20', 'M', 'Indore', 'Madhya Pradesh', 1078346.35, 'Premium', '2023-08-09'),
    (31, 'Sneha', 'Patel', '2002-07-27', 'F', 'Mumbai', 'Maharashtra', 189289.71, 'Retail', '2019-03-24'),
    (32, 'Gaurav', 'Bose', '1989-09-01', 'M', 'Pune', 'Maharashtra', 2656033.46, 'Premium', '2017-09-02'),
    (33, 'Swati', 'Agarwal', '1997-03-14', 'M', 'Mumbai', 'Maharashtra', 987636.88, 'Retail', '2020-04-22'),
    (34, 'Pooja', 'Gupta', '1984-09-28', 'F', 'Lucknow', 'Uttar Pradesh', 2143631.34, 'Premium', '2018-03-26'),
    (35, 'Meera', 'Malhotra', '1963-03-24', 'F', 'Delhi', 'Delhi', 2281856.06, 'Premium', '2018-05-06'),
    (36, 'Arjun', 'Chopra', '1964-08-08', 'M', 'Jaipur', 'Rajasthan', 1096105.07, 'Retail', '2018-01-22'),
    (37, 'Sanjay', 'Chopra', '1983-05-28', 'M', 'Hyderabad', 'Telangana', 1100002.86, 'Premium', '2023-06-01'),
    (38, 'Kavya', 'Joshi', '1973-10-09', 'M', 'Pune', 'Maharashtra', 1743016.69, 'Premium', '2020-07-20'),
    (39, 'Yash', 'Gupta', '1986-10-07', 'F', 'Mumbai', 'Maharashtra', 2037017.44, 'Corporate', '2023-11-24'),
    (40, 'Sanjay', 'Rao', '1989-02-22', 'F', 'Lucknow', 'Uttar Pradesh', 1002458.99, 'Retail', '2019-09-10');
GO

-- ============================================================================
-- TABLE 2: ACCOUNTS
-- ============================================================================
CREATE TABLE Accounts (
    account_id              INT PRIMARY KEY,
    customer_id             INT             NOT NULL,
    account_type            VARCHAR(20)     NOT NULL,
    account_status          VARCHAR(15)     NOT NULL,
    open_date               DATE            NOT NULL,
    branch_name             VARCHAR(50)     NOT NULL,
    currency                CHAR(3)         NOT NULL,
    account_balance         DECIMAL(15,2)   NOT NULL,
    interest_rate           DECIMAL(5,2)    NULL,
    min_balance_required    DECIMAL(12,2)   NOT NULL,
    CONSTRAINT FK_Accounts_Customers FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- Insert Accounts Data
INSERT INTO Accounts (account_id, customer_id, account_type, account_status, open_date, branch_name, currency, account_balance, interest_rate, min_balance_required)
VALUES
    (1001, 1, 'Current', 'Inactive', '2025-01-12', 'Koramangala Branch', 'INR', 555885.85, NULL, 11019.00),
    (1002, 2, 'Savings', 'Active', '2019-01-12', 'Banjara Hills Branch', 'INR', 172240.32, 3.66, 6892.35),
    (1003, 2, 'Salary', 'Inactive', '2019-04-02', 'Banjara Hills Branch', 'INR', 204714.01, 4.09, 9638.49),
    (1004, 3, 'Current', 'Closed', '2016-03-27', 'Connaught Place Branch', 'INR', 466329.55, NULL, 17658.82),
    (1005, 3, 'Fixed Deposit', 'Active', '2016-06-12', 'Connaught Place Branch', 'INR', 375728.97, 6.30, 0.00),
    (1006, 3, 'Savings', 'Active', '2016-06-17', 'Vaishali Nagar Branch', 'INR', 244703.95, 4.04, 5098.75),
    (1007, 4, 'Current', 'Closed', '2021-09-02', 'Vaishali Nagar Branch', 'INR', 362689.31, NULL, 7951.43),
    (1008, 4, 'Savings', 'Active', '2021-09-23', 'Banjara Hills Branch', 'INR', 70766.73, 4.42, 5661.62),
    (1009, 4, 'Savings', 'Dormant', '2021-06-25', 'Andheri West Branch', 'INR', 182856.50, 4.10, 7008.20),
    (1010, 5, 'Fixed Deposit', 'Inactive', '2017-01-11', 'Salt Lake Branch', 'INR', 1254325.30, 6.82, 0.00),
    (1011, 5, 'Current', 'Closed', '2016-12-27', 'Vaishali Nagar Branch', 'INR', 236976.44, NULL, 9944.79),
    (1012, 6, 'Fixed Deposit', 'Dormant', '2020-08-26', 'Banjara Hills Branch', 'INR', 448166.30, 6.12, 0.00),
    (1013, 6, 'Fixed Deposit', 'Active', '2020-05-09', 'FC Road Branch', 'INR', 513578.87, 6.81, 0.00),
    (1014, 6, 'Current', 'Active', '2020-04-18', 'Salt Lake Branch', 'INR', 626085.08, NULL, 19128.38),
    (1015, 7, 'Salary', 'Inactive', '2023-10-08', 'Vaishali Nagar Branch', 'INR', 166601.81, 2.91, 4781.29),
    (1016, 8, 'Savings', 'Dormant', '2025-06-23', 'Vaishali Nagar Branch', 'INR', 2855.49, 3.20, 7781.28),
    (1017, 8, 'Salary', 'Dormant', '2025-09-16', 'Banjara Hills Branch', 'INR', 195547.68, 3.05, 5370.78),
    (1018, 9, 'Fixed Deposit', 'Closed', '2025-02-11', 'Koramangala Branch', 'INR', 1268733.21, 7.38, 0.00),
    (1019, 9, 'Savings', 'Inactive', '2025-05-03', 'MG Road Branch', 'INR', 34037.01, 3.36, 8801.66),
    (1020, 10, 'Savings', 'Active', '2018-05-19', 'FC Road Branch', 'INR', 85058.28, 3.15, 7851.07),
    (1021, 11, 'Fixed Deposit', 'Inactive', '2017-03-27', 'Andheri West Branch', 'INR', 731944.91, 7.12, 0.00),
    (1022, 11, 'Savings', 'Active', '2017-03-12', 'Andheri West Branch', 'INR', 312602.60, 3.80, 7788.10),
    (1023, 12, 'Current', 'Active', '2019-12-12', 'Banjara Hills Branch', 'INR', 117967.77, NULL, 18389.18),
    (1024, 13, 'Current', 'Inactive', '2024-01-10', 'FC Road Branch', 'INR', 155171.28, NULL, 17144.95),
    (1025, 13, 'Savings', 'Active', '2024-02-07', 'Andheri West Branch', 'INR', 231684.55, 4.36, 6182.17),
    (1026, 14, 'Salary', 'Closed', '2024-05-14', 'Andheri West Branch', 'INR', 237043.10, 4.16, 3185.64),
    (1027, 14, 'Fixed Deposit', 'Closed', '2024-04-04', 'MG Road Branch', 'INR', 553445.46, 6.64, 0.00),
    (1028, 15, 'Savings', 'Dormant', '2019-03-18', 'MG Road Branch', 'INR', 339905.46, 4.14, 1949.85),
    (1029, 16, 'Salary', 'Closed', '2018-06-20', 'Salt Lake Branch', 'INR', 70866.72, 3.54, 6854.12),
    (1030, 17, 'Salary', 'Inactive', '2018-09-13', 'Connaught Place Branch', 'INR', 129260.68, 2.99, 9411.60),
    (1031, 17, 'Fixed Deposit', 'Inactive', '2018-06-06', 'Vaishali Nagar Branch', 'INR', 876281.98, 7.00, 0.00),
    (1032, 18, 'Savings', 'Inactive', '2019-02-08', 'Koramangala Branch', 'INR', 195276.20, 3.21, 3325.17),
    (1033, 20, 'Fixed Deposit', 'Dormant', '2017-07-11', 'Banjara Hills Branch', 'INR', 174138.79, 7.08, 0.00),
    (1034, 22, 'Current', 'Closed', '2016-03-08', 'Vaishali Nagar Branch', 'INR', 406116.22, NULL, 5344.87),
    (1035, 22, 'Fixed Deposit', 'Active', '2016-02-01', 'Banjara Hills Branch', 'INR', 493998.74, 6.87, 0.00),
    (1036, 23, 'Fixed Deposit', 'Inactive', '2016-07-31', 'FC Road Branch', 'INR', 560125.27, 6.68, 0.00),
    (1037, 23, 'Fixed Deposit', 'Active', '2016-02-19', 'Andheri West Branch', 'INR', 1095862.28, 6.47, 0.00),
    (1038, 24, 'Current', 'Active', '2015-12-22', 'Vaishali Nagar Branch', 'INR', 252467.17, NULL, 16791.74),
    (1039, 24, 'Fixed Deposit', 'Active', '2015-12-11', 'Connaught Place Branch', 'INR', 379850.59, 6.27, 0.00),
    (1040, 24, 'Savings', 'Closed', '2016-06-02', 'Koramangala Branch', 'INR', 110087.38, 4.45, 5980.23),
    (1041, 25, 'Current', 'Closed', '2025-06-10', 'Andheri West Branch', 'INR', 786084.16, NULL, 16481.28),
    (1042, 25, 'Salary', 'Inactive', '2025-05-15', 'FC Road Branch', 'INR', 74153.29, 2.60, 9469.57),
    (1043, 25, 'Salary', 'Active', '2024-11-04', 'Salt Lake Branch', 'INR', 196952.75, 3.65, 7178.06),
    (1044, 28, 'Current', 'Dormant', '2024-05-13', 'Andheri West Branch', 'INR', 894556.72, NULL, 7369.03),
    (1045, 29, 'Current', 'Dormant', '2019-08-17', 'Vaishali Nagar Branch', 'INR', 818111.42, NULL, 10947.06),
    (1046, 29, 'Salary', 'Active', '2019-11-22', 'MG Road Branch', 'INR', 244047.55, 3.98, 9528.31),
    (1047, 30, 'Current', 'Active', '2023-09-19', 'Koramangala Branch', 'INR', 219679.33, NULL, 16039.84),
    (1048, 31, 'Savings', 'Inactive', '2019-11-09', 'Vaishali Nagar Branch', 'INR', 116858.09, 2.96, 7362.60),
    (1049, 32, 'Salary', 'Active', '2017-12-30', 'Connaught Place Branch', 'INR', 315237.30, 3.75, 6950.65),
    (1050, 32, 'Current', 'Inactive', '2017-10-30', 'Banjara Hills Branch', 'INR', 584633.08, NULL, 23168.23),
    (1051, 32, 'Current', 'Active', '2017-10-02', 'Koramangala Branch', 'INR', 714402.57, NULL, 16900.88),
    (1052, 33, 'Fixed Deposit', 'Inactive', '2020-06-24', 'Vaishali Nagar Branch', 'INR', 1048583.09, 7.05, 0.00),
    (1053, 33, 'Fixed Deposit', 'Dormant', '2021-01-23', 'Vaishali Nagar Branch', 'INR', 684750.35, 6.90, 0.00),
    (1054, 34, 'Fixed Deposit', 'Dormant', '2018-08-01', 'MG Road Branch', 'INR', 182423.99, 7.44, 0.00),
    (1055, 34, 'Savings', 'Closed', '2018-08-10', 'MG Road Branch', 'INR', 305362.05, 2.85, 5670.67),
    (1056, 35, 'Fixed Deposit', 'Active', '2019-03-01', 'Salt Lake Branch', 'INR', 970437.84, 6.74, 0.00),
    (1057, 35, 'Savings', 'Inactive', '2018-10-31', 'Salt Lake Branch', 'INR', 133656.70, 3.84, 8719.60),
    (1058, 37, 'Salary', 'Closed', '2024-02-09', 'Connaught Place Branch', 'INR', 265202.12, 3.30, 7844.50),
    (1059, 38, 'Salary', 'Active', '2020-12-28', 'Connaught Place Branch', 'INR', 129647.88, 4.44, 4637.58),
    (1060, 39, 'Savings', 'Closed', '2024-08-27', 'Vaishali Nagar Branch', 'INR', 165592.40, 2.88, 4256.01);
GO

-- ============================================================================
-- TABLE 3: TRANSACTIONS
-- ============================================================================
CREATE TABLE Transactions (
    transaction_id              INT PRIMARY KEY,
    account_id                  INT             NOT NULL,
    transaction_date             DATETIME        NOT NULL,
    transaction_type            VARCHAR(20)     NOT NULL,
    transaction_amount          DECIMAL(12,2)   NOT NULL,
    transaction_channel         VARCHAR(20)     NOT NULL,
    transaction_status          VARCHAR(10)     NOT NULL,
    balance_after_transaction   DECIMAL(15,2)   NOT NULL,
    merchant_category            VARCHAR(30)     NULL,
    description                 VARCHAR(100)    NOT NULL,
    CONSTRAINT FK_Transactions_Accounts FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);
GO

-- Insert Transactions Data
INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, transaction_amount, transaction_channel, transaction_status, balance_after_transaction, merchant_category, description)
VALUES
    (500001, 1042, '2025-10-09 04:46:12', 'Fee', 699.37, 'ATM', 'Success', 73534.45, NULL, 'Account maintenance / service fee'),
    (500002, 1056, '2025-05-03 05:45:58', 'Fee', 267.53, 'ATM', 'Success', 965574.58, NULL, 'Account maintenance / service fee'),
    (500003, 1035, '2025-02-28 16:48:02', 'Deposit', 142085.58, 'Online Banking', 'Pending', 495475.84, NULL, 'Cash/cheque deposit to account'),
    (500004, 1013, '2025-05-20 15:07:39', 'Fee', 634.31, 'Branch', 'Success', 518381.32, NULL, 'Account maintenance / service fee'),
    (500005, 1020, '2025-04-08 21:49:21', 'Fee', 405.77, 'POS', 'Success', 88851.54, 'Pharmacy', 'Account maintenance / service fee'),
    (500006, 1006, '2025-09-17 09:43:38', 'Transfer', 164199.62, 'Mobile App', 'Success', 242532.34, NULL, 'Fund transfer to another account'),
    (500007, 1024, '2025-09-08 05:24:36', 'Interest Credit', 2243.81, 'POS', 'Pending', 155014.69, 'Fuel', 'Interest credited to account'),
    (500008, 1046, '2025-06-14 06:52:07', 'Interest Credit', 4904.26, 'Mobile App', 'Success', 241435.61, NULL, 'Interest credited to account'),
    (500009, 1032, '2025-08-31 13:52:48', 'Withdrawal', 31009.08, 'Mobile App', 'Success', 196913.09, NULL, 'Cash withdrawal'),
    (500010, 1052, '2025-03-06 18:17:16', 'Withdrawal', 77235.22, 'Mobile App', 'Pending', 1046903.04, NULL, 'Cash withdrawal'),
    (500011, 1009, '2025-08-22 00:33:31', 'Fee', 555.71, 'ATM', 'Success', 181956.29, NULL, 'Account maintenance / service fee'),
    (500012, 1052, '2025-05-16 12:19:35', 'Withdrawal', 49936.10, 'ATM', 'Success', 1047557.92, NULL, 'Cash withdrawal'),
    (500013, 1008, '2025-06-12 22:49:15', 'Transfer', 143884.13, 'POS', 'Success', 73360.75, 'Pharmacy', 'Fund transfer to another account'),
    (500014, 1045, '2025-05-28 08:16:57', 'Deposit', 112141.57, 'POS', 'Success', 817451.13, 'Grocery', 'Cash/cheque deposit to account'),
    (500015, 1051, '2025-06-03 01:03:14', 'Deposit', 7375.65, 'Mobile App', 'Success', 717364.00, NULL, 'Cash/cheque deposit to account'),
    (500016, 1023, '2025-05-06 19:20:21', 'Transfer', 82704.32, 'Branch', 'Success', 119785.77, NULL, 'Fund transfer to another account'),
    (500017, 1015, '2025-07-15 22:33:46', 'Withdrawal', 54714.14, 'Online Banking', 'Success', 166578.48, NULL, 'Cash withdrawal'),
    (500018, 1048, '2025-05-11 16:43:56', 'Withdrawal', 20575.07, 'Online Banking', 'Success', 111952.06, NULL, 'Cash withdrawal'),
    (500019, 1038, '2025-08-15 12:34:53', 'Transfer', 197536.51, 'POS', 'Success', 250458.71, 'Dining', 'Fund transfer to another account'),
    (500020, 1056, '2025-04-12 14:00:22', 'Transfer', 170740.42, 'Mobile App', 'Success', 966504.37, NULL, 'Fund transfer to another account'),
    (500021, 1032, '2025-06-01 00:47:55', 'Interest Credit', 4890.16, 'Branch', 'Success', 196858.50, NULL, 'Interest credited to account'),
    (500022, 1022, '2025-01-26 22:04:42', 'Deposit', 111903.24, 'POS', 'Success', 315930.99, 'Fuel', 'Cash/cheque deposit to account'),
    (500023, 1019, '2025-04-08 22:36:21', 'Interest Credit', 1268.12, 'Branch', 'Success', 36592.78, NULL, 'Interest credited to account'),
    (500024, 1053, '2025-01-21 11:14:52', 'Withdrawal', 63131.12, 'ATM', 'Failed', 680084.00, NULL, 'Cash withdrawal'),
    (500025, 1031, '2025-06-17 15:07:40', 'Withdrawal', 14216.08, 'ATM', 'Failed', 872603.58, NULL, 'Cash withdrawal'),
    (500026, 1045, '2025-05-20 05:59:27', 'Transfer', 51765.53, 'POS', 'Success', 821358.32, 'Dining', 'Fund transfer to another account'),
    (500027, 1023, '2025-02-08 05:07:29', 'Transfer', 150953.22, 'ATM', 'Success', 115223.92, NULL, 'Fund transfer to another account'),
    (500028, 1054, '2025-07-22 00:30:24', 'Fee', 235.12, 'POS', 'Success', 178659.88, 'Fuel', 'Account maintenance / service fee'),
    (500029, 1054, '2025-07-10 03:56:41', 'Transfer', 135129.89, 'POS', 'Success', 182138.76, 'Travel', 'Fund transfer to another account'),
    (500030, 1046, '2025-02-02 23:08:03', 'Transfer', 164859.14, 'POS', 'Success', 248141.43, 'Fuel', 'Fund transfer to another account'),
    (500031, 1052, '2025-01-20 11:04:53', 'Fee', 747.15, 'ATM', 'Success', 1044744.29, NULL, 'Account maintenance / service fee'),
    (500032, 1020, '2025-07-09 19:40:04', 'Interest Credit', 2107.25, 'Online Banking', 'Success', 87480.97, NULL, 'Interest credited to account'),
    (500033, 1013, '2025-07-28 10:11:06', 'Fee', 72.90, 'ATM', 'Success', 512284.17, NULL, 'Account maintenance / service fee'),
    (500034, 1037, '2025-02-20 13:22:27', 'Fee', 431.13, 'Online Banking', 'Success', 1100640.71, NULL, 'Account maintenance / service fee'),
    (500035, 1030, '2025-03-04 16:33:20', 'Deposit', 14205.18, 'Mobile App', 'Success', 126381.74, NULL, 'Cash/cheque deposit to account'),
    (500036, 1051, '2025-06-20 08:52:05', 'Interest Credit', 4944.33, 'ATM', 'Success', 717272.35, NULL, 'Interest credited to account'),
    (500037, 1017, '2025-04-21 08:28:59', 'Deposit', 49619.65, 'POS', 'Success', 192023.22, 'Travel', 'Cash/cheque deposit to account'),
    (500038, 1001, '2025-10-04 09:07:33', 'Transfer', 159803.51, 'Online Banking', 'Pending', 551985.11, NULL, 'Fund transfer to another account'),
    (500039, 1002, '2025-05-02 21:26:22', 'Withdrawal', 26036.96, 'ATM', 'Success', 168982.78, NULL, 'Cash withdrawal'),
    (500040, 1005, '2025-02-02 17:20:22', 'Withdrawal', 35972.36, 'Mobile App', 'Success', 374349.36, NULL, 'Cash withdrawal'),
    (500041, 1048, '2025-01-23 23:59:23', 'Deposit', 78456.96, 'Mobile App', 'Success', 116438.52, NULL, 'Cash/cheque deposit to account'),
    (500042, 1002, '2025-08-07 03:55:50', 'Deposit', 73795.19, 'Mobile App', 'Success', 176337.33, NULL, 'Cash/cheque deposit to account'),
    (500043, 1006, '2025-02-03 04:35:40', 'Deposit', 41614.89, 'Branch', 'Success', 246034.72, NULL, 'Cash/cheque deposit to account'),
    (500044, 1046, '2025-09-29 10:44:12', 'Transfer', 91016.23, 'Mobile App', 'Pending', 245101.82, NULL, 'Fund transfer to another account'),
    (500045, 1009, '2025-04-21 15:39:30', 'Deposit', 68007.46, 'POS', 'Success', 180141.44, 'Fuel', 'Cash/cheque deposit to account'),
    (500046, 1038, '2025-06-10 15:32:16', 'Fee', 268.77, 'Mobile App', 'Success', 250016.07, NULL, 'Account maintenance / service fee'),
    (500047, 1013, '2025-02-13 03:23:39', 'Fee', 352.31, 'ATM', 'Success', 516024.76, NULL, 'Account maintenance / service fee'),
    (500048, 1031, '2025-10-15 20:27:00', 'Withdrawal', 26505.75, 'POS', 'Success', 872504.29, 'Fuel', 'Cash withdrawal'),
    (500049, 1053, '2025-06-09 12:48:10', 'Fee', 122.52, 'ATM', 'Pending', 684824.48, NULL, 'Account maintenance / service fee'),
    (500050, 1013, '2025-06-29 20:15:10', 'Fee', 307.29, 'Online Banking', 'Success', 516204.93, NULL, 'Account maintenance / service fee'),
    (500051, 1047, '2025-10-13 00:57:21', 'Withdrawal', 48797.79, 'Mobile App', 'Success', 221257.64, NULL, 'Cash withdrawal'),
    (500052, 1056, '2025-06-08 12:22:21', 'Transfer', 70529.17, 'ATM', 'Success', 967251.90, NULL, 'Fund transfer to another account'),
    (500053, 1013, '2025-01-16 03:20:26', 'Interest Credit', 3735.64, 'Mobile App', 'Success', 510730.20, NULL, 'Interest credited to account'),
    (500054, 1035, '2025-06-09 11:48:37', 'Fee', 593.78, 'Branch', 'Success', 494674.68, NULL, 'Account maintenance / service fee'),
    (500055, 1008, '2025-01-26 02:58:13', 'Deposit', 41179.38, 'Online Banking', 'Success', 72386.12, NULL, 'Cash/cheque deposit to account'),
    (500056, 1042, '2025-04-21 18:39:14', 'Interest Credit', 586.81, 'Mobile App', 'Success', 73452.43, NULL, 'Interest credited to account'),
    (500057, 1023, '2025-06-07 01:39:12', 'Interest Credit', 1118.18, 'Mobile App', 'Success', 122812.23, NULL, 'Interest credited to account'),
    (500058, 1005, '2025-04-19 04:59:47', 'Deposit', 114742.05, 'Online Banking', 'Success', 373623.44, NULL, 'Cash/cheque deposit to account'),
    (500059, 1010, '2025-03-31 04:42:12', 'Deposit', 57341.01, 'Mobile App', 'Success', 1256362.01, NULL, 'Cash/cheque deposit to account'),
    (500060, 1043, '2025-01-22 15:52:56', 'Interest Credit', 113.33, 'Branch', 'Success', 201164.37, NULL, 'Interest credited to account'),
    (500061, 1025, '2025-08-02 10:32:27', 'Interest Credit', 593.56, 'Mobile App', 'Success', 226893.12, NULL, 'Interest credited to account'),
    (500062, 1025, '2025-07-05 03:12:31', 'Withdrawal', 35049.60, 'POS', 'Success', 227743.18, 'Dining', 'Cash withdrawal'),
    (500063, 1048, '2025-06-08 12:21:40', 'Fee', 205.10, 'POS', 'Success', 119649.27, 'Grocery', 'Account maintenance / service fee'),
    (500064, 1043, '2025-06-28 12:46:59', 'Deposit', 109243.18, 'POS', 'Success', 200142.24, 'Pharmacy', 'Cash/cheque deposit to account'),
    (500065, 1013, '2025-04-12 06:19:00', 'Withdrawal', 48271.44, 'ATM', 'Success', 516181.02, NULL, 'Cash withdrawal'),
    (500066, 1052, '2025-09-10 16:53:31', 'Deposit', 113289.65, 'Online Banking', 'Failed', 1051181.86, NULL, 'Cash/cheque deposit to account'),
    (500067, 1037, '2025-06-11 05:29:46', 'Interest Credit', 2210.02, 'POS', 'Success', 1095551.49, 'Utilities', 'Interest credited to account'),
    (500068, 1024, '2025-09-17 02:42:04', 'Transfer', 62426.37, 'POS', 'Success', 154690.42, 'Grocery', 'Fund transfer to another account'),
    (500069, 1031, '2025-02-16 22:23:30', 'Transfer', 119018.92, 'ATM', 'Success', 875126.80, NULL, 'Fund transfer to another account'),
    (500070, 1048, '2025-10-20 23:43:57', 'Interest Credit', 957.43, 'ATM', 'Success', 117908.15, NULL, 'Interest credited to account'),
    (500071, 1043, '2025-06-25 03:04:13', 'Withdrawal', 40463.01, 'ATM', 'Success', 193678.34, NULL, 'Cash withdrawal'),
    (500072, 1020, '2025-03-23 13:14:56', 'Fee', 311.00, 'Mobile App', 'Success', 82887.22, NULL, 'Account maintenance / service fee'),
    (500073, 1035, '2025-06-21 02:23:59', 'Transfer', 66273.31, 'POS', 'Success', 494578.37, 'Dining', 'Fund transfer to another account'),
    (500074, 1023, '2025-06-20 02:58:02', 'Transfer', 116756.53, 'POS', 'Success', 114382.05, 'Fuel', 'Fund transfer to another account'),
    (500075, 1024, '2025-02-13 11:16:17', 'Fee', 441.25, 'Online Banking', 'Success', 156606.21, NULL, 'Account maintenance / service fee'),
    (500076, 1028, '2025-08-05 18:30:48', 'Withdrawal', 29073.88, 'POS', 'Success', 338531.44, 'Electronics', 'Cash withdrawal'),
    (500077, 1017, '2025-03-12 05:38:28', 'Transfer', 15894.43, 'Mobile App', 'Success', 198991.96, NULL, 'Fund transfer to another account'),
    (500078, 1009, '2025-09-27 01:22:27', 'Interest Credit', 3316.41, 'POS', 'Success', 186620.43, 'Travel', 'Interest credited to account'),
    (500079, 1012, '2025-04-03 22:44:45', 'Interest Credit', 4049.04, 'Mobile App', 'Success', 444821.69, NULL, 'Interest credited to account'),
    (500080, 1037, '2025-05-02 16:10:22', 'Deposit', 91784.02, 'Mobile App', 'Success', 1098386.19, NULL, 'Cash/cheque deposit to account'),
    (500081, 1037, '2025-08-29 07:03:50', 'Withdrawal', 29553.71, 'POS', 'Success', 1100333.58, 'Dining', 'Cash withdrawal'),
    (500082, 1038, '2025-08-03 05:54:01', 'Transfer', 163469.80, 'Mobile App', 'Success', 255479.76, NULL, 'Fund transfer to another account'),
    (500083, 1012, '2025-07-10 20:11:24', 'Transfer', 186891.56, 'ATM', 'Success', 450280.31, NULL, 'Fund transfer to another account'),
    (500084, 1044, '2025-03-24 09:55:55', 'Deposit', 67673.22, 'Branch', 'Success', 894690.25, NULL, 'Cash/cheque deposit to account'),
    (500085, 1036, '2025-06-28 00:58:15', 'Deposit', 62527.09, 'Online Banking', 'Success', 559089.81, NULL, 'Cash/cheque deposit to account'),
    (500086, 1031, '2025-07-11 08:10:30', 'Withdrawal', 2449.37, 'Mobile App', 'Pending', 880590.24, NULL, 'Cash withdrawal'),
    (500087, 1057, '2025-05-27 17:12:05', 'Transfer', 139366.36, 'Online Banking', 'Success', 130044.63, NULL, 'Fund transfer to another account'),
    (500088, 1057, '2025-02-10 00:41:30', 'Fee', 229.15, 'Mobile App', 'Success', 137006.33, NULL, 'Account maintenance / service fee'),
    (500089, 1046, '2025-05-28 08:39:07', 'Interest Credit', 1519.73, 'POS', 'Success', 239525.04, 'Dining', 'Interest credited to account'),
    (500090, 1051, '2025-09-13 21:43:35', 'Interest Credit', 2689.55, 'Mobile App', 'Success', 715722.12, NULL, 'Interest credited to account'),
    (500091, 1047, '2025-01-01 22:23:04', 'Withdrawal', 28354.72, 'Online Banking', 'Success', 220385.97, NULL, 'Cash withdrawal'),
    (500092, 1015, '2025-02-04 19:09:11', 'Deposit', 81840.25, 'POS', 'Pending', 169465.93, 'Travel', 'Cash/cheque deposit to account'),
    (500093, 1046, '2025-01-23 23:08:38', 'Deposit', 58338.76, 'Mobile App', 'Success', 242780.57, NULL, 'Cash/cheque deposit to account'),
    (500094, 1002, '2025-02-23 21:11:11', 'Transfer', 147169.80, 'ATM', 'Success', 170565.51, NULL, 'Fund transfer to another account'),
    (500095, 1003, '2025-03-31 16:54:59', 'Transfer', 196173.43, 'POS', 'Success', 204499.32, 'Electronics', 'Fund transfer to another account'),
    (500096, 1012, '2025-04-14 01:35:41', 'Deposit', 118770.83, 'Mobile App', 'Success', 452024.20, NULL, 'Cash/cheque deposit to account'),
    (500097, 1025, '2025-10-06 17:14:09', 'Transfer', 51036.10, 'POS', 'Success', 234217.46, 'Electronics', 'Fund transfer to another account'),
    (500098, 1023, '2025-06-19 09:56:51', 'Transfer', 25332.76, 'ATM', 'Success', 116647.96, NULL, 'Fund transfer to another account'),
    (500099, 1033, '2025-04-06 18:03:58', 'Fee', 534.45, 'Mobile App', 'Success', 172812.26, NULL, 'Account maintenance / service fee'),
    (500100, 1044, '2025-02-10 15:40:40', 'Transfer', 120689.43, 'ATM', 'Success', 897780.13, NULL, 'Fund transfer to another account');
GO
