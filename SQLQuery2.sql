select * from STG_Planecrash

select * from Planecrash


SELECT Accident_Date	,			
	   Accident_Time	,	
	   Location			,
	   Operator			,
	   Flight_No		,	
	   route			,	
	   ac_type			,	
	   registration		,
	   cn_ln			,	
	   Passenger_aboard	,
	   Crew_aboard		,	
	   Passenger_fatalities,
	   Crew_fatalities		,
	   ground				,
	   summary				,
	   count(*)
	   from Planecrash
	   group by Accident_Date	,			
	   Accident_Time	,	
	   Location			,
	   Operator			,
	   Flight_No		,	
	   route			,	
	   ac_type			,	
	   registration		,
	   cn_ln			,	
	   Passenger_aboard	,
	   Crew_aboard		,	
	   Passenger_fatalities,
	   Crew_fatalities		,
	   ground				,
	   summary				
	   having count(*) > 1


with cte
(Accident_Date	,			
	   Accident_Time	,	
	   Location			,
	   Operator			,
	   Flight_No		,	
	   route			,	
	   ac_type			,	
	   registration		,
	   cn_ln			,	
	   Passenger_aboard	,
	   Crew_aboard		,	
	   Passenger_fatalities,
	   Crew_fatalities		,
	   ground				,
	   summary				,
	duplicatecount)
	   	   
	as 
	(SELECT Accident_Date	,			
	   Accident_Time	,	
	   Location			,
	   Operator			,
	   Flight_No		,	
	   route			,	
	   ac_type			,	
	   registration		,
	   cn_ln			,	
	   Passenger_aboard	,
	   Crew_aboard		,	
	   Passenger_fatalities,
	   Crew_fatalities		,
	   ground				,
	   summary				
		   from Planecrash
	   group by Accident_Date	,			
	   Accident_Time	,	
	   Location			,
	   Operator			,
	   Flight_No		,	
	   route			,	
	   ac_type			,	
	   registration		,
	   cn_ln			,	
	   Passenger_aboard	,
	   Crew_aboard		,	
	   Passenger_fatalities,
	   Crew_fatalities		,
	   ground				,
	   summary				
	   having count(*) > 1)

delete from cte where count(()_ > 1

