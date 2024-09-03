/*You're working for a large financial institution that provides various types of loans to customers. Your task is to analyze loan repayment data to assess credit risk and improve risk management strategies.

Write an SQL to create 2 flags for each loan as per below rules. Display loan id, loan amount , due date and the 2 flags.

 

1- fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
2- on_time_flag : 1 if the loan was fully repaid on or before due date else 0.
Table: loans
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| loan_id     | int       |
| customer_id | int       |
| loan_amount | int       |
| due_date    | date      |
+-------------+-----------+
Table: payments
+--------------+-----------+
| COLUMN_NAME  | DATA_TYPE |
+--------------+-----------+
| amount_paid  | int       |
| loan_id      | int       |
| payment_date | date      |
| payment_id   | int       |
+--------------+-----------+

Expected Output

+---------+-------------+------------+-----------------+--------------+
| loan_id | loan_amount | due_date   | fully_paid_flag | on_time_flag |
+---------+-------------+------------+-----------------+--------------+
|       1 |        5000 | 2023-01-15 |               0 |            0 |
|       2 |        8000 | 2023-02-20 |               1 |            1 |
|       3 |       10000 | 2023-03-10 |               0 |            0 |
|       4 |        6000 | 2023-04-05 |               1 |            1 |
|       5 |        7000 | 2023-05-01 |               1 |            0 |
+---------+-------------+------------+-----------------+--------------+

*/

WITH loan_payment AS
(
SELECT loan_id, 
MAX(payment_date) AS last_payment_date, 
SUM(amount_paid) AS total_payment 
FROM Payments
GROUP BY loan_id)
SELECT l.loan_id, 
l.loan_amount, 
l.due_date, 
CASE WHEN loan_amount = total_payment THEN 1 ELSE 0 END AS full_paid_flag,
CASE WHEN due_date >= last_payment_date THEN 1 ELSE 0 END AS on_time_flag
FROM loans l INNER JOIN loan_payment p ON l.loan_id = p.loan_id
