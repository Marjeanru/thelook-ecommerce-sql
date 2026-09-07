--Ways more used for entering the page

Select traffic_source,
	count(*) as times_source_used
from users 
Group by 1
Order by 1 desc;

--Where users end up 

Select 
    event_type,
    COUNT(DISTINCT session_id) AS total_sessions
from public.events
WHERE event_type IN ('department', 'product', 'cart', 'purchase')
Group By event_type
Order by Case 
	when event_type= 'department' then 1
	when event_type= 'product' then 2
	when event_type= 'cart' then 3
	when event_type= 'purchase' then 4 END;
		
