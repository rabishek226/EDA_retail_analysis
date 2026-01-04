
-- Total Revenue Generated
select 
sum(quantity * unit_price) as Total_Revenue
from sales;

-- Average Order Value
select 
sum(quantity * unit_price) / count(distinct order_id) as Average_Order_Value
from sales;

-- Which Sales channel contribute more 
with total_by_channel as (
	select 
	sales_channel,
	sum(quantity * unit_price) as Total_Revenue
	from sales
	group by sales_channel
) , company_revenue as (
	select 
	sum(total_revenue) as Overall_revenue
	from total_by_channel
)
select 
t.sales_channel,
t.total_revenue,
round(t.total_revenue/c.overall_revenue * 100,2) as Sales_Contribution
from total_by_channel t
cross join company_revenue c
order by t.total_revenue desc , sales_contribution desc;