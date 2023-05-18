-- Lab | SQL Join (Part I)

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.

USE sakila;

SELECT * 
FROM sakila.category;

SELECT *
FROM sakila.film_category;

SELECT category.name, COUNT(film_category.film_id) AS num_films
FROM category
JOIN film_category 
ON category.category_id = film_category.category_id
GROUP BY category.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.

SELECT *
FROM sakila.payment;

SELECT staff.staff_id, SUM(payment.amount) AS total_amount
FROM staff
JOIN payment 
ON staff.staff_id = payment.staff_id
JOIN rental 
ON payment.rental_id = rental.rental_id
WHERE EXTRACT(YEAR_MONTH FROM rental.rental_date) = '200508'
GROUP BY staff.staff_id;

SELECT *
FROM Sakila.rental;

SELECT payment.staff_id, SUM(payment.amount) AS total_amount
FROM payment
JOIN rental 
ON payment.rental_id = rental.rental_id
WHERE EXTRACT(YEAR_MONTH FROM rental.rental_date) = '200508'
GROUP BY payment.staff_id;

-- 3. Which actor has appeared in the most films?

SELECT *
FROM sakila.film_actor;

SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS num_films
FROM actor
JOIN film_actor 
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY num_films DESC
LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)

SELECT *
FROM sakila.rental;

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS rented_films
FROM rental
JOIN customer 
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY rented_films DESC
LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.

SELECT *
FROM sakila.staff;

SELECT first_name, last_name, address_id
FROM sakila.staff;

SELECT staff_id, first_name, last_name, a.address 
FROM sakila.staff s
JOIN sakila.address a ON a.address_id = s.address_id
GROUP BY s.staff_id, s.first_name;

-- 6. List each film and the number of actors who are listed for that film.

SELECT film.film_id, film.title, COUNT(film_actor.actor_id) AS num_actors
FROM film
JOIN film_actor 
ON film.film_id = film_actor.film_id
GROUP BY film.film_id, film.title;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.

SELECT customer.customer_id, customer.last_name, SUM(payment.amount) as total_paid
FROM payment
JOIN customer 
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.last_name
ORDER BY last_name ASC;

-- 8. List number of films per category.
SELECT *
FROM film;

SELECT film_category.category_id, COUNT(film.film_id) AS num_films
FROM film_category
JOIN film 
ON film_category.film_id = film.film_id
GROUP BY film_category.category_id;
