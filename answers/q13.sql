select
	ac.airline_name,
	sum(case when weekday_id = 1 then 1 else 0 end) as monday_flights,
	sum(case when weekday_id = 7 then 1 else 0 end) as sunday_flights
from
	flight_reports fr,
	airline_codes ac
where
	ac.airline_code = fr.airline_code
	and is_cancelled = 0
group by
	ac.airline_code
order by
	ac.airline_name