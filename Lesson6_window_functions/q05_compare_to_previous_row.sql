select account_id,
       standard_sum,
       lag(standard_sum) over (order by standard_sum) as lag,
       lead(standard_sum) over (order by standard_sum) as lead,
       standard_sum - lag(standard_sum) over (order by standard_sum) as lag_difference,
       lead(standard_sum) over (order by standard_sum) - standard_sum as lead_difference,
  from (
    select account_id,
           sum(standard_qty) as standard_sum
      from demo.orders
    group by 1
  ) as sub


  In the previous video, Derek outlines how to compare a row to a previous or subsequent row. This technique can be useful when analyzing time-based events. Imagine you''re an analyst at Parch & Posey and you want to determine how the current order''s total revenue ("total" meaning from sales of all types of paper) compares to the next order''s total revenue.

  Modify Derek''s query from the previous video in the SQL Explorer below to perform this analysis. You''ll need to use occurred_at and total_amt_usd in the orders table along with LEAD to do so. In your query results, there should be four columns: occurred_at, total_amt_usd, lead, and lead_difference.

select occurred_at,
       total_amt_usd,
       lead(total_amt_usd) over (order by occurred_at) as lead,
       lead(total_amt_usd) over (order by occurred_at) - total_amt_usd as lead_difference
  from (
    select occurred_at,
           sum(total_amt_usd) as total_amt_usd
      from orders
    group by occurred_at
  ) as sub
