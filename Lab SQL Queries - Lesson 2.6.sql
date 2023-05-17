-- Lab | SQL Queries - Lesson 2.6 --

-- 1. In the table actor, which are the actors whose last names are not repeated? For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list. -- 
 -- 1
 
SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING count(*) = 1;

-- 2. Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once

SELECT last_name
FROM sakila.actor
GROUP BY last_name
HAVING count(*) > 1;


-- 3. Using the rental table, find out how many rentals were processed by each employee.

SELECT count(rental_id) FROM sakila.rental 
WHERE staff_id='1';

SELECT count(rental_id) FROM sakila.rental 
WHERE rental_id='1';

-- 4. Using the film table, find out how many films were released each year.

SELECT EXTRACT(YEAR FROM release_year) AS year, COUNT(*) AS film_count
FROM film
GROUP BY EXTRACT(YEAR FROM release_year);

SELECT release_year, COUNT(*) AS film_count
FROM film
GROUP BY release_year;

-- 5. Using the film table, find out for each rating how many films were there.

SELECT rating, COUNT(*) AS film_count
FROM film
GROUP BY rating;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places

SELECT rating, ROUND(AVG(length), 2) AS average_length
FROM film
GROUP BY rating;

-- 7. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.

SELECT title, length
FROM film
WHERE length IS NOT NULL AND length > 0
ORDER BY length;
