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
)

-- Let's create more tables and link with foreign keys

-- Job Table

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
)

-- Account Job Table with Reference Keys

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
)
