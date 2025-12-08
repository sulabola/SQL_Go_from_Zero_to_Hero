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









