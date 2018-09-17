SELECT *
  FROM demo.accounts
WHERE  name IN ('Walmart', 'Apple')


SELECT *
  FROM demo.orders
WHERE  account_id IN (1001, 1021)


Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.

SELECT name, primary_poc, sales_rep_id
  FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')


Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords

SELECT *
  FROM web_events
WHERE channel IN ('organic', 'adwords')
