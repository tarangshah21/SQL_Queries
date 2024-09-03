/*

You are a data analyst working for an e-commerce company, responsible for analysing customer orders to gain insights into their purchasing behaviour. 
Your task is to write a SQL query to retrieve the details of the penultimate order for each customer. 
However, if a customer has placed only one order, you need to retrieve the details of that order instead, display the output in ascending order of customer name.

 
Table: orders
+---------------+-------------+
| COLUMN_NAME   | DATA_TYPE   |
+---------------+-------------+
| order_id      | int         |
| order_date    | date        |
| customer_name | varchar(10) |
| product_name  | varchar(10) |
| sales         | int         |
+---------------+-------------+

Table Output:

+----------+------------+---------------+--------------+-------+
| order_id | order_date | customer_name | product_name | sales |
+----------+------------+---------------+--------------+-------+
|        1 | 2023-01-01 | Alexa         | iphone       |   100 |
|        2 | 2023-01-02 | Alexa         | boAt         |   300 |
|        3 | 2023-01-03 | Alexa         | Rolex        |   400 |
|        4 | 2023-01-01 | Ramesh        | Titan        |   200 |
|        5 | 2023-01-02 | Ramesh        | Shirt        |   300 |
|        6 | 2023-01-03 | Neha          | Dress        |   100 |
+----------+------------+---------------+--------------+-------+

Expected Output:

+----------+------------+---------------+--------------+-------+
| order_id | order_date | customer_name | product_name | sales |
+----------+------------+---------------+--------------+-------+
|        2 | 2023-01-02 | Alexa         | boAt         |   300 |
|        6 | 2023-01-03 | Neha          | Dress        |   100 |
|        4 | 2023-01-01 | Ramesh        | Titan        |   200 |
+----------+------------+---------------+--------------+-------+

Query:
*/

WITH rank_cte AS (
SELECT *, RANK() over (partition BY customer_name ORDER BY order_date) AS rank_ FROM orders
),
max_rank AS (
SELECT customer_name, MAX(rank_) AS rank_2 
FROM rank_cte
GROUP BY customer_name),
penultimate_rank AS (
SELECT customer_name, rank_2, CASE WHEN rank_2 = 1 THEN 1 ELSE rank_2 - 1 END AS pen_rank
FROM max_rank)
SELECT r.order_id, r.order_date, r.customer_name, r.product_name, sales
FROM rank_cte AS r INNER JOIN penultimate_rank pr ON 
r.customer_name = pr.customer_name AND r.rank_ = pr.pen_rank
ORDER BY r.customer_name
