select ac.airline_name , count(*) 
from airline_codes ac, ((
select
	airline_code,
	plane_tail_number
from
	flight_reports fr,
	world_area_codes wac
where
	wac.wac_id = fr.dest_wac_id
	and wac.wac_name = 'Texas')
except (
select
airline_code,
plane_tail_number
from
flight_reports fr2,
world_area_codes wac2
where
fr2.dest_wac_id = wac2.wac_id
and wac2.wac_name != 'Texas')) as tf
where ac.airline_code = tf.airline_code
group by ac.airline_code 
order by ac.airline_name 
