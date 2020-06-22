select ac.airline_name
from airline_codes ac, ((
select
	distinct fr.airline_code
from
	flight_reports fr
where
	fr.dest_city_name = 'Boston, MA'
	and is_cancelled = 0
	and (fr."year" = 2019
	or fr."year" = 2018)
intersect
select
	distinct fr.airline_code
from
	flight_reports fr
where
	fr.dest_city_name = 'New York, NY'
	and is_cancelled = 0
	and (fr."year" = 2019
	or fr."year" = 2018)
intersect
select
	distinct fr.airline_code
from
	flight_reports fr
where
	fr.dest_city_name = 'Portland, ME'
	and is_cancelled = 0
	and (fr."year" = 2019
	or fr."year" = 2018)
intersect
select
	distinct fr.airline_code
from
	flight_reports fr
where
	fr.dest_city_name = 'Washington, DC'
	and is_cancelled = 0
	and (fr."year" = 2019
	or fr."year" = 2018)
intersect
select
	distinct fr.airline_code
from
	flight_reports fr
where
	fr.dest_city_name = 'Philadelphia, PA'
	and is_cancelled = 0
	and (fr."year" = 2019
	or fr."year" = 2018))
except (
select
distinct fr.airline_code
from
flight_reports fr
where
fr.dest_city_name = 'Boston, MA'
and is_cancelled = 0
and (fr."year" = 2016
or fr."year" = 2017)
intersect
select
distinct fr.airline_code
from
flight_reports fr
where
fr.dest_city_name = 'New York, NY'
and is_cancelled = 0
and (fr."year" = 2016
or fr."year" = 2017)
intersect
select
distinct fr.airline_code
from
flight_reports fr
where
fr.dest_city_name = 'Portland, ME'
and is_cancelled = 0
and (fr."year" = 2016
or fr."year" = 2017)
intersect
select
distinct fr.airline_code
from
flight_reports fr
where
fr.dest_city_name = 'Washington, DC'
and is_cancelled = 0
and (fr."year" = 2016
or fr."year" = 2017)
intersect
select
distinct fr.airline_code
from
flight_reports fr
where
fr.dest_city_name = 'Philadelphia, PA'
and is_cancelled = 0
and (fr."year" = 2016
or fr."year" = 2017))) as tf 
where tf.airline_code = ac.airline_code 
order by ac.airline_name 
