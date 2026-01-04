
-- Underperforming region by revenue

select 
region,
sum(quantity * unit_price) as Total_Revenue
from sales
group by region
order by total_revenue
limit 1;

-- Which region has the highest sales

select
region,
sum(quantity * unit_price) as Total_Revenue
from sales
group by region
order by total_revenue desc
limit 1;
