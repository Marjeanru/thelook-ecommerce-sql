--DATA ANALYZE: AMOUNT SPEND PER PERSON, Who is the one spending the most.

Select 
	user_id,
	CONCAT(first_name,' ',last_name) as Full_Name,
	country,
	state,
	city,
	to_char(Sum(sale_price),'99,999.99€')as Total_spend
	from order_items AS OI
INNER JOIN users AS U ON U.id=OI.user_id
Where status NOT IN ('Cancelled','Returned')
Group By user_id,Full_Name,country,state,city
Order by Sum(sale_price) DESC;


--DATA ANALYZE: WHICH IS THE COUNTRY WITH MOST EXPENSES

Select 
	country,
	To_char(Sum(sale_price),'9,999,999.99€') as Total_spend  
from order_items AS OI
INNER JOIN users AS U ON U.id=OI.user_id
Where status NOT IN ('Cancelled','Returned')
Group by country
Order by Sum(sale_price) desc;


-- Total_spends divide by age 


Select 
	Case When age>55 Then 'elder'
		 When age>=30 and age<=55 Then 'adult' else 'young' END AS AGE,
	To_char(Sum(sale_price),'9,999,999.99€') as Total_spend 
from users AS U
INNER JOIN order_items AS OI ON U.id=OI.user_id
Where status NOT IN ('Cancelled','Returned')
GROUP BY 1
Order by Sum(sale_price) DESC;


--Does customers buy again?

Select 
	Buy_again,
	count(user_id) AS Total_users,
	Round((Count(user_id)/Sum(Count(user_id)) OVER())*100,2) AS percentage
from(Select 
	Case When Count(distinct(order_id))>1 Then 'Buying Again' else 'Just One' END AS Buy_again,
	user_id
from users AS U
INNER JOIN order_items AS OI ON U.id=OI.user_id
Where OI.status NOT IN ('Cancelled','Returned')
Group by 2)a
Group by 1


--Which are the most purchased products

Select 
	P.name,
	category,
	Count(P.id) as Bought_products
from products AS P
INNER JOIN order_items AS OI ON OI.product_id= P.id
Where status NOT IN ('Cancelled','Returned')
Group by P.name,category
Order by Count(P.id) desc;



--Most purchased categories Intimates, Jeans, Tops & Teess


Select	
	category,
	Count(P.id) as Bought_products
from products AS P
INNER JOIN order_items AS OI ON OI.product_id= P.id
Where status NOT IN ('Cancelled','Returned')
Group by category
Order by Count(P.id) desc
Limit 10;







