-- This chapter covers deatils of creating Databases and Tables.

-- "Data Types"

-- When creating databases and tables, datatypes are important.
-- It determines what type of data that each column should hold.

-- The main data types inlcude: Boolean, Character, Numeric, Temporal (date/time/timestamp/interval)

-- Let's assume we want to save phone numbers? Should we save them as numeric?
-- If Yes, what type of numeric (smallint/integer, bigint,...)
-- Different options allow us to save different size numbers (allow more storage).

-- An intresting question should be, why bother with numerics. We do not perform arithemetic with phone numbers.
-- Thus, it would be more sense to save them as VARCHAR data type.
-- (We can Google best practices for different types of data).
-- As we creating databases and tables, we should plan for long term storage.

-- "Primary Keys and Foreign Keys"

-- These are primary concepts when creating tables in a database.

-- Primary key: A column or a group of columns used to identify a row uniquely in a table.
-- This is also important when joining the tables.
-- The Primary key in a table is denoted by "[PK]" notation.

-- Foreign key: A firld or group of fields in a table that uniquely identifies a row in another table.
-- A foreign key is defined in a table that references to the primary key of the other table.
-- The tabel that conatins the foreign key is called referecing table/child table.
-- A table can have multiple foreign keys.
-- Note: We would not see a notation ("[FK]") for foreign keys.

-- "Constraints"

-- These are the rules enforced on data columns on table.
-- These prevent invalid data from being entered into the database.
-- Constraints are devided into 2 main categories: Column contraints and Table constraints
-- Column contraints: Constraints apply to a column.
-- Table constraints: Constraints applied to the entire table.

-- Common constraints:

-- Column constraints:
-- NOT NULL: Ensures that a column cannot have a NULL value.
-- UNIQUE: Ensures that all values in a column are different.
-- Primary Key
-- Foreign Key
-- CHECK: Ensures that all values ina column satify certain conditions (e.g., less than 20)
-- EXCLUSION: Ensures that if any two rows are compared on the specified column/expression using the specified
--				operator, not all of these comparisons will return TRUE.

-- Table constraints:
-- CHECK (condition): Check a condition when inserting or updating data.
-- REFERENCES: Constrain the value stored in the column that must exist in a column in another table.
-- UNIQUE (column_list): Forces the values stored in the columns listed inside the parentheses to be unique.
-- PRIMARY KEY (column_list): Primary key on multiple columns.

-- CREATE Table

-- Syntax:	CREATE TABLE table_name(
--			column_name TYPE column_constraint,
--			column_name TYPE column_constraint,
--			..,
--			table_constraint table_constraint
--			) INHERITS existing_table_name;

-- Let's first focus on creating tables and adding columns.

-- When creating a primary id, in most cases data type is "SERIAL".
-- This is because it has some nice properties.
-- In PostgreSQL, a sequence is a special kind of database object that generates a sequence of integers.
-- And it will be use as a primary key.
-- If a a row is later removed, the column with SERIAL data type will not adjust.

-- Create first table:
-- Note: Maximum charactors for a username is 50.
-- Note: No "NOT NULL" for last_loging. Example: If you have just created an account, no information about last login.

CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

-- Let's create more tables and link with foreign keys

-- Job Table

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

-- Account Job Table with Reference Keys

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);

-- "INSERT" Command

-- INSERT allows to add in rows to a table

-- Syntax:	INSERT INTO table(column1, column2,...)
--			VALUES
--				(value1, value2,...),
--				(value1, value2,...),
--				...;

-- We can also insert values from another table.

-- Syntax:	INSERT INTO table(column1, column2,...)
--			SELECT column1, column2,...
--			FROM another_table
--			WHERE condition;

-- Note: When inserting data from another dable, the datatype should match.

-- Let's insert value to account table

SELECT *
FROM account;

-- Note: user_id is SERIAL, so we do not need to worry about the values.
-- Note: There are not conditions on last_loging. Thus, we do not need to provide it.

INSERT INTO account(username, password, email, created_on)
VALUES
	('Jose','password','jose@mail.com',CURRENT_TIMESTAMP);

SELECT *
FROM account;

-- Insert data into job table

INSERT INTO job(job_name)
VALUES
	('Astronaut');

SELECT *
FROM job;

INSERT INTO job(job_name)
VALUES
	('President');

SELECT *
FROM job;

INSERT INTO account_job(user_id, job_id, hire_date)
VALUES
	(1, 1, CURRENT_TIMESTAMP);

SELECT *
FROM account_job;

--INSERT INTO account_job(user_id, job_id, hire_date)
--VALUES
--	(10, 10, CURRENT_TIMESTAMP);

-- Note: The above code will give us an error. This is becase "user_id" is a foreign key and the value 10 does not exists.

-- "UPDATE" Keyword

-- This allows for the changing of values of the columns in a table.

-- Syntax:	UPDATE table
--			SET column1 = value1,
--				column2 = value2,
--				...
--			WHERE
--				condition;

-- Example: update the account table. If the last loggin is empty, replace it with current time stamp

--	UPDATE account
--	SET last_login = CURRENT_TIMESTAMP
--	WHERE last_login IS NULL;

-- We can also resent everything without WHERE condition.

--	UPDATE account
--	SET last_login = CURRENT_TIMESTAMP;

-- Note: this will update all the entries.

-- We can also set everything based on another column. (If needed we can add WHERE condition)

--	UPDATE account
--	SET last_login = created_on;

-- We can update entries based on another table's values (UPDATE join)

--	UPDATE TableA
--	SET original_col = TableB.new_col
--	FROM TableB
--	WHERE TableA.id = TableB.id;

-- The above updates do not return the updated tables. However, we can view the affected rows.

-- Syntax:	UPDATE account
--			SET last_login = created_on
--			RETURNING account_id, last_login;

SELECT *
FROM account;

-- Note: last_login is null. We trye to update that next.

-- With current time stamp
UPDATE account
SET last_login = CURRENT_TIMESTAMP;

SELECT *
FROM account;

-- with created_on

UPDATE account
SET last_login = created_on;

SELECT *
FROM account;

-- Updates based on two tables.

-- Change hire date in account_job table based on another column

UPDATE account_job
SET hire_date = account.created_on
FROM account
WHERE account_job.user_id = account.user_id;

SELECT *
FROM account_job;

-- Reset account table entries

UPDATE account
SET last_login = CURRENT_TIMESTAMP
RETURNING email, created_on, last_login;

-- "DELETE" Clause

-- We can use this to remove rows from a table.

-- Example:	DELETE FROM table
--			WHERE row_id = 1;

-- We can also delete rows based on their prsence in other tables

-- Example:	DELETE FROM tableA
--			USING tableB
--			WHERE tableA.id = tableB.id;

-- We can also delete all rows from a table

-- Syntax: DELETE FROM table

-- Here also we can view  which rows have been removed.

SELECT *
FROM job;

-- Will add a new job and remove it.

INSERT INTO job(job_name)
VALUES
	('Cowboy');

SELECT *
FROM job;

DELETE FROM job
WHERE job_name = 'Cowboy'
RETURNING job_id, job_name;

SELECT *
FROM job;

-- "ALTER" Clause

-- This allow for changes to an existing table structure
-- add/drop/rename columns, chnage data type, set default values, check constraints, rename tables

-- General syntax:	ALTER TABLE table_name action

-- Adding columns:

-- Syntax:	ALTER TABLE table_name
--			ADD COLUMN new_col TYPE;

-- Remove columns:

-- Syntax:	ALTER TABLE table_name
--			DROP COLUMN col_name;

-- ALTER constraints:

--Syntax:	ALTER TABLE table_name
--			ALTER COLUMN col_name
--			SET DEFAULT value / DROP DEFAULT / SET NOT NULL / DROP NOT NULL / ADD CONSTRAINTS constaint_name;

-- Now we text these commands with a newely created table.

CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
);

SELECT *
FROM information;

-- Rename the table

ALTER TABLE information
RENAME TO new_info;

SELECT *
FROM new_info;

-- Rename a column

ALTER TABLE new_info
RENAME COLUMN person TO people;

SELECT *
FROM new_info;

-- Alter constraints
-- First we try entering the data

--	INSERT INTO new_info(title)
--	VALUES
--		('some new title')

-- The above code will give an error. Because "people" cannot be null. Thus, we alter the constraint.

ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;

-- Now try:

INSERT INTO new_info(title)
VALUES
	('some new title');

SELECT *
FROM new_info;

-- "DROP" Keyword

-- DROP allow us to completly remove column in a table.
-- In postgreSQL, this will automatically remove indexes and constraints involving the column.
-- It will not remove column with dependecies without additional "CASCADE" clause.

-- General syntax:	ALTER TABLE table_name
--					DROP COLUMN col_name;

-- Remove all dependecies:

-- Syntax:	ALTER TABLE table_name
--			DROP COLUMN col_name CASCADE;

-- Check for existence to avoid error

-- Syntax:	ALTER TABLE table_name
--			DROP COLUMN IF EXISTS col_name;

-- We can also frop multiple columns:

-- Syntax:	ALTER TABLE table_name
--			DROP COLUMN col_one,
--			DROP COLUMN col_two;

SELECT *
FROM new_info;

-- Drop people column

ALTER TABLE new_info
DROP COLUMN people;

SELECT *
FROM new_info;

ALTER TABLE new_info
DROP COLUMN IF EXISTS people;

-- "CHECK" Constraints

-- This allow us to create more customized constraints that adhere to a certain condition.
-- E.g., Make sure all inserted integer values fall below a certain threshold.

-- General syntax:	CREATE TABLE example(
--					ex_d SERIAL PRIMARY KEY,
--					age SMALLINT CHECK (age > 21),
--					parent_age SMALLINT CHECK (parent_age > age)
--					);

CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1900-01-01'),
	hire_date DATE CHECK (hire_date > birthdate),
	salary INTEGER CHECK (salary > 0)
);

-- Let's Insert some data to employees table

INSERT INTO employees(first_name, last_name, birthdate, hire_date, salary)
VALUES
	('Sula', 'Bola', '1990-11-03', '2010-01-01', 100),
	('Sammy', 'Smith', '1990-11-03', '2010-01-01', 100);

SELECT *
FROM employees;

-- Note: SERIAL kept the count of failure attemps (birthdate: 1899-01-01, salary: -100)
-- emp_id are not consecutive.
