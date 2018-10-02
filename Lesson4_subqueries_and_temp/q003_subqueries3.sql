select t3.id, t3.name, t3.channel, t3.ct
  from (select a.id, a.name, we.channel, count(*) as ct
          from accounts a
          join web_events as we on a.id = we.account_id
        group by a.id, a.name, we.channel) as t3
  join (select t1.id, t1.name, we.channel, count(*) as ct
          from (select a.id, a.name, we.channel, count(*) as ct
                  from accounts a
                  join web_events as we
                  on a.id = we.account_id
                group by a.id, a.name, we.channel) as t1
        group by t1.id, t1.name) as t2
  on t2.id = t3.id and t.max_chan = t3.ct
order by t3.id, t3.ct;


    Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

select rn_total1.*
  from
    (select r.name as region,
           sr.name,
           sum(o.total_amt_usd) as total_spent
      from sales_reps as sr
      join region as r on sr.region_id = r.id
      join accounts as a on a.sales_rep_id = sr.id
      join orders as o on o.account_id = a.id
    group by 1, 2) as rn_total1
  join
    (select region,
           max(total_spent) as max_spent
      from
        (select r.name as region,
               sr.name,
               sum(o.total_amt_usd) as total_spent
          from sales_reps as sr
          join region as r on sr.region_id = r.id
          join accounts as a on a.sales_rep_id = sr.id
          join orders as o on o.account_id = a.id
        group by 1, 2) as rn_total2
    group by region) as r_max
  on rn_total1.total_spent = r_max.max_spent and rn_total1.region = r_max.region


    For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed

select r.name as region,
       sum(o.total_amt_usd) as total_orders_usd,
       count(*) as count_orders
  from region as r
  join sales_reps as sr on sr.region_id = r.id
  join accounts as a on a.sales_rep_id = sr.id
  join orders as o on o.account_id = a.id
  group by region
  having sum(o.total_amt_usd) =
    (select sum(o.total_amt_usd) as total_orders_usd
      from region as r
      join sales_reps as sr on sr.region_id = r.id
      join accounts as a on a.sales_rep_id = sr.id
      join orders as o on o.account_id = a.id
    group by r.name
    order by total_orders_usd desc
    limit 1)


    For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?

select count(*) as accounts_count
  from accounts as a
  join orders as o on o.account_id = a.id
group by a.id
having sum(o.total) >
  (select max_std.total_purchases
    from
      (select a.name as account,
             sum(o.total) as total_purchases,
             sum(o.standard_qty) as total_std
        from accounts as a
        join orders as o on o.account_id = a.id
      group by a.name
      order by 2 desc
      limit 1) as max_std)


    For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

select w.channel,
       count(*) as num_events
  from web_events as w
  join accounts as a on w.account_id = a.id
  where a.id =
    (select id
      from
        (select a.id,
               sum(o.total_amt_usd) as total_spent
          from accounts as a
          join orders as o on o.account_id = a.id
        group by 1
        order by 2 desc
        limit 1) as max_spender
    )
group by w.channel


    What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

select avg(total_spending) as tot_usd
  from
    (select a.id,
           sum(o.total_amt_usd) as total_spending
      from accounts as a
      join orders as o on o.account_id = a.id
    group by 1
    order by 2 desc
    limit 10) as top_accounts


    What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all orders.

select avg(total_spent) avg_total_spent
  from
    (select sum(o.total_amt_usd) as total_spent
      from accounts as a
      join orders as o on o.account_id = a.id
    group by a.id
    having sum(o.total_amt_usd) >
      (select avg(total_amt_usd) as mean
        from orders)) as account_spent
