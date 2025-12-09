-- Here, we are working as a database manager for a DVD rental shop.
-- In the database we have several tables (customer, actor, category,...)
-- Each table has several columns containing relavent information.

-- "SELECT" Statement

-- Syntax: SELECT column name(s) FROM table name;

SELECT * FROM actor;

SELECT first_name FROM actor;

SELECT first_name, last_name FROM actor;

SELECT last_name, first_name FROM actor;

-- Situation: Send a promotional email to our existing customers.
-- We need first name, last name, and customer email of every customer (from cutomer table)

SELECT * FROM customer;

SELECT first_name, last_name, email FROM customer;

-- "SELECT DISTINCT"

-- Sometimes a table contains a column that has duplicate values.
-- We may find in a sitiation where we only want to list the unique/distict values.

--  Syntax: SELECT DISTINCT column name(s) FROM table name

-- Note: We can use "column names" with/without paranthesis

SELECT * FROM film;

-- How many distict values we have for relase year column (categorical variable)

SELECT DISTINCT (release_year) FROM film;

SELECT DISTINCT release_year FROM film; -- solution: 2006

-- We also have different rental rates (numerical variable)

SELECT DISTINCT rental_rate FROM film;

-- Situation: A visitor is not familiar with MPAA ratings (PG, PG-13,...)
-- We want to know types of ratings we have in our database.
-- What ratings available.

SELECT * FROM film;

SELECT DISTINCT rating FROM film;

-- "COUNT" function

-- This function returns the number of inputs rows that matches a specific condition of a query.
-- Note: Can be applied to a column/table, as it will be counting rows.
-- This is more usefull when combine with other commands.

-- Syntanx:	SELECT COUNT(DISTINCT column name)
--			FROM table name			

SELECT * FROM payment; -- Total rows = 14596

SELECT COUNT(*) FROM payment;

SELECT COUNT(amount) FROM payment;

-- Question: How many unique amounts been paid?

SELECT COUNT(DISTINCT amount) FROM payment;

-- "SELECT WHERE" Statement

-- "WHERE" statement alows us to specify conditions on columns for the rows to be returned.

-- Syntax:	SELECT column name(s)
--			FROM table name
--			WHERE conditions;

-- We have variety of standard operators to construct the conditions.

-- Comparison Operators (=, >, <, >=, <=, <>, !=)
-- Logical Operators (AND, OR, NOT)

SELECT * FROM customer;

-- Task: Who has customer name "Jared"?

SELECT *
FROM customer
WHERE first_name = 'Jared';

-- Example: Combine logical operators

SELECT * FROM film;

-- Task: Find rental rates higher than $4.00.

SELECT *
FROM film
WHERE rental_rate > 4;

-- Task: Find rental rates higher than $4.00 and expensive to replace.

SELECT *
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99;

SELECT *
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';

SELECT title
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';

-- Let's assume we want to know how many titles are there which satisfies all these conditions.

SELECT COUNT(title)
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';

-- Alternatively:

SELECT COUNT(*)
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating = 'R';

-- Task: Movies with "R" or "PG-13" ratings.

SELECT COUNT(*)
FROM film
WHERE rating = 'R' OR rating = 'PG-13';

-- Everything is not "R" rated.

SELECT COUNT(*)
FROM film
WHERE rating != 'R';

-- Challenge 1: Need to find the email of a particular customer (Nancy Thomas).

SELECT email
FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- Challenge 2: Get the desciption of a particular movie (Outlaw Hanky)

SELECT description
FROM film
WHERE title = 'Outlaw Hanky'

-- Challenge 3: Get the phone number of a customer based on the address (259 Ipoh Drive)

SELECT phone
FROM address
WHERE address = '259 Ipoh Drive'

-- "ORDER BY" Statement

-- This allow user to sort rows based on a column value (ascending/descending)

-- Syntax:	SELECT column names(s)
--			FROM table name
--			ORDER BY column name ASC/DESC

-- Note: We can use ORDER BY with multiple columns

SELECT * FROM customer;

-- Order everything by the customer first name

SELECT *
FROM customer
ORDER BY first_name ASC; -- (automatically ASC order)

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id, first_name ASC;

-- Note: We can add ASC/DESC for each column

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id ASC, first_name DESC;

-- "LIMIT" Statement

-- This limits the number of rows returned for a query. (useful to get idea about the table layout)
-- This would be the last command to be executed.

SELECT * FROM payment;

-- Investigate oldest and most recent payments

SELECT *
FROM payment
ORDER BY payment_date DESC;

-- Task: What are the 5 most recent payments?

SELECT *
FROM payment
ORDER BY payment_date DESC
LIMIT 5;

-- We can see that for some payments, the payment amony is 0.
-- Let's view 10 most recent payments with non-zero payments.

SELECT *
FROM payment
WHERE amount != 0
ORDER BY payment_date DESC
LIMIT 5;

-- Challenge 1: What are the customer IDs of the first 10 who created a payment?

SELECT customer_id
FROM payment
ORDER BY payment_date ASC
LIMIT 10;

-- Challenge 2: What are the titles of 5 shortest (in length of runtime) movies?

SELECT *
FROM film
LIMIT 5;

SELECT title, length
FROM film
ORDER BY length ASC
LIMIT 5;











