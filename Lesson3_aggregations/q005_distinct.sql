select distinct account_id,
                channel
  from demo.web_events
order by account_id


    Use DISTINCT to test if there are any accounts associated with more than one region.

select distinct a.name as account,
                r.name as region
  from accounts as a
  join sales_reps as sr on a.sales_rep_id = sr.id
  join region as r on sr.region_id = r.id


    Have any sales reps worked on more than one account?

No me convence la explicación del uso que hacen de distinct para esto y lo de arriba. Lo salteo.
