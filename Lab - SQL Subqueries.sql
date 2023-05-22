-- Lab | SQL Subqueries 3.03

USE sakila;

-- 1. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT *
FROM sakila.film;

SELECT SUM(Copies) AS TotalCopies
FROM Inventory
WHERE title = 'Hunchback Impossible';

SELECT COUNT(inventory_id) AS TotalCopies
FROM inventory
WHERE inventory.film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible');

-- 2. List all films whose length is longer than the average of all the films.

SELECT film.title, film.length
FROM sakila.film
WHERE film.length > (SELECT AVG(film.length) from sakila.film);

-- 3. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT first_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = (
        SELECT film_id
        FROM Film
        WHERE title = 'Alone Trip'
    )
);

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT *
FROM sakila.category;

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM Category
    WHERE Category.name = 'Family'
);

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT first_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id IN (
            SELECT country_id
            FROM country
            WHERE Country = 'Canada'
        )
    )
);

SELECT customer.first_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT sub.first_name, sub.last_name, sub.film_count
FROM (
    SELECT a.first_name, a.last_name, COUNT(DISTINCT(fa.film_id)) AS film_count
    FROM sakila.film_actor fa
    JOIN sakila.actor a ON fa.actor_id = a.actor_id
    GROUP BY a.first_name, a.last_name
) AS sub
ORDER BY sub.film_count DESC;


SELECT title 
FROM sakila.film
WHERE film_id IN (
SELECT film_id 
FROM sakila.film_actor
WHERE actor_id = "101" OR actor_id = "110");

-- 7. Alter rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT sub.first_name, sub.last_name, sub.total_payment
FROM (
    SELECT c.first_name, c.last_name, SUM(p.amount) as total_payment
    FROM sakila.payment p
    JOIN sakila.customer c ON p.customer_id = c.customer_id
    GROUP BY c.first_name, c.last_name
) as sub
ORDER BY sub.total_payment ASC;

SELECT title
FROM sakila.film
WHERE film_id IN (
SELECT film_id 
FROM sakila.inventory
WHERE inventory_id IN (
SELECT inventory_id
FROM sakila.rental 
WHERE customer_id = "526"));



-- 8. Customers who spent more than the average payments.

SELECT first_name, last_name
FROM sakila.customer
WHERE customer_id IN (
SELECT customer_id
FROM sakila.payment 
WHERE payment.amount > (
SELECT AVG(amount)
FROM payment));