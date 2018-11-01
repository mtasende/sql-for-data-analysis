select id,
       account_id,
       standard_qty,
       date_trunc('month', occurred_at) as month,
       dense_rank() over (partition by account_id
                          order by date_trunc('month', occurred_at)) as dense_rank,
       sum(standard_qty) over (partition by account_id
                               order by date_trunc('month', occurred_at)) as sum_standard_qty,
       count(standard_qty) over (partition by account_id
                               order by date_trunc('month', occurred_at)) as count_standard_qty,
       avg(standard_qty) over (partition by account_id
                               order by date_trunc('month', occurred_at)) as avg_standard_qty,
       min(standard_qty) over (partition by account_id
                               order by date_trunc('month', occurred_at)) as min_standard_qty,
       max(standard_qty) over (partition by account_id
                               order by date_trunc('month', occurred_at)) as max_standard_qty
  from demo.orders


Now remove ORDER BY DATE_TRUNC('month',occurred_at) in each line of the query that contains it in the SQL Explorer below. Evaluate your new query, compare it to the results in the SQL Explorer above, and answer the subsequent quiz questions.

select id,
       account_id,
       standard_qty,
       date_trunc('month', occurred_at) as month,
       dense_rank() over (partition by account_id) as dense_rank,
       sum(standard_qty) over (partition by account_id) as sum_standard_qty,
       count(standard_qty) over (partition by account_id) as count_standard_qty,
       avg(standard_qty) over (partition by account_id) as avg_standard_qty,
       min(standard_qty) over (partition by account_id) as min_standard_qty,
       max(standard_qty) over (partition by account_id) as max_standard_qty
  from orders
