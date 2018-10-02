select id,
       account_id,
       occurred_at,
       channel,
       case when channel = 'facebook' or channel = 'direct' then 'yes' else 'no' end as is_facebook
  from demo.web_events_full
order by occurred_at

select account_id,
       occurred_at,
       total
       case when total > 500 then 'Over 500'
            when total > 300 and total <= 500 then '301 - 500'
            when total > 100 and total <= 300 then '101 - 300'
            else '100 or under' end as total_group
  from demo.orders

select case when total > 500 then 'Over 500'
            else '500 or under' end as total_group
       count(*) as order_count
  from demo.orders
group by 1

select count(1) as orders_over_500_units
  from demo.orders
where total > 500


    We would like to understand 3 different levels of customers based on the amount associated with their purchases. The top branch includes anyone with a Lifetime Value (total sales of all orders) greater than 200,000 usd. The second branch is between 200,000 and 100,000 usd. The lowest branch is anyone under 100,000 usd. Provide a table that includes the level associated with each account. You should provide the account name, the total sales of all orders for the customer, and the level. Order with the top spending customers listed first.

select a.name as account,
       sum(o.total_amt_usd) as lifetime_value,
       case when sum(o.total_amt_usd) > 200000 then 'top'
            when sum(o.total_amt_usd) <= 200000 and sum(o.total_amt_usd) >= 100000 then 'medium'
            else 'low' end as level
from orders as o
join accounts as a on o.account_id = a.id
group by 1
order by 2 desc


    We would now like to perform a similar calculation to the first, but we want to obtain the total amount spent by customers only in 2016 and 2017. Keep the same levels as in the previous question. Order with the top spending customers listed first.

select a.name as account,
       sum(o.total_amt_usd) as lifetime_value,
       case when sum(o.total_amt_usd) > 200000 then 'top'
            when sum(o.total_amt_usd) <= 200000 and sum(o.total_amt_usd) >= 100000 then 'medium'
            else 'low' end as level
from orders as o
join accounts as a on o.account_id = a.id
where o.occurred_at between '2016-01-01' and '2018-01-01'
group by 1
order by 2 desc


    We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders. Create a table with the sales rep name, the total number of orders, and a column with top or not depending on if they have more than 200 orders. Place the top sales people first in your final table.

select sr.name as sales_rep,
       count(*) as num_orders,
       case when count(*) > 200 then 'top' end as is_top
  from orders as o
  join accounts as a on o.account_id = a.id
  join sales_reps as sr on a.sales_rep_id = sr.id
group by sales_rep
order by 3


    The previous didn''t account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!

select sr.name as sales_rep,
       count(*) as num_orders,
       sum(total_amt_usd) as total_usd,
       case when count(*) > 200 or sum(total_amt_usd) > 750000 then 'top'
            when (count(*) > 150 and count(*) <= 200) or
            (sum(total_amt_usd) > 500000 and sum(total_amt_usd) <= 750000)
            then 'middle'
            else 'low' end as level
  from orders as o
  join accounts as a on o.account_id = a.id
  join sales_reps as sr on a.sales_rep_id = sr.id
group by sales_rep
order by level desc, total_usd desc
