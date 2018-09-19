select o.*,
       a.*
  from demo.orders as o
  join demo.accounts as a
    on o.account_id = a.id


    Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

select a.primary_poc,
       w.occurred_at as event_time,
       w.channel,
       a.name
  from web_events as w
  join accounts as a
    on w.account_id = a.id
  where a.name = 'Walmart'

    Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

select r.name,
       sr.name,
       a.name
  from accounts as a
  join sales_reps as sr on a.sales_rep_id = sr.id
  join region as r on sr.region_id = r.id
order by a.name

    Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

select r.name as region_name,
       a.name as account_name,
       o.total_amt_usd / (o.total + 0.01) as unit_price
  from orders as o
  join accounts as a on o.account_id = a.id
  join sales_reps as sr on a.sales_rep_id = sr.id
  join region as r on sr.region_id = r.id
