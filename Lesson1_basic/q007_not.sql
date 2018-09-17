SELECT sales_rep_id,
       name
  FROM demo.accounts
WHERE sales_rep_id NOT IN(321500,321570)
ORDER BY sales_rep_id


SELECT *
  FROM demo.web_events_full
WHERE referrer_url NOT LIKE '%google%'



    Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.




    Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.

Use the accounts table to find:

    All the companies whose names do not start with 'C'.

    All companies whose names do not contain the string 'one' somewhere in the name.

    All companies whose names do not end with 's'.
