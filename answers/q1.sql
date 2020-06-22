select
	ac.airline_name,
	ac.airline_code,
	avg(fr.departure_delay) as avg_delay
from
	flight_reports fr,
	airline_codes ac
where
	ac.airline_code = fr.airline_code
	and fr.is_cancelled = 0
	and fr."year" = 2018
group by
	ac.airline_code
order by
	avg_delay,
	ac.airline_name