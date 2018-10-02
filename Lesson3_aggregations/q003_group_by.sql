select account_id,
       sum(standard_qty) as standard_sum,
       sum(gloss_qty) as gloss_sum,
       sum(poster_qty) as poster_sum
  from demo.orders
group by account_id
order by account_id


One part that can be difficult to recognize is when it might be easiest to use an aggregate or one of the other SQL functionalities. Try some of the below to see if you can differentiate to find the easiest solution.

    Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

select a.name,
       o.occurred_at
  from orders as o
  join accounts as a on o.account_id = a.id
order by o.occurred_at
limit 1


    Find the total sales in usd for each account. You should include two columns - the total sales for each company''s orders in usd and the company name.

select sum(o.total_amt_usd) as total_sales,
       a.name
  from orders as o
  join accounts as a on o.account_id = a.id
group by a.name
order by total_sales desc


    Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

select w.occurred_at,
       w.channel,
       a.name
  from web_events as w
  join accounts as a on w.account_id = a.id
order by w.occurred_at
limit 1


    Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

select channel, count(*)
  from web_events
group by channel


    Who was the primary contact associated with the earliest web_event?

select a.primary_poc, w.occurred_at
  from web_events as w
  join accounts as a on w.account_id = a.id
order by w.occurred_at
limit 1


    What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

select a.name as account,
       min(o.total_amt_usd) as smallest_usd
  from orders as o
  join accounts as a on o.account_id = a.id
group by account
order by smallest_usd


    Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

select r.name as region,
       count(*) as number_of_sales_reps
  from sales_reps as sr
  join region as r on sr.region_id = r.id
group by region
order by number_of_sales_reps
