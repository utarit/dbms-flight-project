select
	fr1.plane_tail_number,
	fr1.airline_code,
	fr2.airline_code
from
	(select distinct t1."year", t1."month", t1."day", t1.plane_tail_number, t1.airline_code from flight_reports t1) as fr1,
	(select distinct t2."year", t2."month", t2."day", t2.plane_tail_number, t2.airline_code from flight_reports t2) as fr2
where
	fr1.plane_tail_number = fr2.plane_tail_number
	and fr1.airline_code != fr2.airline_code
	and ((fr1."year" < fr2."year")
	or (fr1."year" = fr2."year"
	and fr1."month" < fr2."month")
	or (fr1."year" = fr2."year"
	and fr1."month" = fr2."month"
	and fr1."day" < fr2."day"))
group by
	fr1.plane_tail_number,
	fr1.airline_code,
	fr2.airline_code
order by
	fr1.plane_tail_number
