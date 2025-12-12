-- This chapter investigates how to combine tables in out database with the use of "JOIN" statements.

-- "AS" Statement

-- This works as an alias for a column or result.
-- That is, we are choosing a column name to be display in the output.

-- Syntax:	SELECT column name AS new column name
--			FROM table name

-- Syntax:	SELECT SUM(column name) AS new column name
--			FROM table name

-- Example:

--	SELECT SUM(amount) AS net_revenue
--	FROM payment;

-- Note: "AS" operator gets executed at the very end of the query.
-- 		Thus, we cannot use the alias inside a WHERE operator.

SELECT COUNT(amount) AS num_transactions
FROM payment;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id;

-- "INNER JOIN"

-- JOINs allow us to combine multiple tables together.
-- Different Join types descide how to deal with information only present in one of the joined tables.

-- "INNER JOIN" will result with the set of records that match in both tables.

-- Syntax:	SELECT *
--			FROM table1 name
--			INNER JOIN table1 name ON table1 col.match =  table2 col.macth

-- Note: Repalce "*" with columns names we need to avoid duplication.

-- Join cutomer table with payment table. 

SELECT *
FROM payment;

SELECT *
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id;

-- When the table are combined, if we are referring to a column in only one table we do not need to mention tables name.
-- However, if the column name is in both tables, we have to mention the table name.

SELECT payment_id, payment.customer_id, first_name
FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id;

-- Note: Resulting table does not contain any information about a customer who never made a payment.

-- "OUTER JOINS"

-- This will allow us to specify how to deal with values only present in one of the tables being joined.

-- "FULL OUTER JOIN"

-- Here we grab all the columns of the tables and combine them.

-- Syntax:	SELECT * 
--			FROM TableA
--			FULL OUTER JOIN TableB ON TableA.col_match = TableB.col_match

-- FULL OUTER JOIN with WHERE

-- This will get rows unique to either table (rows not found in both tables).
-- This is opposite of INNER JOIN. (Here we are checking on the records unique to each table).

-- (New privacy policy)
-- Task: We do not need any payment infromation does not atatched to customer or any customer infromation attached to payment.

SELECT *
FROM payment;

SELECT *
FROM customer;

SELECT *
FROM customer
FULL OUTER JOIN payment ON customer.customer_id = payment.customer_id;

SELECT *
FROM customer
FULL OUTER JOIN payment ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null OR payment.payment_id IS null;

-- This will return a empty table. That is, we comply with the new privacy policy.

-- We can verify this by counting IDs:

SELECT COUNT(DISTINCT customer_id)
FROM payment;

-- 599

SELECT COUNT(DISTINCT customer_id)
FROM customer;

-- 599

-- However, this does not verify the privacy policy.

-- "LEFT OUTER JOIN" / "left JOIN"

-- This results in the set of records that are in the left tables, if there is no match with the right tables, the results are null.

-- Syntax:	SELECT *
--			FROM TableA
--			LEFT OUTER JOIN TableB ON TableA.col_match = TableB.col_match;

-- Note: Here the order of the tables matter. (All in TableA and match records in TableB)
-- Note: If the record is only in 'TableB', it will not report with the query.

-- "LEFT OUTER JOIN" with "WHERE"

-- This helps to get rows unique to the left table.

-- Syntax:	SELECT *
--			FROM TableA
--			LEFT OUTER JOIN TableB ON TableA.col_match = TableB.col_match
--			WHERE TableB.id IS NULL;

SELECT *
FROM film;

SELECT *
FROM inventory;

SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory ON inventory.film_id = film.film_id;

SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL;

-- This will give us list if film title that we have information but not avaiable in inventory.

-- "RIGHT JOIN"

-- This is very similar to "LEFT JOIN", except the tables are switched.
-- Note: We can simply switch TableA and TableB in "LEFT JOIN" and get same result.

-- "UNION" Operator

-- This operator is used to combine the result-set of two or more SELECT statements.
-- That is, concatenate two results together.

-- Syntax:	SELECT column_name(s) FROM table1
--			UNION
--			SELECT column_name(s) FROM table2

-- Note: Tables should match in order to stack them.

-- Note: We can also have multiple UNION statements.

-- Challenge 1: What are the emails of the cutomers who live in California?

SELECT *
FROM customer;

SELECT *
FROM address;

SELECT customer.email AS email_addresses
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
WHERE address.district = 'California';

-- Challenge 2: Get a list of all the movies 'Nick Wahlberg' has been in.

SELECT *
FROM film
LIMIT 5;

SELECT *
FROM film_actor
LIMIT 5;

SELECT *
FROM actor
LIMIT 5;

-- Connection: film <-> film_actor <-> actor

SELECT film_actor.film_id, film.title, actor.first_name, actor.last_name
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id
WHERE actor.first_name = 'Nick' AND actor.last_name = 'Wahlberg';
