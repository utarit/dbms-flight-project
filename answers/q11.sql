select
	ac.airline_name ,
	fn."year",
	sum(fn.flight_count) as total_num_flights,
	sum(fn.cancelled_num) as cancelled_flights
from
	airline_codes ac,
	(
	select
		"year" ,
		"month" ,
		"day" ,
		airline_code,
		count(*) as flight_count,
		sum(case when is_cancelled = 1 then 1 else 0 end) as cancelled_num
	from
		flight_reports fr
	group by
		fr."year",
		fr."month" ,
		fr."day",
		fr.airline_code) as fn
where
	ac.airline_code = fn.airline_code
	and ac.airline_name not in (select
	ac.airline_name 
from
	airline_codes ac,
	(
	select
		"year" ,
		"month" ,
		"day" ,
		airline_code,
		count(*) as flight_count
	from
		flight_reports fr
	group by
		fr."year",
		fr."month" ,
		fr."day",
		fr.airline_code) as fn
where
	ac.airline_code = fn.airline_code
group by
	ac.airline_code,
	fn."year"
having
	avg(fn.flight_count) < 2000)
group by
	ac.airline_code,
	fn."year"
having
	avg(fn.flight_count) > 2000
order by ac.airline_name 