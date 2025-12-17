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







