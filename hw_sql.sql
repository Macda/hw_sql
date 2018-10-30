
-- Q1a
USE sakila;

SELECT first_name, last_name
FROM actor;

-- Q1b
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS `Actor Name`
  FROM actor;
  
-- Q2a
SELECT first_name, last_name, actor_id
  FROM actor
  WHERE first_name = "Joe";
  
-- Q2b

SELECT first_name, last_name, actor_id
  FROM actor
  WHERE last_name LIKE '%GEN%';
  
-- Q2c
 SELECT first_name, last_name, actor_id
  FROM actor
  WHERE last_name LIKE '%LI%'
  ORDER BY last_name, first_name;
  
-- Q2d

SELECT country_id, country
  FROM country
  WHERE country;
  
-- Q3a

ALTER TABLE actor
  ADD COLUMN description BLOB AFTER first_name;


-- Q3b 

 ALTER TABLE actor
  DROP COLUMN description;
  
-- Q4a
SELECT last_name, count(last_name) AS 'last_name_number'
  FROM actor
  GROUP BY last_name
  HAVING `last_name_number` >= 2;
  
-- Q4b

SELECT last_name, count(last_name) AS 'last_name_number'
  FROM actor
  GROUP BY last_name
  Having `last_name_number` >= 2;

-- Q4c 

UPDATE actor
  SET first_name = 'HARPO'
  WHERE first_name = 'GROUCHO'
  and last_name = 'WILLIAMS';

-- Q4d

UPDATE actor
  SET first_name =
  CASE
   WHEN first_name = 'HARPO'
    THEN 'GROUCHO'
   ELSE 'MUCHO GROUCHO'
  END
  WHERE actor_id = 172;
  

-- 5a 

SHOW CREATE TABLE address;

-- Q6a

SELECT s.first_name, s.last_name, a.address
  FROM staff s
  INNER JOIN address a
  ON (s.address_id = a.address_id);
-- Q6b


SELECT s.first_name, s.last_name, SUM(p.amount)
  FROM staff AS s
  INNER JOIN payment AS p
  ON p.staff_id = s.staff_id
  WHERE MONTH(p.payment_date) = 08 AND YEAR(p.payment_date) = 2005
  GROUP BY s.staff_id;
-- Q6c
SELECT f.title, COUNT(fa.actor_id) AS 'Actors'
  FROM film_actor AS fa
  INNER JOIN film as f
  ON f.film_id = fa.film_id
  GROUP BY f.title
  ORDER BY Actors desc;
  -- Q6d
SELECT title, COUNT(inventory_id) AS '# of copies'
  FROM film
  INNER JOIN inventory
  USING (film_id)
  WHERE title = 'Hunchback Impossible'
  GROUP BY title;
  
-- Q6e  
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount Paid'
  FROM payment AS p 
  JOIN customer AS c
  ON p.customer_id = c.customer_id
  GROUP BY c.customer_id
  ORDER BY c.last_name;
  -- Q7a
  
SELECT title
  FROM film
  WHERE title LIKE 'K%'
  OR title LIKE 'Q%'
  AND language_id IN
  (
   SELECT language_id
   FROM language
   WHERE name = 'English'
);
-- Q7b
sql
  SELECT first_name, last_name
  FROM actor 
  WHERE actor_id IN 
  (
    SELECT actor_id
    FROM film_actor
    WHERE film_id = 
    (
       SELECT film_id
       FROM film
       WHERE title = 'Alone Trip'
      )
   );

-- Q 7c
SELECT first_name, last_name, email, country
  FROM customer cus
  JOIN address a
  ON (cus.address_id = a.address_id)
  JOIN city cit
  ON (a.city_id = cit.city_id)
  JOIN country ctr
  ON (cit.country_id = ctr.country_id)
  WHERE ctr.country = 'canada';


-- Q7d
SELECT title, c.name
  FROM film f
  JOIN film_category fc
  ON (f.film_id = fc.film_id)
  JOIN category c
  ON (c.category_id = fc.category_id)
  WHERE name = 'family';
-- Q7e

  SELECT title, COUNT(title) as 'Rentals'
  FROM film
  JOIN inventory
  ON (film.film_id = inventory.film_id)
  JOIN rental
  ON (inventory.inventory_id = rental.inventory_id)
  GROUP by title
  ORDER BY rentals desc;

-- Q7f
SELECT s.store_id, SUM(amount) AS Gross
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (i.inventory_id = r.inventory_id)
  JOIN store s
  ON (s.store_id = i.store_id)
  GROUP BY s.store_id;
  
  -- Q7g
  SELECT store_id, city, country
  FROM store s
  JOIN address a
  ON (s.address_id = a.address_id)
  JOIN city cit
  ON (cit.city_id = a.city_id)
  JOIN country ctr
  ON(cit.country_id = ctr.country_id);
  
-- Q7h

SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (r.inventory_id = i.inventory_id)
  JOIN film_category fc
  ON (i.film_id = fc.film_id)
  JOIN category c
  ON (fc.category_id = c.category_id)
  GROUP BY c.name
  ORDER BY SUM(amount) DESC;
  
-- Q8a

CREATE VIEW top_five_genres AS
  SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
  FROM payment p
  JOIN rental r
  ON (p.rental_id = r.rental_id)
  JOIN inventory i
  ON (r.inventory_id = i.inventory_id)
  JOIN film_category fc
  ON (i.film_id = fc.film_id)
  JOIN category c
  ON (fc.category_id = c.category_id)
  GROUP BY c.name
  ORDER BY SUM(amount) DESC
  LIMIT 5;
-- Q8b

SELECT * 
  FROM sales_by_film_category;
-- Q8c

DROP VIEW top_five_genres;