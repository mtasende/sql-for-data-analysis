select date_trunc('day', occurred_at) as day,
       sum(standard_qty) as standard_qty_sum
  from demo.orders
group by date_trunc('day', occurred_at)
order by date_trunc('day', occurred_at)

date_trunc() ->
    microsecond
    millisecond
    second
    minute
    hour
    day
    week
    month
    quarter
    year
    decade
    century
    millenium

date_part() -> idem

select date_part('dow', occurred_at) as day_of_week,
       sum(total) as total_qty
  from demo.orders
group by 1
order by 2 desc

https://blog.modeanalytics.com/date-trunc-sql-timestamp-function-count-on/

https://www.postgresql.org/docs/9.1/static/functions-datetime.html


Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?

select date_trunc('year', occurred_at) as year,
       sum(total_amt_usd) as total_usd
  from orders
group by 1
order by 2 desc


Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?

select date_part('month', occurred_at) as month,
       sum(total_amt_usd) as total_usd
  from orders
group by 1
order by 2 desc


Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?

select date_trunc('year', occurred_at) as year,
       sum(total) as total
  from orders
group by 1
order by 2 desc


Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?

select date_part('month', occurred_at) as month,
       sum(total) as total
  from
where occurred_at between '2014-01-01' and '2017-01-01'
group by 1
order by 2 desc


In which month of which year did Walmart spend the most on gloss paper in terms of dollars?

select date_trunc('month', o.occurred_at) as year_month,
       sum(o.gloss_amt_usd) as gloss_usd
  from orders as o
  join accounts as a on o.account_id = a.id
where a.name = 'Walmart'
group by 1
order by  desc
