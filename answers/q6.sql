select af.weekday_id, af.weekday_name, af.avg_delay
from (select
	w2.weekday_id, w2.weekday_name, avg(fr.departure_delay+fr.arrival_delay) as avg_delay
from
	flight_reports fr, weekdays w2 
where
	fr.weekday_id = w2.weekday_id 
	and fr.origin_city_name like 'San Francisco%'
	and fr.dest_city_name like 'Boston%'
group by w2.weekday_id ) as af
where af.avg_delay <= all (select
	avg(fr.departure_delay+fr.arrival_delay) as avg_delay
from
	flight_reports fr, weekdays w2 
where
	fr.weekday_id = w2.weekday_id 
	and fr.origin_city_name like 'San Francisco%'
	and fr.dest_city_name like 'Boston%'
group by w2.weekday_id)