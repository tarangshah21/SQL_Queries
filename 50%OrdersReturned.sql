-- Write a Query to find out all the Customers who have returned 50% or more than 50% of their orders placed

create table orders(
order_id integer,
order_date date,
customer_name varchar(20),
sales integer
);

insert into orders values(1,'2024-01-01','Akhil',100);
insert into orders values(2,'2024-01-02','Akhil',200);
insert into orders values(3,'2024-01-03','Akhil',300);
insert into orders values(4,'2024-01-03','Akhil',400);
insert into orders values(5,'2024-01-01','Ajay',500);
insert into orders values(6,'2024-01-02','Ajay',600);
insert into orders values(7,'2024-01-03','Ajay',700);
insert into orders values(8,'2024-01-03','Neha',800);
insert into orders values(9,'2024-01-03','Ankit',800);
insert into orders values(10,'2024-01-04','Ankit',900);

create table returns(
order_id integer,
return_date date
);

insert into returns values(1,'2023-01-02');
insert into returns values(2,'2023-01-04');
insert into returns values(3,'2023-01-05');
insert into returns values(7,'2023-01-06');
insert into returns values(9,'2023-01-06');
insert into returns values(10,'2023-01-07');

select * FROM orders;
SELECT * FROM returns;

SELECT customer_name, Return_Percentage 
FROM (
SELECT customer_name, 
  COUNT(o.order_id) as total_ordered, 
  COUNT(r.order_id) as total_returned, 
  ROUND(COUNT(r.order_id)*100/COUNT(o.order_id),2) as Return_Percentage 
  FROM orders o LEFT JOIN returns r on o.order_id = r.order_id
GROUP BY customer_name
HAVING COUNT(r.order_id)>1)