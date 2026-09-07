--Time taken for preparing and deliver a product
Select * from order_items O
INNER JOIN products P ON P.id=O.product_id 
where status= 'Cancelled' and Extract(epoch from(delivered_at-created_at))<0;

/*
When calculating the time elapsed between order creation and delivery, I obtained negative results. Initially, I thought this was 
a calculation error related to the different locations of the distribution centers; however, upon observing that the time difference
amounted to nearly four days, I concluded that performing this calculation is pointless due to errors in the Excel file used.
*/


--Result not taking in to account negative outcomes
Select 
Round(AVG(Extract(Epoch from(delivered_at-created_at)/3600)),2) as Time_taken_hours,
Round(Min(Extract(Epoch from(delivered_at-created_at)/3600)),2) as Minimum_taken_hours,
Round(Max(Extract(Epoch from(delivered_at-created_at)/3600)),2) as Maximum_taken_hours
from order_items O
INNER JOIN products P ON P.id=O.product_id 
where status NOT IN ('Cancelled') AND Extract(epoch from(delivered_at-created_at))>0;


-- Which items are taking up space in the inventory without being sold


-- Product
Select product_name,
	product_category,
	count(*) as unsold_items 
from public.inventory_items
where sold_at IS null
Group by (product_name,product_category)
Order by 3 desc;

-- category
Select product_category,
	count(*) as unsold_items 
from public.inventory_items
where sold_at IS null
Group by (product_category)
Order by 2 desc









