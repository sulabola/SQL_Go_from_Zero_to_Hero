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






