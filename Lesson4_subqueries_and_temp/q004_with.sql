Common Table Expressions

with events as (select date_trunc('day', occurred_at) as day,
                       channel,
                       count(*) as event_count
                  from demo.web_events_full
                group by 1, 2
)


select channel,
       avg(event_count) as avg_event_count
  from events
group by 1
order by 2 desc


QUESTION: You need to find the average number of events for each channel per day.

with ch_d_counter as (select channel,
                              date_trunc('day', occurred_at) as day,
                              count(*) as num_events
                        from web_events
                      group by channel, day)

select channel,
       avg(num_events) as avg_num_events
  from ch_d_counter
group by channel
order by 2 desc


    Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

with r_sr_spent as (select r.name as region,
                           sr.name as sales_rep,
                           sum(o.total_amt_usd) as total_spent
                      from orders as o
                      join accounts as a on o.account_id = a.id
                      join sales_reps as sr on a.sales_rep_id = sr.id
                      join region as r on sr.region_id = r.id
                    group by region, sales_rep),

    r_max_spent as (select region,
                            max(total_spent) as max_spent
                       from r_sr_spent
                     group by region)

select rsr.*
  from r_sr_spent as rsr
  join r_max_spent as rmax on rsr.total_spent = rmax.max_spent


    For the region with the largest sales total_amt_usd, how many total orders were placed?

with region_data as (select r.id,
                            count(*) as num_orders,
                            sum(o.total_amt_usd) as total_usd
                       from orders as o
                       join accounts as a on o.account_id = a.id
                       join sales_reps as sr on a.sales_rep_id = sr.id
                       join region as r on sr.region_id = r.id
                     group by r.id)

select num_orders
  from region_data
order by total_usd desc
limit 1


    For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?

with account_sales as (select a.name as account,
                              sum(o.standard_qty) as std_total,
                              sum(o.total) as tot_total
                         from orders as o
                         join accounts as a on o.account_id = a.id
                       group by account)

select count(*) as num_bigger_tot
  from account_sales
where tot_total >
  (select tot_total
    from account_sales
   order by std_total desc
   limit 1)


    For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?

with events as (select a.id,
                       w.channel,
                       count(*) as num_events
                  from web_events as w
                  join accounts as a on w.account_id = a.id
                group by a.id, w.channel),

     max_spender as (select a.id,
                            sum(o.total_amt_usd) as total_spent
                       from orders as o
                       join accounts as a on o.account_id = a.id
                     group by a.id
                     order by 2 desc
                     limit 1)

select e.channel,
       e.num_events
  from events as e
  join max_spender as ms on e.id = ms.id
order by 2 desc


    What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

with top_spenders as (select a.name,
                             sum(o.total_amt_usd) as spent_usd
                        from orders as o
                        join accounts as a on o.account_id = a.id
                      group by a.name
                      order by 2 desc
                      limit 10)

select avg(spent_usd) as avg_spent_top10
  from top_spenders


    What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all accounts.

with spending as (select a.name,
                         sum(o.total_amt_usd) as spent_usd
                    from orders as o
                    join accounts as a on o.account_id = a.id
                  group by a.name),

     big_spenders as (select *
                        from spending
                      where spent_usd >
                        (select avg(spent_usd)
                           from spending)
                     )

select avg(spent_usd)
  from big_spenders
