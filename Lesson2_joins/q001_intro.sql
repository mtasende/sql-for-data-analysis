select orders.*,
       accounts.*
  from demo.orders
  join demo.accounts
    on orders.account_id = accounts.id


select orders.*
  from orders
  join accounts
    on orders.account_id = accounts.id;



  Try pulling all the data from the accounts table, and all the data from the orders table.

select accounts.*, orders.*
  from accounts
  join orders
    on orders.account_id = accounts.id


  Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.

select orders.standard_qty,
       orders.gloss_qty,
       orders.poster_qty,
       accounts.website,
       accounts.primary_poc
  from orders
  join accounts
    on orders.account_id = accounts.id
