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

