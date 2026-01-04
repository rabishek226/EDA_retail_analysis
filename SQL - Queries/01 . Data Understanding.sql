
-- Total Number of Orders
select count(*) as Total_Orders
from sales;

-- Unique customers and products
select 
count(distinct customer_id) as Unique_customers,
count(distinct product_id) as Unique_products
from sales;

-- date Range in the dataset
select 
min(order_date) as first_date, 
max(order_date) as last_date
from sales;