
--1.SALES MONTH
SELECT 
    EXTRACT(YEAR FROM II.sold_at) AS Year,
    EXTRACT(MONTH FROM II.sold_at) AS Month,
    SUM(cost) AS Total_Sale_Month
FROM inventory_items AS II
INNER JOIN  order_items AS OI ON II.id=OI.inventory_item_id 
WHERE II.sold_at IS NOT NULL
GROUP BY EXTRACT(YEAR FROM II.sold_at), EXTRACT(MONTH FROM II.sold_at)
ORDER BY Year ASC, Month ASC;

Select * 
FROM inventory_items AS II
INNER JOIN  order_items AS OI ON II.id=OI.inventory_item_id
WHERE sold_at IS NOT NULL
Order by II.id;

/*
I WAS USING THE METHOD ABOVE BUT AFTER RECEIVING A TABLE WITHOUT DATA I NOTICED THE ROWS IN WHICH THE INNER JOINS COINCIDE
THE COLUMN sold_at IS ALWAYS NULL SO I CAN'T USE THIS COLUMN, THEN I AM GOING TO USE ANOTHER METHOD FOR CALCULATING THE SALES 
PER MONTH 
*/


--2.Method Sales Month
Select 
		Concat(SUM(sale_price),'€') as Total_Sales_Month,
	TO_CHAR(created_at,'Month') as MONTH,
	Extract(YEAR from created_at) as YEAR
	from order_items AS OI
Where OI.status NOT IN('Cancelled','Returned')
Group by ((TO_CHAR(created_at,'Month')),Extract(YEAR from created_at))
Order by SUM(sale_price) ASC

/*
Analyzing Data i can guarantee Sales are increasing per Year from 2019-2024.Last quarter has the highest sales_price each year.
Historical Maximum January 2024 and Minimum January 2019.
*/ 