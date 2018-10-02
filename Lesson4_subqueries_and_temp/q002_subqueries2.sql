select *
  from demo.orders
  where date_trunc('month', occurred_at) =
    (select date_trunc('month', min(occurred_at)) as min_month
       from demo.orders)
order by occurred_at;


  Use date_trunc to pull month level information about the first order ever
  placed in the orders table.
  Use the previous query to find only the orders that took place in the same
  month and year as the first order, and then pull the average for each type of
  paper qty in this month, and the total amount spent.

select avg(standard_qty) as  std_avg,
       avg(poster_qty) as poster_avg,
       avg(gloss_qty) as gloss_avg,
       sum(total_amt_usd) as total_spent
  from orders
where date_trunc('month', occurred_at) =
  (select date_trunc('month', min(occurred_at)) as min_month
     from orders)
