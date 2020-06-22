select
	fr."year" ,
	w2.weekday_name ,
	cr.reason_desc,
	count(*) as num
from
	flight_reports fr,
	cancellation_reasons cr,
	weekdays w2
where
	fr.weekday_id = w2.weekday_id
	and fr.cancellation_reason = cr.reason_code
	and is_cancelled = 1
group by
	fr."year",
	w2.weekday_id,
	cr.reason_code
having
	count(*) >= all (
	select
		count(*)
	from
		flight_reports fr2
	where
		is_cancelled = 1
		and fr2."year" = fr."year"
		and fr2.weekday_id = w2.weekday_id
	group by
		fr2."year",
		fr2.weekday_id,
		fr2.cancellation_reason)
order by
	fr."year"