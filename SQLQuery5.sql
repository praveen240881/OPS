insert into planecrash (Accident_Date,Accident_Time,Location,Operator,Flight_No,route,ac_type,registration,cn_ln,ground,passenger_aboard,crew_aboard,passenger_fatalities,crew_fatalities,summary)
select 
cast(date as date), 
	case
		when time like '%Z%' then replace(time,'Z','') 
		when time = '?' then replace(time,'?','23:59:00')
		when time ='114:20:00' then  replace(time,'114:20:00','12:25:00')
		when time like '%c:%' then replace(time,'c:','')
		when time like '%c%' then replace(time,'c','')
		when time like '%d:%' then replace(time,'d:','')
		when time like '%d%' then replace(time,'d','')
		when time = '0.625' then replace(time,'0.625','00:06:25') 
		when time like '%"%' then replace(time,'"',':') 
	--	when time not like '%:%' then  concat(substring(time,1,2),':',substring(time,3,2))
		when len(time) = 3 and time not like '%:%' then concat(substring(time,1,1),':',substring(time,2,3),':','00')
		when time like '%;%' then replace(time,';',':')
		when len(time) = 1 and time not like '%:%' then concat(substring(time,1,1),':','00',':','00')
		when len(time) = 2 and time not like '%:%' then concat(substring(time,1,1),':','00',':','00')
		when time not like '%:%' then  concat(substring(time,1,2),':',substring(time,3,2))
		when time like '%c%' then replace(time,'c','')
		when len(time) = 4 and time not like '%:%' then concat(time,':','00')
		when len(time) = 5 and time not like '%:%' then concat(time,':','00')
 
else
	time
	end as time,
case 
		when location like '%,%' then  RIGHT(location , CHARINDEX (',' ,REVERSE(location))-1) 
	else
	location
end as location,
case
	when operator = '?' then 'Unknown Airlines'
else
operator
end as operator,
case
	when flight_no='?' then '281184'
	else
	flight_no
	end as filght_no,
case
	when route='?' then 'sangeetha-ops'
	else
	route
	end as route,

case
	when ac_type='?' then 'Air car'
	else
	ac_type
	end as ac_type,
case
	when registration='?' then '12345'
	else
	registration
	end as registration,
	case
	when cn_ln='?' then 'SA123'
	else
	cn_ln 
	end as cn_ln,
case 
	when ground = '?' then '10'
	else
	ground
	end as ground,
case
	when substring(TRIM(aboard),1,1) = '?' then '5'
	WHEN substring(TRIM(aboard),1,1) = '0' AND SUBSTRING(TRIM(aboard),CHARINDEX(':',TRIM(ABOARD))+1,1) LIKE '%?%' THEN '2'
	WHEN substring(TRIM(aboard),1,1) NOT in ('0','?') AND SUBSTRING(TRIM(aboard),CHARINDEX(':',TRIM(ABOARD))+1,1) LIKE '%?%' THEN '4'--cast(substring(TRIM(aboard),1,3)/2 as VARCHAR)
else
 SUBSTRING(TRIM(aboard),CHARINDEX(':',TRIM(ABOARD))+1,3)
end as Passenger_aboard,
case
	when substring(TRIM(aboard),1,1) = '?' then '5'
	WHEN substring(TRIM(aboard),1,1) = '0' AND  RIGHT(aboard , CHARINDEX (':' ,REVERSE(aboard))-1)  LIKE '%?%' THEN '2'
	WHEN substring(TRIM(aboard),1,1) NOT in ('0','?') AND RIGHT(aboard , CHARINDEX (':' ,REVERSE(aboard))-1)  LIKE '%?%' THEN '4' --CAST(substring(TRIM(aboard),1,3)/2 as VARCHAR)

else
replace(RIGHT(aboard , CHARINDEX (':' ,REVERSE(aboard))-1),')','') 
end as Crew_aboard,

case
	when substring(TRIM(fatalities),1,1) = '?' then '5'
	WHEN substring(TRIM(fatalities),1,1) = '0' AND SUBSTRING(TRIM(fatalities),CHARINDEX(':',TRIM(fatalities))+1,1) LIKE '%?%' THEN '2'
	WHEN substring(TRIM(fatalities),1,1) NOT in ('0','?') AND SUBSTRING(TRIM(fatalities),CHARINDEX(':',TRIM(fatalities))+1,1) LIKE '%?%' THEN '4'--cast(substring(TRIM(aboard),1,3)/2 as VARCHAR)
else
 SUBSTRING(TRIM(fatalities),CHARINDEX(':',TRIM(fatalities))+1,3)
end as Passenger_fatalities,
case
	when substring(TRIM(fatalities),1,1) = '?' then '5'
	WHEN substring(TRIM(fatalities),1,1) = '0' AND  RIGHT(fatalities , CHARINDEX (':' ,REVERSE(fatalities))-1)  LIKE '%?%' THEN '2'
	WHEN substring(TRIM(fatalities),1,1) NOT in ('0','?') AND RIGHT(fatalities , CHARINDEX (':' ,REVERSE(fatalities))-1)  LIKE '%?%' THEN '4' --CAST(substring(TRIM(aboard),1,3)/2 as VARCHAR)

else
replace(RIGHT(fatalities , CHARINDEX (':' ,REVERSE(fatalities))-1),')','') 
end as Crew_fatalities,
case	
	when summary = '?' then 'Engine Failure'
else
summary
end as summary

from STG_Planecrash 

	select * from Planecrash order by summary