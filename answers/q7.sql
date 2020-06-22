select
	tf.airline_name, cf.total_count*100.0/tf.total_count as percentage
from
	(
	select
		ac.airline_name,
		count(*) as total_count
	from
		flight_reports fr,
		airline_codes ac
	where
		fr.airline_code = ac.airline_code
		and fr.origin_city_name like 'Boston%'
	group by
		ac.airline_code) as tf,
	(
	select
		ac.airline_name,
		count(*) as total_count
	from
		flight_reports fr,
		airline_codes ac
	where
		fr.airline_code = ac.airline_code
		and fr.origin_city_name like 'Boston%'
		and fr.is_cancelled = 1
	group by
		ac.airline_code ) as cf
where
	tf.airline_name = cf.airline_name
	and cf.total_count > tf.total_count/10
order by percentage desc