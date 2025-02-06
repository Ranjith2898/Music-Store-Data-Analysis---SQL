-- Advance

-- 1. Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent 
with sample as (
select a.artist_id,a.name as artist_name,c.customer_id,concat(c.first_name,' ',c.last_name) as customer_fullName,
sum(il.quantity * il.unit_price) as Total_Spent
from artist a
join album al on a.artist_id = al.artist_id
join track t on t.album_id = al.album_id
join invoice_line il on il.track_id=t.track_id
join invoice i on i.invoice_id=il.invoice_id
join customers c on c.customer_id=i.customer_id
group by a.artist_id,a.name,c.customer_id,concat(c.first_name,' ',c.last_name))

select artist_id,artist_name,customer_id,customer_fullName,Total_Spent
from sample 
order by Total_spent desc;


-- 2. We want to find out the most popular music Genre for each country. We determine the 
-- most popular genre as the genre with the highest amount of purchases. Write a query 
-- that returns each country along with the top Genre. For countries where the maximum 
-- number of purchases is shared return all Genres 

select genre_id,genre_name,country,purchases_per_genre,
row_number() over (partition by country order by purchases_per_genre desc ) as row_numbering 
from (select g.genre_id,g.name as genre_name,c.country,count(il.invoice_line_id) as purchases_per_genre
from customers c
join invoice i on c.customer_id=i.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id=il.track_id
join genre g on g.genre_id=t.genre_id
group by g.genre_id,g.name, c.country) as A;


-- 3. Write a query that determines the customer that has spent the most on music for each 
-- country. Write a query that returns the country along with the top customer and how 
-- much they spent. For countries where the top amount spent is shared, provide all 
-- customers who spent this amount 

select customer_id,customer_FullName,country,Total_Spent from
(select customer_id,customer_FullName,country,Total_Spent,
row_number() over (partition by country) as row_numberibg from
(select c.customer_id,concat(c.first_name,' ',c.last_name) as customer_FullName,
c.country,sum(i.total) as Total_Spent
from customers c 
join invoice i on i.customer_id=c.customer_id
join invoice_line il on il.invoice_id = i.invoice_id
group by c.customer_id,c.country,concat(c.first_name,' ',c.last_name)
order by Total_Spent desc) as sample) as B;