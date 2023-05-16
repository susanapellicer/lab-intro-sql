USE sakila;
SELECT * 
FROM actor, customer, film;

SELECT title FROM film;

SELECT name AS language
FROM language;

SELECT count(store_ID)
FROM store;

SELECT count(staff_ID)
FROM staff;

SELECT first_name
FROM staff;
