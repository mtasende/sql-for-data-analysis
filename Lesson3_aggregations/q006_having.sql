select account_id,
       sum(total_amt_usd) as sum_total_amt_usd
  from demo.orders
group by 1
having sum(total_amt_usd) >= 250000


    How many of the sales reps have more than 5 accounts that they manage?

select count(*) from
  (select sr.name,
          count(*) as num_accounts
     from sales_reps as sr
     join accounts as a on a.sales_rep_id = sr.id
   group by sr.name
   having count(*) > 5) as more_than_five


    How many accounts have more than 20 orders?

select count(*) from
  (
    select a.name as account,
           count(*) as num_orders
      from accounts as a
      join orders as o on o.account_id = a.id
    group by account
    having count(*) > 20
  ) as more_than_twenty


    Which account has the most orders?
select a.name as account,
       count(*) as num_orders
  from accounts as a
  join orders as o on o.account_id = a.id
group by account
order by num_orders desc
limit 1


    How many accounts spent more than 30,000 usd total across all orders?

select count(*) from
  (
    select a.name as account,
           sum(o.total_amt_usd) as total_spent
      from accounts as a
      join orders as o on o.account_id = a.id
    group by account
    having sum(o.total_amt_usd) > 30000
  ) as big_accounts


    How many accounts spent less than 1,000 usd total across all orders?

select count(*) from
  (
    select a.name as account,
           sum(o.total_amt_usd) as total_spent
      from accounts as a
      join orders as o on o.account_id = a.id
    group by account
    having sum(o.total_amt_usd) < 1000
  ) as small_accounts


    Which account has spent the most with us?

select a.name as account,
       sum(o.total_amt_usd) as total_spent
  from accounts as a
  join orders as o on o.account_id = a.id
group by account
order by total_spent desc
limit 1


    Which account has spent the least with us?

select a.name as account,
       sum(o.total_amt_usd) as total_spent
  from accounts as a
  join orders as o on o.account_id = a.id
group by account
order by total_spent
limit 1


    Which accounts used facebook as a channel to contact customers more than 6 times?

select a.name as account,
       count(*) as num_contacts
  from accounts as a
  join web_events as w on w.account_id = a.id
where w.channel = 'facebook'
group by account
having count(*) > 6
order by num_contacts desc


    Which account used facebook most as a channel?

select a.name as account,
       count(*) as num_uses
  from accounts as a
  join web_events as w on w.account_id = a.id
where w.channel = 'facebook'
group by account
order by num_uses desc
limit 1


Which channel was most frequently used by most accounts?

select channel, count(*) as max_uses from (
  select account,
         channel,
         max(num_uses) as largest_num
    from (
      select a.name as account,
             w.channel as channel,
             count(*) as num_uses
        from accounts as a
        join web_events as w on w.account_id = a.id
      group by account, channel
      order by account, num_uses desc
    ) as uses_table
  group by account, channel
) as max_channels
group by channel
order by max_uses desc
limit 1
