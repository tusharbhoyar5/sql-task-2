create table customers (customer_id serial primary key, 	customer_name varchar,	city varchar,	
phone_number bigint,	email varchar,	registration_date date);

create table orders(order_id serial primary key,	customer_id	int references customers(customer_id), order_date date,	
order_amount int,	delivery_city varchar,	payment_mode varchar);

create table order_items(order_item_id serial primary key,	order_id int references orders(order_id),	
product_id int references products(product_id)  ,quantity int,	total_price int);

create table products(product_id serial primary key ,	product_name varchar,	category varchar,
price int,	stock_quantity int,	supplier_name varchar,	supplier_city varchar,	supply_date date);

select * from customers
select * from orders
select * from order_items
select * from products




select c.customer_name,c.city,o.order_date from customers c join orders o on c.customer_id=o.customer_id

select p.product_name,p.category,oi.total_price,c.city from  customers c 
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
WHERE c.city = 'Mumbai'

select c.customer_name, o.order_date, oi.total_price from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
WHERE o.payment_mode = 'Credit Card'
GROUP BY c.customer_name, o.order_date, oi.total_price;
   
select  o.order_date,p.product_name, p.category, oi.total_price  from  orders o
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
WHERE o.order_date >= '2023-01-01' AND o.order_date <= '2023-06-30';

	
select c.customer_name,
SUM(oi.quantity) AS total_products_ordered from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
GROUP BY c.customer_name;





SELECT distinct city from customers;

SELECT  distinct supplier_name from products;

SELECT distinct payment_mode from orders;

SELECT distinct category from products;

SELECT distinct supplier_city from products;





SELECT customer_name from customers order by customer_name ASC;

SELECT * from order_items order by total_price DESC;

SELECT * from products order by price ASC, category DESC;
SELECT * from products order by price ASC;
SELECT * from products order by  category DESC;

SELECT order_id, customer_id, order_date from orders order by order_date DESC;

SELECT c.city, COUNT(o.order_id) as total_order
from customers c
join orders o  on o.customer_id = c.customer_id group by c.city
order by c.city ASC;



SELECT customer_name from customers limit 10;

SELECT * from products order by price DESC limit 5;

SELECT * from orders order by customer_id offset 10 limit 10;

SELECT order_id, order_date, customer_id from orders where order_date between '2023-01-01' AND '2023-12-31'
order by order_date limit 5;

SELECT distinct customer_id,city from customers order by customer_id offset 10 limit 10 ;




SELECT c.customer_name , count(o.order_id) as total_order from customers c
join orders o on c.customer_id = o.customer_id group by c.customer_name;

SELECT sum(order_amount) as total_revenue from orders where payment_mode = 'UPI'; 
 
SELECT avg(price) from products;
 


SELECT product_id, sum(quantity) as total_quantity from order_items group by product_id;





SELECT distinct customer_id from orders where EXTRACT(YEAR from order_date) = 2022 
INTERSECT
SELECT distinct customer_id from orders where EXTRACT(YEAR from order_date) = 2023 

SELECT distinct product_id from order_items oi
JOIN orders o on oi.order_id = o.order_id
where EXTRACT(YEAR from o.order_date) = 2022 
EXCEPT
SELECT distinct product_id from order_items oi 
JOIN orders o on oi.order_id = o.order_id
where EXTRACT(YEAR from o.order_date) = 2023;

SELECT distinct P.supplier_city from products P
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id
EXCEPT
SELECT distinct c.city from  customers c 
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id

SELECT distinct P.supplier_city from products P
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id
join customers c on o.customer_id = c.customer_id
UNION
SELECT distinct c.city from  customers c 
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id

SELECT distinct p.product_name from products p
INTERSECT
SELECT distinct p.product_name from products p
join order_items oi on p.product_id = oi.product_id
join orders o on oi.order_id = o.order_id 
where extract(year from o.order_date) = 2023;




SELECT c.customer_name from customers c
join orders o on o.customer_id = c.customer_id
join order_items oi on oi.order_id = o.order_id
WHERE oi.total_price > (SELECT AVG(total_price) from order_items)

SELECT p.product_id, 
p.product_name from products p
where p.product_id IN (select oi.product_id from order_items oi 
group by oi.product_id
having count(oi.product_id) > 1);

SELECT p.product_name from products p
where p.product_id IN(select oi.product_id from order_items oi
join orders o on o.order_id = oi.order_id
join customers c on c.customer_id = o.customer_id
where c.city = 'Pune');


SELECT customer_name from customers 
where customer_id IN(select o.customer_id from orders o
join order_items oi on oi.order_id = o.order_id
join products p on p.product_id = oi.product_id
where p.price > 30000);




