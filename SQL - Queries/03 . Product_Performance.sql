
-- Top 5 products by revenue and Percentage Contribution
with product_by_revenue as (
	select 
	product_id,
	product_name,
	sum(quantity * unit_price) as Total_revenue
	from sales
	group by product_name , product_id
) , product_rank as (
	select 
	product_id,
	product_name,
	total_revenue,
	dense_rank()over(order by total_revenue desc) as product_rank
	from product_by_revenue
) , company_overall_revenue as (
	select 
	sum(total_revenue) as overall_revenue
	from product_by_revenue
)

select 
p.product_id,
p.product_name,
p.total_revenue,
p.product_rank,
round(p.total_revenue / c.overall_revenue * 100 , 2) as Contribution
from product_rank p
cross join company_overall_revenue c
where p.product_rank <= 5;

-- Which Product Generates highest revenue
select 
product_name,
sum(quantity * unit_price) as Total_sales
from sales
group by product_name
order by total_sales desc
limit 1;

-- What Percentage of revenue comes from top 3 products
with product_revenue as (
	select 
	product_name,
	sum(quantity * unit_price) as Total_revenue
	from sales
	group by product_name
) , ranked_product as (
	select 
	total_revenue,
	dense_rank()over(order by total_revenue desc) as Product_rank
	from product_revenue
) , product_overall_revenue as (
	select 
	sum(total_revenue) as product_total
	from ranked_product
	where product_rank <= 3
) , company_revenue as (
	select 
	sum(quantity * unit_price) as Overall_revenue
	from sales
)

select 
round(p.product_total / c.overall_revenue * 100 ,2) as top_3_product_percentage
from product_overall_revenue p 
cross join company_revenue c;

-- Highest Revenue by Category
select 
product_category,
sum(quantity * unit_price) as Total_Revenue
from sales
group by product_category
order by total_revenue desc
limit 1;