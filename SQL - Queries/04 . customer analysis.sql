
-- Top 5 customers 
select 
customer_id,
sum(quantity * unit_price) as Total_revenue
from sales
group by customer_id
order by total_revenue desc
limit 5;

-- ranking customers by total_spent
select 
customer_id,
total_spent,
dense_rank()over(order by total_spent desc) as customer_rank
from (
	select 
	customer_id,
	sum(quantity * unit_price) as total_spent 
	from sales
	group by customer_id
)t