-- This chapter covers Conditional Expressions and Procedures

-- Here we focus on applying logical operators and functionality within the SQL code.
-- We will learn key words: CASE, COALESCE, NULLIF, CASR, Views, Import and Export functionality

-- "CASE" Statement

-- We can use the CASE statement to only execute SQL code when certain conditions are met.
-- Thus, it is similar to IF/ELSE statements in other programming languages.

-- There are two ways to use this:
-- 1. General CASE statement
-- 2. CASE expression

-- Note: Both methods may lead to same results.

-- General syntax:	CASE
--						WHEN condition1 THEN result1
--						WHEN condition2 THEN result2
--						ELSE some_other_result
--					END

-- CASE expression:
-- Note that eventhought this looks similar, here first evaluates an expression 
-- then compares the result with each value in the WHEN clauses sequentially.

-- Syntax:	CASE expression
--				WHEN value1 THEN result1
--				WHEN value2 THEN result2
--				ELSE some_other_result
--			END

SELECT *
FROM customer;

-- Let's assume customer_id is added as SERIAL (that is customer_id = 1 for the frist customer)

-- Now we try to run a promotion for diffrent tiers.
-- 0 to 100: Premium status
-- 101 to 200: Plus status
-- the rest: normal customer

SELECT customer_id
FROM customer;

-- Note: We can add the CASE considering it as the next column

SELECT customer_id, 
	CASE
		WHEN (customer_id <= 100) THEN 'Premium'
		WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
		ELSE 'Normal'
	END
FROM customer;

-- When can also add an alias

SELECT customer_id, 
	CASE
		WHEN (customer_id <= 100) THEN 'Premium'
		WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
		ELSE 'Normal'
	END AS customer_class
FROM customer;

-- Note: General syntax is more flexible.

-- Let's say we are running a raffle based on customer id
-- Here, CASE expression is more relavent (we are checking a quality. Not flexible as the general syntax)

SELECT customer_id,
	CASE customer_id
		WHEN 2 THEN 'Winner'
		WHEN 5 THEN 'Second Place'
		ELSE 'Normal'
	END AS raffle_result
FROM customer;

-- Now we can perform operations on the results of this case statements.

SELECT *
FROM film;

-- Here we focus on rental rate. How many categories are there and count under each category.

SELECT rental_rate,
	CASE rental_rate
		WHEN 0.99 THEN 1
		ELSE 0
	END
FROM film;

-- To count number of cases where renatl rate is 0.99, we can add 1s in case column.

SELECT
	SUM(CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS number_of_bargains
FROM film;

-- Movies with a rental rate of 2.99

SELECT
	SUM(CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS bargains,
	SUM(CASE rental_rate
			WHEN 2.99 THEN 1
			ELSE 0
		END) AS regular
FROM film;

-- Pros to the previous methods we use (GROUP BY, HAVING), we can do this for other cases.

SELECT
	SUM(CASE rental_rate
			WHEN 0.99 THEN 1
			ELSE 0
		END) AS bargains,
	SUM(CASE rental_rate
			WHEN 2.99 THEN 1
			ELSE 0
		END) AS regular,
	SUM(CASE rental_rate
			WHEN 4.99 THEN 1
			ELSE 0
		END) AS premium
FROM film;

-- Challenge: We want to know and compare the various amount of films we have per movie rating.

SELECT *
FROM film;

SELECT DISTINCT(rating)
FROM film;

SELECT
	SUM(CASE rating
			WHEN 'R' THEN 1
			ELSE 0
		END) AS R,
	SUM(CASE rating
			WHEN 'PG' THEN 1
			ELSE 0
		END) AS PG,
	SUM(CASE rating
			WHEN 'PG-13' THEN 1
			ELSE 0
		END) AS PG13
FROM film;

