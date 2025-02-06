-- Music Store Data Analysis Project
use music_store;
-- 1. Who is the senior most employee based on job title? 

select * from employee
order by levels desc
limit 1;

-- 2. Which countries have the most Invoices? 

select billing_country, count(*) as most_invoices
from invoice
group by billing_country
order by most_invoices desc;

-- 3. What are top 3 values of total invoice? 

select total 
from invoice
order by total desc
limit 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice 
-- totals 

select billing_city,sum(total) as totals
from invoice
group by billing_city
order by totals desc
limit 1;

-- 5. Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 

select c.first_name,c.last_name,sum(i.total) as most_money_spended
from customers c 
join invoice i on c.customer_id = i.customer_id 
group by c.first_name,c.last_name 
order by most_money_spended desc 
limit 1;
