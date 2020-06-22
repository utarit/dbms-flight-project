select
	fr.plane_tail_number, avg(flight_distance / flight_time ) as avg_speed
from
	flight_reports fr
where
	fr.plane_tail_number in ((
	select
		fr.plane_tail_number
	from
		flight_reports fr
	where
		fr."year" = 2016
		and fr."month" = 1
		and fr.weekday_id > 5
		and fr.is_cancelled = 0
	group by
		fr.plane_tail_number)
except (
select
	fr2.plane_tail_number
from
	flight_reports fr2
where
	fr2."year" = 2016
	and fr2."month" = 1
	and fr2.weekday_id < 6
	and fr2.is_cancelled = 0
group by
	fr2.plane_tail_number ))
	and "year" = 2016
	and "month" = 1
group by
	fr.plane_tail_number
	order by avg_speed desc