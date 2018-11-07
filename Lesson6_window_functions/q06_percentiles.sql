select id,
       account_id,
       occurred_at,
       standard_qty,
       ntile(4) over (order by standard_qty) as quartile,
       ntile(5) over (order by standard_qty) as quintile,
       ntile(100) over (order by standard_qty) as percentile
  from demo.orders
order by standard_qty desc


You can use partitions with percentiles to determine the percentile of a specific subset of all rows. Imagine you''re an analyst at Parch & Posey and you want to determine the largest orders (in terms of quantity) a specific customer has made to encourage them to order more similarly sized large orders. You only want to consider the NTILE for that customer''s account_id.

In the SQL Explorer below, write three queries (separately) that reflect each of the following:

    Use the NTILE functionality to divide the accounts into 4 levels in terms of the amount of standard_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of standard_qty paper purchased, and one of four levels in a standard_quartile column.

select account_id,
       occurred_at,
       standard_qty,
       ntile(4) over (partition by account_id order by standard_qty) as standard_quartile
  from orders


    Use the NTILE functionality to divide the accounts into two levels in terms of the amount of gloss_qty for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of gloss_qty paper purchased, and one of two levels in a gloss_half column.

select account_id,
       occurred_at,
       gloss_qty,
       ntile(2) over (partition by account_id order by gloss_qty) as gloss_half
  from orders


    Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column.

select account_id,
       occurred_at,
       total_amt_usd,
       ntile(100) over (partition by account_id order by total_amt_usd) as total_percentile
  from orders
order by account_id


Note: To make it easier to interpret the results, order by the account_id in each of the queries.
