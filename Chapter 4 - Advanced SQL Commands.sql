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
WHERE EXTRACT(dow FROM payment_date) = 1



