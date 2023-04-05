use sales;
select * from customers;

-- Which month had maximum sales in each year
with max_sales as (select d.year,d.month_name,sum(sales_amount) as Total_revenue 
from transactions t join date d on d.cy_date=t.order_date group by d.year,d.month_name)

select * from (select *,rank() over (partition by year  order by Total_revenue desc) as Ranking from
max_sales)tp where tp.Ranking=1;




-- What are the Total Sales across each year


SELECT 
    d.year, SUM(t.sales_amount) AS Total_sales_per_year
FROM
    transactions t
        JOIN
    date d ON d.date = t.order_date

GROUP BY d.year;


-- What are the profit margin in each year for diffrent market zones

SELECT 
    m.zone,d.year,concat("Rs ",round(AVG(t.profit_margin),2)) AS profit_margin,rank() over (partition by year order by profit_margin desc) as ranking
FROM
    markets m
        RIGHT JOIN
    transactions t ON t.market_code = m.markets_code
    left join date d on d.date=t.order_date
GROUP BY m.zone,d.year;


-- Which customer brings highest sales to the bussiness within each market(city)

SELECT 
    m.markets_name,cc.custmer_name, max(t.sales_amount) as Max_sales
FROM
    customers cc
        JOIN
    transactions t ON t.customer_code = cc.customer_code
    inner join markets m on m.markets_code= t.market_code
    group by m.markets_name order by m.markets_name;
    

-- Which zone has maximum profit margin percentage in market based on first three top market names.

use sales;
with pr_rank as (select zone,markets_name,concat(t.profit_margin_percentage*100,"%")  as profit_margin_percentage ,
rank() over (partition by zone order by profit_margin_percentage desc) as rank_profit from markets m 
join transactions t on t.market_code=m.markets_code group by markets_name)
Select * from pr_rank where rank_profit in (1,2,3);


-- Which stores has brought the more than 50% revenue withn each financial year

with max_avg_revenue as (select c.custmer_name, round(avg(t.sales_amount),2) as Avg_revenue,year(t.order_date) as Year
from transactions t join customers c on t.customer_code= c.customer_code group by c.custmer_name)
select * from 
(select *,concat(round(percent_rank() over (partition by Year 
order by Avg_revenue )*100,2),"%")  as Percentile_rank  from max_avg_revenue) mar
where mar.Percentile_rank>50;


-- Least profitable products

with avg_margin_per as
(SELECT 
    p.product_code, concat(round(AVG(t.profit_margin_percentage)*100,2),"%") as Avg_profit_margin_percentage
FROM
    products p
        JOIN
    transactions t ON t.product_code = p.product_code
GROUP BY p.product_code),
ranking_per_avg_revenue as (select *,rank() over (order by Avg_profit_margin_percentage desc) as Ranking from avg_margin_per)

select *,(case when Ranking > 3 then "Least Profitable Products" else "Most Profitable Products" end) as Result from (select * from ranking_per_avg_revenue
where Ranking<4
union
select * from ranking_per_avg_revenue
where Ranking in (select * from (select distinct Ranking from ranking_per_avg_revenue order by Ranking desc limit 3)asp))final
 ;
 
 
 -- In which market , which are the products that brings maximum profit
 
 
 with profit_margin_product as (SELECT 
   t.market_code,p.product_code, round(avg(t.profit_margin),2) as Avg_profit_margin
FROM
    transactions t
       inner
       JOIN
    products p ON p.product_code = t.product_code group by t.product_code)
   

select m.markets_name,pmp.* from (select *, rank() over (partition by market_code order by Avg_profit_margin desc) as Ranking_products_per_market_name 
from profit_margin_product)pmp 
join markets m on m.markets_code=pmp.market_code
where pmp.Ranking_products_per_market_name=1;
    
-- Which zone has highest profit percentage

select s.zone,concat(round(max(avg_profit_percentage)*100,2),"%") as Max_avg_profit_percentage,round(max(avg_profit_margin)*100,2)
as Max_avg_profit_margin, max(Avg_sales) as Max_avg_sales from 
(select m.zone ,avg(t.profit_margin_percentage) as avg_profit_percentage ,avg(t.profit_margin) as avg_profit_margin,avg(t.sales_amount) as Avg_sales   from transactions t join markets m on m.markets_code=t.market_code group by m.zone)s
group by s.zone;

/*
Insight:
So maximum avg_profit percentage is coming from "Central" zone with 2.5% but north zone gas maximum profit margin.
*/


