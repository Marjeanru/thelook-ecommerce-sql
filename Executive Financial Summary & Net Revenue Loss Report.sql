-- Number of Orders, Items filter by Status
Select 
    Coalesce(o.status, 'Total_number') as Status,
    Count(distinct(O.order_id)) AS Total_orders,
    Count(O.order_id) AS Total_items
from orders as O
INNER JOIN order_items as OI ON O.order_id = OI.order_id
Group by Rollup (O.status)
Order by Total_orders ASC;


-- Total Firm Revenues 
Select 
    To_Char((Sum(sale_price) - SUM(Case when O.status IN('Cancelled','Returned') Then sale_price else 0 END)), '99,999,999.99€') AS Total_Sales_Revenue,
	To_Char(SUM(Case when O.status IN('Cancelled','Returned') Then sale_price else 0 END), '99,999,999.99€') AS Total_Sales_Lost,
    Round(AVG(Case When O.status NOT IN('Cancelled','Returned') Then sale_price Else 0 END), 2) AS Average_item_revenue,
    To_Char(Sum(P.cost), '99,999,999.99€') AS Total_Cost,
    To_Char((Sum(sale_price) - SUM(Case when O.status IN('Cancelled','Returned') Then sale_price else 0 END)) - Sum(P.cost), '99,999,999.99€') as Total_Net_Revenue	
from orders as O
INNER JOIN order_items as OI ON O.order_id = OI.order_id
INNER JOIN products as P ON P.id = OI.product_id;

--Loss by category
SELECT 
    p.category,
    COUNT(poi.id) AS total_items_ordered,
    COUNT(CASE WHEN poi.status = 'Cancelled' THEN 1 END) AS cancelled_items,
    COUNT(CASE WHEN poi.status = 'Returned' THEN 1 END) AS returned_items,
    Round(((COUNT(CASE WHEN poi.status IN ('Cancelled', 'Returned') THEN 1 END)::numeric/ COUNT(poi.id))*100),2)||'%'  AS loss_rate_percentage,
    TO_CHAR(SUM(CASE WHEN poi.status IN ('Cancelled', 'Returned') THEN poi.sale_price ELSE 0 END), '9,999,999.99€') AS revenue_lost
FROM public.products p
JOIN public.order_items poi ON p.id = poi.product_id
GROUP BY p.category
ORDER BY loss_rate_percentage DESC;







