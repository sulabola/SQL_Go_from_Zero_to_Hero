-- This chapter investigate GROUP BY and aggregate functions
-- GROUP BY allow us to aggregate data and apply functions for better undestanding.
-- Aggregate functions takes multiple inputs and return a single output (AVG(), COUNT(), MAX(),...)
-- Aggregate function calls happen only in the "SELECT" or "HAVING" clause.

SELECT *
FROM film;

-- Task: Find the minimal replacement cost

SELECT MIN(replacement_cost)
FROM film;

-- Task: Find the maximum replacement cost

SELECT MAX(replacement_cost)
FROM film;

SELECT MIN(replacement_cost), MAX(replacement_cost)
FROM film;

-- Task: Average replacement cost

SELECT AVG(replacement_cost)
FROM film;

-- Note: Average by default keep so many decimal places. So we can use "ROUND" function.
-- "ROUND" function takes 2 arguments: value, # of decimal places

SELECT ROUND(AVG(replacement_cost),3)
FROM film;

-- Task: We start a new shop and need to replace all the movies. What is the replacement cost?

SELECT SUM(replacement_cost)
FROM film;

-- "GROUP BY" Statement

-- Allows to aggregate columns per some category.

-- Syntax:	SELECT category column, AGG(data column)
--			FROM table name
--			GROUP BY category column

-- "GROUP BY" appear right after "FROM"/"WHERE" statements.

-- Note: In the SELECT statement, columns must either have an aggregate functions or be in the GROUP BY call.

-- Example 1:

--	SELECT company, division, SUM(sales)
--	FROM finance_table
--	WHERE division IN ('marketing', 'transport')
--	GROUP BY company, division

-- Example 2:

--	SELECT company, SUM(sales)
--	FROM finance_table
--	GROUP BY company
--	ORDER BY SUM(sales)

SELECT *
FROM payment;

SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- Task: What customer is spending the most money?

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Task: Number of transactions per customer?

SELECT customer_id, COUNT(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount);

-- Group by two columns

SELECT customer_id, staff_id, SUM(amount)
FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id;

-- GROUP BY a date column (each group contain a day)

SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

-- Challenge 1: How many payments each staff member handle and who gets the bonus (max # of payments)

SELECT staff_id, COUNT(staff_id)
FROM payment
GROUP BY staff_id
ORDER BY COUNT(staff_id) DESC;

-- Challenge 2: What is the average replacement cost per MPAA rating?

SELECT *
FROM film;

SELECT rating, ROUND(AVG(replacement_cost),2)
FROM film
GROUP BY rating
ORDER BY AVG(replacement_cost);

-- Challenge 3: What are the customer IDs of the top 5 customers by total spend?

SELECT *
FROM payment

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

-- "HAVING" Clause

-- This allows us to filter after an aggregation has already taken place.

-- Example: 

--	SELECT company, SUM(sales)
--	FROM finance_table
--	GROUP BY company
--	HAVING SUM(sales) > 1000

SELECT *
FROM payment;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT *
FROM customer;

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

-- Challenge 1: What customers are eligible for platinum status (more than or equal 40 transactions)?

SELECT *
FROM payment;

SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 40;

-- Challenge 2: Customers who spend more than $100 with staff memeber 2.

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = '2'
GROUP BY customer_id
HAVING SUM(amount) > 100;
