select
	ft.plane_tail_number,
	ft."year",
	avg(ft.daily_flight) as daily_avg
from
	(
	select
		fr.plane_tail_number,
		fr."year",
		count(*) as daily_flight
	from
		flight_reports fr
	where
		fr.is_cancelled = 0
	group by
		fr."year",
		fr."month",
		fr."day",
		fr.plane_tail_number ) as ft
group by
	ft."year",
	ft.plane_tail_number
having
	avg(ft.daily_flight) > 5
order by
	ft.plane_tail_number,
	ft."year"