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





