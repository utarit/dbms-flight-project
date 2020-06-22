select
	ac.airport_desc 
from
	airport_codes ac,
	(
	select
		origin_airport_code as airport_code,
		out_num + in_num as traffic
	from
		(
		select
			origin_airport_code,
			count(*) as out_num
		from
			flight_reports fr
		where
			is_cancelled = 0
		group by
			origin_airport_code) as ot,
		(
		select
			dest_airport_code,
			count(*) as in_num
		from
			flight_reports fr
		where
			is_cancelled = 0
		group by
			dest_airport_code) as it
	where
		ot.origin_airport_code = it.dest_airport_code
	order by
		traffic desc
	limit 5) as tb
where
	ac.airport_code = tb.airport_code
order by ac.airport_desc 