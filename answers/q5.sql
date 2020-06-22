select
	concat_ws('/', fr1."day", fr1."month", fr1."year") as flight_date,
	fr1.plane_tail_number,
	fr1.arrival_time,
	fr2.departure_time,
	fr1.origin_city_name,
	fr1.dest_city_name,
	fr2.dest_city_name,
	fr1.flight_time+fr1.taxi_out_time+fr2.taxi_in_time+fr2.flight_time as total_time,
	fr1.flight_distance +fr2.flight_distance as total_distance
from
	flight_reports fr1,
	flight_reports fr2
where
	fr1.is_cancelled = 0
	and fr2.is_cancelled = 0
	and fr1.origin_city_name like 'Seattle%'
	and fr2.dest_city_name like 'Boston%'
	and fr1.dest_city_name = fr2.origin_city_name
	and fr1."year" = fr2."year"
	and fr1."month" = fr2."month"
	and fr1."day" = fr2."day"
	and fr1.arrival_time < fr2.departure_time 
	and fr1.plane_tail_number = fr2.plane_tail_number 	
order by total_time, total_distance, fr1.plane_tail_number, fr1.dest_city_name
