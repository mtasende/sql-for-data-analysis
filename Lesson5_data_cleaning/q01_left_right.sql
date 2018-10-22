LEFT/RIGHT: pull from the left/right of a string to a separate string
LENGTH: the length of the string

select first_name,
       last_name,
       phone_number,
       left(phone_number, 3) as area_code,
       right(phone_number, 8) as phone_number_only,
       right(phone_number, length(phone_number) - 4) as phone_number_alt
  from demo.customer_data


      In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.

select right(website, 3) as extension,
       count(*) as occurrences
  from accounts
group by 1
order by desc


      There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).

select left(name, 1) as first_letter,
       count(*) as occurrences
  from accounts
group by 1
order by 2 desc


      Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?

with first_letter as (select name,
                             left(name, 1) as letter
                        from accounts)

select a.name,
       case when fl.letter in ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')
                   then 'number'
            else 'letter' end as letter_or_num
  from accounts as a
  join first_letter as fl on a.name = fl.name


      Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?

with vowels as (select name,
                       case when left(name, 1) in ('a', 'e', 'i', 'o', 'u')
                                   then 'vowel'
                            when left(name, 1) in ('A', 'E', 'I', 'O', 'U')
                                   then 'vowel'
                            else 'not_vowel' end as is_vowel
                  from accounts)

select is_vowel,
       cast(count(*) as float) /  cast((select count(*) from vowels) as float) as frac
  from vowels
group by is_vowel
