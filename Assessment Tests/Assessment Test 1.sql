--  Assessment Test 1

-- Challenge 1: Return the cutomer IDs who have spent at least $110 with staff memeber 2.

SELECT *
FROM payment;

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = '2'
GROUP BY customer_id
HAVING SUM(amount) >= 110;

-- Challenge 2: How many films begin with the letter 'J'

SELECT *
FROM film;

SELECT COUNT(title)
FROM film
WHERE title LIKE'J%';

-- Challenge 3: What customer has the highest cutomer ID number whose name start with an 'E' 
-- and has an address ID lower than 500

SELECT *
FROM customer;

SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'E%' AND address_ID < 500
ORDER BY customer_id DESC
LIMIT 1;
