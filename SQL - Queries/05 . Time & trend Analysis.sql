
-- Monthly revenue trend overtime
with monthly_sales as (
	select 
	extract(month from order_date) as month, 
	sum(quantity * unit_price) as Total_revenue
	from sales
	group by extract(month from order_date)
) , previous_month as (
	select 
	month,
	total_revenue,
	lag(total_revenue)over(order by month) as previous_month_revenue
	from monthly_sales
)

select 
month,
total_revenue,
case when total_revenue > previous_month_revenue then 'Incline'
	 when previous_month_revenue is null then 'Sales Started'
	 else 'Decline'
end as Trend
from previous_month;

-- Which month records highest sales
select 
date_trunc('month',order_date) as Month,
sum(quantity * unit_price) as Total_revenue
from sales
group by date_trunc('month',order_date)
order by total_revenue desc
limit 1;