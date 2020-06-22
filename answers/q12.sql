select 
bf."year",
bf.airline_code,
bf.boston_flights as boston_flight_count,
(100.0*bf.boston_flights/bf.total_flights) as boston_flight_percentage
from (select
	fr."year",
	fr.airline_code ,
	sum(case when fr.dest_city_name like 'Boston%' then 1 else 0 end) as boston_flights,
	count(*) as total_flights
from
	flight_reports fr
where
	is_cancelled = 0
group by
	fr."year",
	fr.airline_code) as bf
	where bf.boston_flights > 0 and (100*bf.boston_flights/bf.total_flights) > 0
order by bf."year", bf.airline_code
