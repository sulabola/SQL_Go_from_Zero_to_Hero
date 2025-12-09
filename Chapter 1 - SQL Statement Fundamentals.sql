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

-- Challenge 3: If a customer can watch any movie that is 50 minutes or less, how many options customer have?

SELECT COUNT(title)
FROM film
WHERE length <= 50

-- "BETWEEN" Command

-- This operator can be used to match a value against a range of values.
-- This is same as checking a value >= LOW AND value <= HIGH (including the end points).
-- We can combine the "BETWEEN" with "NOT" logical operator. That is, value < LOW OR > HIGH.
-- This can be used with dates. But it needs to be in the ISO 8601 format (YYYY-MM-DD).

SELECT *
FROM payment
LIMIT 2;

-- Task: Number of payments between $8 and $9

SELECT COUNT(*)
FROM payment
WHERE amount BETWEEN 8 and 9;

-- Task: Number of payments NOT between $8 and $9

SELECT COUNT(*)
FROM payment
WHERE amount NOT BETWEEN 8 and 9;

-- Task: The payments during the first half of February

SELECT *
FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- "IN" Operator

-- This is useful when we want to check formultiple possible value options.
-- E.g., name = John, name = Max, name = Karl, ...

-- Syntax: WHERE value IN (option1. option2, option3, ...)

-- We can also use this with "NOT" logical operator: WHERE value NOT IN (option1. option2, option3, ...)

SELECT *
FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

-- Task: How may payments have ocuured with 0.99, 1.98, and 1.99?

SELECT COUNT(*)
FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

-- Task: How may payments have NOT ocuured with 0.99, 1.98, and 1.99?

SELECT COUNT(*)
FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99);

-- Task: Select customers: 'John', 'Jake', 'Julie'

SELECT *
FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');

-- "LIKE" and "ILIKE" Commands

-- In the previous command, we perform direct comparisons.
-- What if we want to match against a general pattern in a string.
-- E.g., emails ending in "@gmail.com", names begin with an "A"

-- "LIKE" allows pattern matching againts string data with the use of 'wildcard' characters.
-- wildcard 1: "%" - matches any sequence of characters
-- wildcard 2: "_" - matches any single character

-- All names that begin with an "A": WHERE name LIKE 'A%'
-- All names end with an "a": WHERE name LIKE '%a'

-- Note: "LIKE" is case-sensitive. "ILIKE" is case-insensitive.

-- "_" alows us to repalce a single character
-- Get Mission Impossible films: WHERE title LIKE 'Mission Impossible _'

-- We can also use multiple underscores.
-- If we had different versions: 'Version#A4' "Version#B7"
-- WHERE value LIKE 'Version#__'

-- We can also combine both. WHERE name LIKE '_her%'. Result: Cheryl, Theresa, Sherri,...

-- Task: How many people start their first name with letter 'J'

SELECT COUNT(*)
FROM customer
WHERE first_name LIKE 'J%';

-- Task: How many people start their first name with 'J' and last name with 'S'

SELECT COUNT(*)
FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

-- Case-insensitive

SELECT COUNT(*)
FROM customer
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%';

SELECT first_name
FROM customer
WHERE first_name LIKE '_her%';

SELECT *
FROM customer
WHERE first_name LIKE 'A%'
ORDER BY last_name;

SELECT *
FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;

-- General challenge 1
-- How many payment transactions were greater than $5

SELECT COUNT(amount)
FROM payment
WHERE amount > 5;

-- General challenge 2
-- How many actors have a first name that starts with the letter 'P'

SELECT COUNT(*)
FROM actor
WHERE first_name LIKE 'P%';

-- General challenge 3
-- How many unique districts are our customers from

SELECT COUNT(DISTINCT district)
FROM address;

-- General challenge 4
-- List of names of the unique districts

SELECT DISTINCT (district)
FROM address;

-- General challenge 5
-- How many films have a rating of R and a replacement cost between $5 and $15

SELECT *
FROM film
LIMIT 10;

SELECT COUNT(*)
FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

-- General challenge 6
-- How many films have the word Truma somewhere in the title

SELECT COUNT(title)
FROM film
WHERE title LIKE '%Truman%';

