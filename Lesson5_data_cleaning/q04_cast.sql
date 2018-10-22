select *,
       date_part('month', to_date(month, 'month')) as clean_month,
       year || '-' || date_part('month', to_date(month, 'month')) || '-' || day as concatenated_date,
       cast(year || '-' || date_part('month', to_date(month, 'month')) || '-' || day as date) as formatted_date,
       (year || '-' || date_part('month', to_date(month, 'month')) || '-' || day)::date as formatted_date_alt
  from demo.ad_clicks


Write a query to look at the top 10 rows to understand the columns and the raw
data in the dataset called sf_crime_data

select *
  from sf_crime_data
limit 10


Write a query to change the date into the correct SQL date format.
You will need to use at least SUBSTR and CONCAT to perform this operation.

select date,
       cast(substr(date, 7, 4) || '-'
            || substr(date, 1, 2) || '-'
            || substr(date, 4, 2) as date) as clean_date
  from sf_crime_data
limit 10
