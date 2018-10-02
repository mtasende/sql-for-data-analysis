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


select date_trunc('day', occurred_at) as day,
	   channel,
       count(*) as events_count
  from web_events
group by 1, 2
order by 3 desc
