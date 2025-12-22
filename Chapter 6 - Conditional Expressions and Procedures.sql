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

-- "COALESCE" Function

-- This functions accepts an unlimited number of arguments.
-- It returns the first argument that is not null.
-- If all arguments are null, the function will return null.

-- Syntax:	COALESCE(arg1, arg2, ...)

-- Note: Typically areguments are for columns.

-- This function is useful when querying a table that contains null values and substituting it with another value.

-- Example: Let we have the price of items and discount.
-- For one of the product, discount is null.
-- If we calculate the final price (price-discount) in usual way, it may fails and show 'null'
-- This can be addressed with COALESCE

--	SELECT item, (price - COALESCE(discount,0)) AS final
--	FROM table

-- Note: This function is usefull when we have to perform oprations with null values. Not to change them.

-- "CAST" Operator and Function

-- This allows us to convert one data type inot another.
-- However, this does not work always. It should be reasonable to convert the data.
-- Example: String 5 to number 5 works. String five to number 5 will not work.

-- There are two ways to perform this:

-- 1. CAST function:
-- SELECT CAST('5' AS INTEGER)

-- 2. CAST operator: (In PorstgreSQL ONLY)
-- SELECT '5'::INTEGER

-- Note: In most cases we will be doing this for a column, not a single value.

SELECT CAST('5' AS INTEGER) AS new_int;

SELECT '5'::INTEGER;

-- Task: What is the character length (number of digits) of inventory_id

SELECT *
FROM rental;

SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental;

-- "NULLIF"

-- This takes in 2 inputs and returns NULL if both are equal, otherwise it returns the first argument passed.

-- Example:
-- NULLIF(10,10);
-- This retunrs NULL

-- NULLIF(10,12);
-- This returns 10

-- This is useful in cases where a NULL value would cause an error or unwanted result.

-- We test this with a new table created in a seperate database ('testme').

CREATE TABLE depts(
	first_name VARCHAR(50),
	department VARCHAR(50)
);

INSERT INTO depts(first_name, department)
VALUES
	('Vinton','A'),
	('Lauren','A'),
	('Claire','B');

SELECT *
FROM depts;

-- Task: Calculate male and female members.

SELECT 
	(SUM(CASE 
			WHEN department = 'A' THEN 1
			ELSE 0
		END))/
	(SUM(CASE
			WHEN department = 'B' THEN 1
			ELSE 0
		END)) AS department_ratio
FROM depts;

-- Here we should get 2 as there are two 'A'.

-- Let's see what happen when there is nobody in department B.

DELETE FROM depts
WHERE department = 'B';

SELECT *
FROM depts;

-- Now if we try the above code, we will get an ERROR as we are deviding a number by zero.
-- We can use NULLIF to fix this.

SELECT 
	(SUM(CASE 
			WHEN department = 'A' THEN 1
			ELSE 0
		END))/
	NULLIF(	
	(SUM(CASE
			WHEN department = 'B' THEN 1
			ELSE 0
		END)),0) AS department_ratio
FROM depts;

-- "VIEWS"

-- Oftern there are specific combinations of tables and conditions that we find useful.
-- Instead of having to perform the same query over and over again,
-- we can create a VIEW to see this query with a simple call.

-- Thus, a view is a database object that is of a stored query.
-- A view can be accessed as a virtual table in PostgreSQL.
-- Note that a view does not store data, it simply stores the query.

-- We can also update andalter existing views.

-- Task: Let's assume we constantly need to check customer names and their addresses.

SELECT *
FROM customer;

SELECT *
FROM address;

-- In customer table we have address_id, and in address table we have addresses.

SELECT first_name, last_name, address
FROM  customer
INNER JOIN address ON customer.address_id = address.address_id;

-- Let's save this query for future use.

CREATE VIEW customer_info AS
SELECT first_name, last_name, address
FROM  customer
INNER JOIN address ON customer.address_id = address.address_id;

-- Now:

SELECT *
FROM customer_info;

-- Let's modify this query. We will use CREATE or REPLACE commands.

CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district
FROM  customer
INNER JOIN address ON customer.address_id = address.address_id;

SELECT *
FROM customer_info;

-- We can also chnage the name of a view.

ALTER VIEW customer_info RENAME TO c_info;

SELECT *
FROM c_info;

-- We can also remove a view. It is similar to delete a table.

DROP VIEW IF EXISTS c_info;

-- Importing and Exporting Data



