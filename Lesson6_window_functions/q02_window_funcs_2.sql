select id,
       account_id,
       occurred_at,
       row_number() over (order by id) as row_num
  from demo.orders


select id,
       account_id,
       occurred_at,
       row_number() over (order by occurred_at) as row_num
  from demo.orders


select id,
       account_id,
       date_trunc('month', occurred_at) as month,
       rank() over (partition by account_id order by ate_trunc('month', occurred_at)) as row_num
  from demo.orders


select id,
       account_id,
       date_trunc('month', occurred_at) as month,
       dense_rank() over (partition by account_id order by ate_trunc('month', occurred_at)) as row_num
  from demo.orders


Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition. Your final table should have these four columns.

select id,
       account_id,
       total,
       rank() over (partition by account_id order by total desc) as total_rank
  from orders
