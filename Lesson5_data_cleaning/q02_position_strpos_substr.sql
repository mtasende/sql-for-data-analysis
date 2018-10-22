select first_name,
       last_name,
       city_state,
       position(',', in city_state) as comma_position,
       strpos(city_state, ',') as substr_comma_position
       lower(city_state) as lowercase,
       upper(city_state) as uppercase,
       left(city_state, position(',' in city_state) - 1) as city
from demo.customer_data




    Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.

select primary_poc as name,
       left(primary_poc, position(' ' in primary_poc) - 1) as first_name,
       right(primary_poc, length(primary_poc) - position(' ' in primary_poc)) as last_name
  from accounts


    Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.

select name,
       left(name, position(' ' in name) - 1) as first_name,
       right(name, length(name) - position(' ' in name)) as last_name
  from sales_reps
