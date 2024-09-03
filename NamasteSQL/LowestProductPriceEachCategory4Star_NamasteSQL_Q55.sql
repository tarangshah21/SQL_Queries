/*
You own a small online store, and want to analyze customer ratings for the products that you're selling. After doing a data pull, you have a list of products and a log of purchases. Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.

For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. The final output should be sorted by product category in alphabetical order.

Table: products
+-------------+-------------+
| COLUMN_NAME | DATA_TYPE   |
+-------------+-------------+
| category    | varchar(10) |
| id          | int         |
| name        | varchar(20) |
| price       | int         |
+-------------+-------------+
Table: purchases
+-------------+-----------+
| COLUMN_NAME | DATA_TYPE |
+-------------+-----------+
| id          | int       |
| product_id  | int       |
| stars       | int       |
+-------------+-----------+

Expected Output

+----------+-------+
| category | price |
+----------+-------+
| apple    |     0 |
| cherry   |    36 |
| grape    |     0 |
| orange   |    14 |
+----------+-------+

TABLES:

SELECT * FROM products;
SELECT * FROM purchases;

+------+------------------+----------+-------+
| id   | name             | category | price |
+------+------------------+----------+-------+
|    1 | Cripps Pink      | apple    |    10 |
|    2 | Navel Orange     | orange   |    12 |
|    3 | Golden Delicious | apple    |     6 |
|    4 | Clementine       | orange   |    14 |
|    5 | Pinot Noir       | grape    |    20 |
|    6 | Bing Cherries    | cherry   |    36 |
|    7 | Sweet Cherries   | cherry   |    40 |
+------+------------------+----------+-------+
+------+------------+-------+
| id   | product_id | stars |
+------+------------+-------+
|    1 |          1 |     2 |
|    2 |          3 |     3 |
|    3 |          2 |     2 |
|    4 |          4 |     4 |
|    5 |          6 |     5 |
|    6 |          6 |     4 |
|    7 |          7 |     5 |
+------+------------+-------+



Query:
*/

WITH min_price AS (
SELECT pr.category, pr.name, min(pr.price) AS min_price 
FROM purchases pu INNER JOIN products pr ON pr.id = pu.product_id
WHERE pu.stars >= 4
GROUP BY pr.category, pr.name),
result_ AS (
SELECT p.category, CASE WHEN min_price IS NULL THEN 0 ELSE MIN(min_price) END as price
FROM products p 
LEFT JOIN min_price mp ON p.category = mp.category
GROUP BY p.category, mp.min_price
ORDER BY p.category)
SELECT category, MIN(price) AS price FROM result_
GROUP BY category



