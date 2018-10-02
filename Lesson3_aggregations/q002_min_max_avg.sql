select min(standard_qty) as standard_min,
       min(gloss_qty) as gloss_min,
       min(poster_qty) as poster_min,
       max(standard_qty) as standard_max,
       max(gloss_qty) as gloss_max,
       max(poster_qty) as poster_max
  from demo.orders

select avg(standard_qty) as standard_avg,
       avg(gloss_qty) as gloss_avg,
       avg(poster_qty) as poster_avg
  from demo.orders



      When was the earliest order ever placed? You only need to return the date.

select min(occurred_at) as earliest_date
  from orders


      Try performing the same query as in question 1 without using an aggregation function.

select occurred_at
  from orders
order by occurred_at
limit 1


      When did the most recent (latest) web_event occur?

select max(occurred_at) as latest
  from web_events


      Try to perform the result of the previous query without using an aggregation function.

select occurred_at
  from orders
order by occurred_at desc
limit 1


      Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.

select avg(standard_amt_usd) as mean_usd_std,
       avg(poster_amt_usd) as mean_usd_poster,
       avg(gloss_amt_usd) as mean_usd_gloss,
       avg(standard_qty) as mean_qty_std,
       avg(poster_qty) as mean_qty_poster,
       avg(gloss_qty) as mean_qty_gloss
  from orders


      Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?

I found a biased median, for now...

select total_amt_usd as median
  from (select row_number() over(order by total_amt_usd) as row,
               total_amt_usd
          from orders) as ordered_usd
where row = (select count(total_amt_usd)
               from orders) / 2


select avg(d) as median
  from (select total_amt_usd
          from (select row_number() over(order by total_amt_usd) as row,
                       total_amt_usd
                  from orders) as ordered_usd
        where row = (select count(total_amt_usd)
                       from orders) / 2
           or row = ((select count(total_amt_usd)
                        from orders) / 2) + 1) as middle_rows
