/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold.
    
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Switch to the master database to ensure we can perform operations on system-level objects
USE master;
GO

-- Drop and recreate the 'DataWarehouseAnalytics' database if it already exists
-- This checks if the 'DataWarehouseAnalytics' database exists, and if it does, it drops the database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouseAnalytics')
BEGIN
    -- Set the database to SINGLE_USER mode to prevent any other connections and immediately rollback any active transactions
    ALTER DATABASE DataWarehouseAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    
    -- Drop the database if it exists
    DROP DATABASE DataWarehouseAnalytics;
END;
GO

-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;
GO

-- Switch to the newly created database 'DataWarehouseAnalytics'
USE DataWarehouseAnalytics;
GO

-- Create the 'gold' schema for storing the core tables
CREATE SCHEMA gold;
GO

-- Create the 'dim_customers' table to store customer dimension data
CREATE TABLE gold.dim_customers(
    customer_key int,               -- Unique customer identifier
    customer_id int,                -- A customer identifier for reference
    customer_number nvarchar(50),   -- Customer's unique number
    first_name nvarchar(50),        -- Customer's first name
    last_name nvarchar(50),         -- Customer's last name
    country nvarchar(50),           -- Country of the customer
    marital_status nvarchar(50),    -- Customer's marital status
    gender nvarchar(50),            -- Customer's gender
    birthdate date,                 -- Customer's birthdate
    create_date date                -- Date when the customer was created/added
);
GO

-- Create the 'dim_products' table to store product dimension data
CREATE TABLE gold.dim_products(
    product_key int,                -- Unique product identifier
    product_id int,                 -- Product identifier for reference
    product_number nvarchar(50),    -- Product number
    product_name nvarchar(50),      -- Name of the product
    category_id nvarchar(50),       -- Product category identifier
    category nvarchar(50),          -- Category of the product
    subcategory nvarchar(50),       -- Subcategory of the product
    maintenance nvarchar(50),       -- Maintenance status or info for the product
    cost int,                       -- Product cost
    product_line nvarchar(50),      -- Product line or series
    start_date date                 -- Start date for the product's availability
);
GO

-- Create the 'fact_sales' table to store sales fact data
CREATE TABLE gold.fact_sales(
    order_number nvarchar(50),      -- Unique order number for the sale
    product_key int,                -- Foreign key to the 'dim_products' table
    customer_key int,               -- Foreign key to the 'dim_customers' table
    order_date date,                -- Date when the order was placed
    shipping_date date,             -- Date when the order was shipped
    due_date date,                  -- Date when the order is due for delivery
    sales_amount int,               -- Total sales amount for the order
    quantity tinyint,               -- Quantity of products ordered
    price int                       -- Price of the product
);
GO

-- Empty the 'dim_customers' table to ensure it is clear before loading new data
TRUNCATE TABLE gold.dim_customers;
GO

-- Bulk insert data into the 'dim_customers' table from a CSV file
BULK INSERT gold.dim_customers
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
WITH (
    FIRSTROW = 2,                 -- Skip the first row (header row) of the CSV file
    FIELDTERMINATOR = ',',        -- Specify the field separator (comma)
    TABLOCK                       -- Lock the entire table for the bulk insert
);
GO

-- Empty the 'dim_products' table to ensure it is clear before loading new data
TRUNCATE TABLE gold.dim_products;
GO

-- Bulk insert data into the 'dim_products' table from a CSV file
BULK INSERT gold.dim_products
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
WITH (
    FIRSTROW = 2,                 -- Skip the first row (header row) of the CSV file
    FIELDTERMINATOR = ',',        -- Specify the field separator (comma)
    TABLOCK                       -- Lock the entire table for the bulk insert
);
GO

-- Empty the 'fact_sales' table to ensure it is clear before loading new data
TRUNCATE TABLE gold.fact_sales;
GO

-- Bulk insert data into the 'fact_sales' table from a CSV file
BULK INSERT gold.fact_sales
FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
WITH (
    FIRSTROW = 2,                 -- Skip the first row (header row) of the CSV file
    FIELDTERMINATOR = ',',        -- Specify the field separator (comma)
    TABLOCK                       -- Lock the entire table for the bulk insert
);
GO
