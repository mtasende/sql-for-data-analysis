select standard_qty,
       sum(standard_qty) over (order by occurred_at) as running_total
  from demo.orders


select standard_qty,
       date_trunc('month', occurred_at) as month,
       sum(standard_qty) over (partition by date_trunc('month', occurred_at)
                               order by occurred_at) as running_total
  from demo.orders


select standard_qty,
       date_trunc('month', occurred_at) as month,
       sum(standard_qty) over (partition by date_trunc('month', occurred_at)) as running_total
  from demo.orders


Using Derek''s previous video as an example, create another running total. This time, create a running total of standard_amt_usd (in the orders table) over order time with no date truncation. Your final table should have two columns: one with the amount being added for each new row, and a second with the running total.

select standard_amt_usd,
       sum(standard_amt_usd) over (order by occurred_at) as running_total
  from orders


Now, modify your query from the previous quiz to include partitions. Still create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable. Your final table should have three columns: One with the amount being added for each row, one for the truncated date, and a final column with the running total within each year.

select standard_amt_usd,
       date_trunc('year', occurred_at) as year,
       sum(standard_amt_usd) over (partition by date_trunc('year', occurred_at)
                                   order by occurred_at) as running_yearly_total
  from orders
