-- Moderate 

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A 

select c.first_name,c.last_name,c.email,g.name
from customers c
join invoice i on i.customer_id = c.customer_id
join invoice_line il on il.invoice_id = i.invoice_id 
join track t on t.track_id = il.track_id 
join genre g on g.genre_id = t.genre_id 
where g.name = "Rock"
order by c.email;

-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands 

select a.name as artist_name,g.name as genre_name,count(t.track_id) as total_tracks
from artist a 
join album al on al.artist_id = a.artist_id 
join track t on t.album_id = al.album_id 
join genre g on g.genre_id = t.genre_id
where g.name = "Rock"
group by a.name,g.name
order by total_tracks desc
limit 10;

-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first 

select t.name, t.milliseconds
from track t 
where t.milliseconds > (select avg(milliseconds) from track)
order by t.milliseconds desc;