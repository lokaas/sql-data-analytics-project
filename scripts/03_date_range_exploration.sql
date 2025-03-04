/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Query 1: Determine the first and last order date and the total duration in months
-- This query calculates the first and last order date, and the total duration (in months) between the first and last orders
SELECT 
    MIN(order_date) AS first_order_date,                               -- Get the earliest (first) order date from the fact_sales table
    MAX(order_date) AS last_order_date,                                -- Get the latest (last) order date from the fact_sales table
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months -- Calculate the difference in months between the first and last order date
FROM gold.fact_sales;                                                 -- From the fact_sales table which contains sales transactions

-- Query 2: Find the youngest and oldest customer based on birthdate
-- This query calculates the youngest and oldest customers based on their birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,                               -- Get the oldest birthdate from the dim_customers table
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,          -- Calculate the age of the oldest customer by finding the difference between their birthdate and current date
    MAX(birthdate) AS youngest_birthdate,                             -- Get the youngest birthdate from the dim_customers table
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age         -- Calculate the age of the youngest customer by finding the difference between their birthdate and current date
FROM gold.dim_customers;                                              -- From the dim_customers table which contains customer information
