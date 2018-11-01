select id,
       account_id,
       standard_qty,
       date_trunc('month', occurred_at) as month,
       dense_rank() over main_window as dense_rank,
       sum(standard_qty) over main_window as sum_standard_qty,
       count(standard_qty) over main_window as count_standard_qty,
       avg(standard_qty) over main_window as avg_standard_qty,
       min(standard_qty) over main_window as min_standard_qty,
       max(standard_qty) over main_window as max_standard_qty
  from demo.orders
window main_window as (partition by account_id order by date_trunc('month', occurred_at))


Now, create and use an alias to shorten the following query (which is different than the one in Derek''s previous video) that has multiple window functions. Name the alias account_year_window, which is more descriptive than main_window in the example above.

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
window account_year_window as (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))
