-- Lab | SQL Queries - Lesson 2.5 --

USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’. --

SELECT *, first_name
FROM sakila.actor
WHERE first_name = 'Scarlett';

-- 2. How many physical copies of movies are available for rent in the store's inventory? --

SELECT count(*) inventory_id
FROM sakila.rental;

-- 2.1. How many unique movie titles are available? --

SELECT count(DISTINCT inventory_id)
FROM sakila.rental;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration --

SELECT min(length) AS min_duration, max(length) AS max_duration
FROM sakila.film
WHERE length >0;

-- 4. What's the average movie duration expressed in format (hours, minutes)? --

SELECT length
FROM sakila.film;

SELECT sec_to_time(AVG(length))
FROM sakila.film;

-- 5. How many distinct (different) actors' last names are there? --

SELECT DISTINCT count(last_name)
FROM sakila.actor;

-- 6. How many days was the company operating? Assume the last rental date was their closing date. (check DATEDIFF() function) -- 

SELECT rental_date
FROM sakila.rental;

SELECT DATEDIFF(MAX(DATE(rental_date)),MIN(DATE(rental_date))) AS days_between_first_and_last_rent 
FROM sakila.rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results -- 

SELECT *, date_format(last_update,'%m') AS 'month', date_format(last_update,'%d') AS 'day' 
FROM sakila.rental LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week -- 

SELECT *, date_format(rental_date, '%W') AS 'weekday of rental',
CASE
WHEN (date_format(rental_date,'%W') = 'Saturday') or (date_format(rental_date,'%W') = 'Sunday')
THEN 'Weekend' 
ELSE 'Weekday' 
END AS day_type 
FROM sakila.rental;

-- 9. Get release years -- 

SELECT title, release_year FROM sakila.film;

-- 10. Get all films with ARMAGEDDON in the title -- 

SELECT title FROM sakila.film WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO -- 

SELECT title FROM sakila.film WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films  -- 

SELECT title, length
FROM sakila.film
WHERE (length > 0)
ORDER BY length
DESC LIMIT 10;

-- 13. How many films include Behind the Scenes content? -- 

SELECT * 
FROM film;

SELECT DISTINCT count(special_features)
FROM film
WHERE special_features LIKE '%Behind the Scenes%';