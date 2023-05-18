-- Lab | SQL Join (Part II)

-- 1. Write a query to display for each store its store ID, city, and country.

USE sakila;

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, SUM(payment.amount) AS total_business
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3. Which film categories are longest?

SELECT category.name AS category_name, AVG(film.length) AS average_length
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.category_id, category_name
ORDER BY average_length DESC;

-- 4. Display the most frequently rented movies in descending order.

SELECT film.film_id, film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY rental_count DESC;

-- 5. List the top five genres in gross revenue in descending order.

SELECT category.name AS genre, SUM(payment.amount) AS gross_revenue
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;


-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT film.title, inventory.store_id
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur' AND store.store_id = 1;


-- 7. Get all pairs of actors that worked together.

SELECT DISTINCT a1.actor_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
                a2.actor_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a1.actor_id < a2.actor_id
ORDER BY a1.actor_id, a2.actor_id;

