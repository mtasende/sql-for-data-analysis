select first_name,
       last_name,
       concat(first_name, ' ', last_name) as full_name,
       first_name || ' ' || last_name as full_name_alt
  from demo.customer_data


      Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com

select name as company,
       primary_poc as name,
       concat(lower(left(primary_poc, position(' ' in primary_poc) - 1)), '.',
         lower(right(primary_poc, length(primary_poc) - position(' ' in primary_poc))),
         '@', lower(name), '.com') as email
  from accounts


      You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.

select name as company,
       primary_poc as name,
       concat(lower(left(primary_poc, position(' ' in primary_poc) - 1)), '.',
         lower(right(primary_poc, length(primary_poc) - position(' ' in primary_poc))),
         '@', lower(replace(replace(name, ' ','_'), '.', '')), '.com') as email
  from accounts


      We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_pocs first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.

with personal_data as (select primary_poc as name,
                              upper(replace(name, ' ', '')) as company,
                              lower(left(primary_poc, position(' ' in primary_poc) - 1)) as first_name,
                              lower(right(primary_poc, length(primary_poc) - position(' ' in primary_poc))) as last_name
                         from accounts)

select name,
       concat(left(first_name, 1), right(first_name, 1),
              left(last_name, 1), right(last_name, 1),
              length(first_name), length(last_name),
              company) as password
  from personal_data
