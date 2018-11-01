select *,
  coalesce(primary_poc, 'no POC') as primary_poc_modified
  from demo.accounts
where primary_poc is null


select count(primary_poc) as regular_count,
  count(coalesce(primary_poc, 'no POC')) as modified_count
  from demo.accounts


  SELECT *
  FROM accounts a
  LEFT JOIN orders o
  ON a.id = o.account_id
  WHERE o.total IS NULL;


Use coalesce to fill in the accounts.id column with the account.id for the null
value for the table in 1

select *,
       coalesce(a.id, o.account_id) as id
  from accounts as a
  left join orders as o on o.account_id = a.id
where o.total is null
limit 10


Use coalesce to fill in the orders.account_id column with the account.id for the null
value for the table in 1

select *,
       coalesce(a.id, o.account_id) as account_id
  from accounts as a
  left join orders as o on o.account_id = a.id
where o.total is null
limit 10


Use coalesce to fill in each of the qty and usd columns with 0 for the table
in 1

select *,
       coalesce(o.standard_qty, 0) as standard_qty,
       coalesce(o.gloss_qty, 0) as gloss_qty,
       coalesce(o.poster_qty, 0) as poster_qty,
       coalesce(o.total, 0) as total,
       coalesce(o.standard_amt_usd, 0) as standard_amt_usd,
       coalesce(o.gloss_amt_usd, 0) as gloss_amt_usd,
       coalesce(o.poster_amt_usd, 0) as poster_amt_usd,
       coalesce(o.total_amt_usd, 0) as total_amt_usd
  from accounts as a
  left join orders as o on o.account_id = a.id
where o.total is null
limit 10


Run the query in 1 with the where removed and count the nomber of ids

SELECT count(a.id)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id

---> 6913

Run the query in 5, but with the coalesce frunction used in questions 2
through 4.

select count(*) from
  (select coalesce(a.id, o.account_id) as id,
       coalesce(o.account_id, a.id) as account_id,
       coalesce(o.standard_qty, 0) as standard_qty,
       coalesce(o.gloss_qty, 0) as gloss_qty,
       coalesce(o.poster_qty, 0) as poster_qty,
       coalesce(o.total, 0) as total,
       coalesce(o.standard_amt_usd, 0) as standard_amt_usd,
       coalesce(o.gloss_amt_usd, 0) as gloss_amt_usd,
       coalesce(o.poster_amt_usd, 0) as poster_amt_usd,
       coalesce(o.total_amt_usd, 0) as total_amt_usd
    from accounts as a
  left join orders as o on o.account_id = a.id) as filled_table
