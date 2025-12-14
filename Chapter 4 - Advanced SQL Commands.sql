-- This chapter covers several important and useful topic in SQL.

-- Timestamps and EXTRACT
-- Math Functions
-- String Functions
-- Sub-query (query within a query)
-- Self-Join

-- "Timestamps and EXTRACT"

-- First we focus on displaying current time information.
-- These are more usefull when we are creating own tables and databases.

-- There are different subsets of datatypes that hold date and time information:

-- TIME: Contain only time
-- DATE: Contain only date
-- TIMESTAMP: Contain date and time
-- TIMESTAMPTS: Contain date, time, and timezone

-- Note: We may chooose the datatype carefully when designing tables and databases depending on the situation.

-- Task: Current timezone

SHOW ALL

-- This shows names and settings of number of parameters (about 300). 

SHOW TIMEZONE

-- This shows the timezone of the computer (you are working with).

SELECT NOW()

-- This gives the current timestamp information.

SELECT TIMEOFDAY()

-- This is for easy reading.

SELECT CURRENT_TIME

SELECT CURRENT_DATE

-- Now we focus on extracting information from a time based data type and formatting it.

-- "EXTRACT()"

-- This allow us to extract or obtain a sub-component of a data value (year, month, day, week, quarter).

-- Syntax: EXTRACT(YEAR FROM date_column)

-- "AGE()"

-- This calculates and returns the current age given a timestamp.

-- Syntax: AGE(date_column)

-- "TO_CHAR()"

-- This is a general function to convert data types to a text.

-- Syntax/usage: TO_CHAR(date_column, 'mm-dd-yyyy')

SELECT *
FROM payment;

SELECT EXTRACT(YEAR FROM payment_date)
FROM payment;

-- It is usfull to use this with a alias

SELECT EXTRACT(YEAR FROM payment_date) AS payment_year
FROM payment;

SELECT EXTRACT(MONTH FROM payment_date) AS payment_month
FROM payment

SELECT AGE(payment_date)
FROM payment;

SELECT TO_CHAR(payment_date, 'MONTH-YYYY')
FROM payment;

-- Note: We can select different output styles for TO_CHAR. Check online sources.
-- Note: Instead of "-", we can also use spaces.

SELECT TO_CHAR(payment_date, 'MONTH  YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'mon/dd/YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'MM/dd/YYYY')
FROM payment;

-- Challenge 1: During which months did the payments occur? Return full month name.

SELECT *
FROM payment;

SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH'))
FROM payment;

-- Challenge 2: How may payments occured on a Monday?

SELECT DISTINCT(TO_CHAR(payment_date, 'Day')), COUNT(TO_CHAR(payment_date, 'day'))
FROM payment
GROUP BY TO_CHAR(payment_date, 'Day')
ORDER BY COUNT(TO_CHAR(payment_date, 'day')) DESC
LIMIT 1;

-- Alternative apporach:

SELECT COUNT(*)
FROM payment
WHERE EXTRACT(dow FROM payment_date) = 1;

-- "Mathematical Functions"

-- We can perform basic and complex mathematical functions (+, -, /,...) and (abs(), log(), sqrt(),...)

SELECT *
FROM film;

-- Task: Percentage of the rental rate as of the replacement cost.

SELECT ROUND(rental_rate/replacement_cost,2)*100 AS percent_cost
FROM film;

SELECT 0.1*replacement_cost AS deposit
FROM film;

-- "String Functions and Operations"

-- This allow us to edit, combine, and alter text data columns.

SELECT *
FROM customer;

-- Task: Length of the first name.

SELECT LENGTH(first_name)
FROM customer;

-- Task: Combine first name and last name.

SELECT first_name || last_name
FROM customer;

-- Note: No space between first name and last name. Also, no column name.

-- Add a space between first name and last name.

SELECT first_name || ' ' || last_name
FROM customer;

SELECT first_name || ' ' || last_name AS full_name
FROM customer;

-- Further modify the output (upper case letters).

SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer;

-- Task: Let's assume we do not have email for customers and we want to create email for them.
-- We will use first letter of the first name and last name to create the email.

SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com' AS customer_email
FROM customer;

-- "SubQuery"

-- Here we investigate how to perform subquery as well as the EXISTS functions.

--Task: Get list of studnets who scored better than the average grade.

-- Syntax:	SELECT student, grade
--			FROM test_scores
--			WHERE grade > (SELECT AVG(grade)
--			FROM test_scores)

-- The query in the paranthesis is performed first.

-- A subquery can be operate on a seperate table:

--	SELECT student, grade
--	FROM test_scores
--	WHERE student IN 
-- 	(SELECT student
--	FROM honor_roll_table)

-- "EXISTS" Operator

-- This is used to test for existance of rows in a subquery.

-- Syntax:	SELECT column_name
--			FROM table_name
--			WHERE EXISTS
--			(SELECT column_name
--			FROM table_name
--			WHERE condition);

SELECT *
FROM film;

-- Task: Find the films for which rental rate is higher than average rental rate.

-- Note: Somtimes it is easy to start with the subquery.

SELECT title, rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate)
FROM film);

-- Now let's trya subquery with a JOIN

SELECT *
FROM rental;

SELECT *
FROM inventory;

-- Task: Grab film titles that are retuned during a chosen dates.

SELECT *
FROM rental
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';

-- Note that the film ID is not there in the rental table.
-- However, inventory ID is there and it is connected to film ID.

SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';

SELECT film_id, title
FROM film
WHERE film_id IN
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30');

-- Task: Find a customer (fist and last names) who have at least one payment that is greater than 11.

SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS
(SELECT *
FROM payment AS p
WHERE p.customer_id = c.customer_id AND amount > 11);

-- We can also easily find customers paid less than or equal to 11 with "NOT EXISTS".

SELECT first_name, last_name
FROM customer AS c
WHERE NOT EXISTS
(SELECT *
FROM payment AS p
WHERE p.customer_id = c.customer_id AND amount > 11);

-- "SELF-JOIN"

-- This is a query in which a table is joined to itself.
-- It is usefull for comparing values in a column of a rows within the same table.
-- There are no special keyword for a self join. It is simply standard JOIN syntax with the same table in both parts.
-- Here it is necessary to use an alias for the table. Otherwise the table names would be ambiguous.

-- Syntax:	SELECT tableA.col, tableB.com
--			FROM table AS tableA
--			JOIN table AS tableB ON tableA.some_col = tableB.other_col;

-- Task: Find all the pairs of movies which have same length.

SELECT *
FROM film;

SELECT title
FROM film
WHERE length = 117;

SELECT f1.title, f2.title, f1.length
FROM film AS f1
INNER JOIN film as f2 ON f1.film_id != f2.film_id AND f1.length = f2.length;
