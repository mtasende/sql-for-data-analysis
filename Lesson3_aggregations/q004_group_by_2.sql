select account_id,
       channel,
       count(id) as events
  from demo.web_events_full
group by account_id, channel
order by account_id, channel desc


For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

select a.name as account,
       avg(o.standard_qty) as avg_std,
       avg(o.poster_qty) as avg_poster,
       avg(o.gloss_qty) as avg_glossy
  from orders as o
  join accounts as a on o.account_id = a.id
group by account


For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

select a.name as account,
       avg(o.standard_amt_usd) as avg_std,
       avg(o.poster_amt_usd) as avg_poster,
       avg(o.gloss_qty) as avg_glossy
 from orders as o
 join accounts as a on o.account_id = a.id
 group by account


Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

select sr.name as sales_rep,
       w.channel as channel,
       count(w.*) as number_of_times
  from web_events as w
  join accounts as a on w.account_id = a.id
  join sales_reps as sr on a.sales_rep_id = sr.id
group by sales_rep, channel
order by number_of_times desc


Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

select r.name as region,
       w.channel as channel,
       count(w.*) as occurrences
  from web_events as w
  join accounts as a on w.account_id = a.id
  join sales_reps as sr on a.sales_rep_id = sr.id
  join region as r on sr.region_id = r.id
group by region, channel
order by occurrences desc
