select channel,
       avg(event_count) as avg_event_count
from
  (select date_trunc('day', occurred_at) as day,
         channel,
         count(*) as event_count
    from demo.web_events_full
  group by 1, 2) sub
group by 1
order by 2 desc


  Find the number of events that occur for each day for each channel

select date_trunc('day', occurred_at) as day,
	     channel,
       count(*) as events_count
  from web_events
group by 1, 2
order by 3 desc


  Create a subquery that simply provides all of the data from your first query

select *
  from
    (select date_trunc('day', occurred_at) as day,
            channel,
            count(*) as events_count
      from web_events
    group by 1, 2
    order by 3 desc) as dc_events_count


    Find the average number of events for each channel.

select channel,
       avg(events_count) as avg_daily_count
  from
    (select date_trunc('day', occurred_at) as day,
            channel,
            count(*) as events_count
       from web_events
     group by 1, 2) as dc_events_count
group by channel
order by 2 desc
