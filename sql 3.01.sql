-- Lab | SQL - Lab 3.01

-- Activity 1

USE sakila;

-- 1. Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

INSERT INTO staff (first_name, last_name, email, store_id, address_id, username)
VALUES
('Tammy', 'Sanders', 'TAMMY.SANDERS@sakilacustomer.org', '2', '5', 'Tammy');

SELECT *
FROM sakila.staff;

-- 3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. (...)

SELECT *
FROM sakila.rental;

SELECT *
FROM sakila.inventory;

SELECT *
FROM sakila.film;

SELECT * 
FROM sakila.staff;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

select inventory_id from sakila.inventory
where film_id = '1';

SELECT store_id FROM sakila.staff
WHERE first_name = 'Mike';

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) 
VALUES
("2023-05-22 17:05:25","1", "130", "1");

SELECT *
FROM sakila.rental;

-- Activity 2

-- 1st improvement: DROP Actor table and add all the data into film_actor table
-- 2nd improvement: DROP Category table and add all the data into film_category table
-- 3rd improvement: DROP language table and all the data into film table 


