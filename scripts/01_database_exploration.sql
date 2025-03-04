/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Query 1: Retrieve a list of all tables in the database
-- This query retrieves information about all tables present in the database, including their schema and type
SELECT 
    TABLE_CATALOG,   -- The catalog (database) in which the table resides
    TABLE_SCHEMA,    -- The schema to which the table belongs (e.g., 'gold', 'dbo')
    TABLE_NAME,      -- The name of the table
    TABLE_TYPE       -- The type of the table (e.g., 'BASE TABLE' for regular tables)
FROM INFORMATION_SCHEMA.TABLES;   -- This is a system view that contains metadata about all tables in the database

-- Query 2: Retrieve all columns for a specific table (dim_customers)
-- This query retrieves metadata about the columns in the 'dim_customers' table, including data types, nullability, and maximum length
SELECT 
    COLUMN_NAME,              -- The name of the column in the table
    DATA_TYPE,                -- The data type of the column (e.g., 'VARCHAR', 'INT')
    IS_NULLABLE,              -- Indicates if the column allows NULL values ('YES' or 'NO')
    CHARACTER_MAXIMUM_LENGTH  -- The maximum length for character-based columns (e.g., VARCHAR, CHAR). NULL if not applicable
FROM INFORMATION_SCHEMA.COLUMNS  -- This is a system view that contains metadata about all columns in the database
WHERE TABLE_NAME = 'dim_customers';  -- Filters the results to only show columns from the 'dim_customers' table
