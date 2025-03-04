/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/


-- First Query: Group data by Year and Month
SELECT 
    YEAR(order_date) AS order_year,                  -- Extracts the year from order_date
    MONTH(order_date) AS order_months,               -- Extracts the month from order_date
    SUM(sales_amount) as total_Sales,                -- Sums the sales amount for the group
    COUNT(DISTINCT customer_key) AS total_customers,  -- Counts the number of distinct customers for the group
    SUM(quantity) as total_quantity                  -- Sums the quantity for the group
FROM gold.fact_sales
WHERE order_date IS NOT NULL                       -- Filters out rows where order_date is NULL
GROUP BY YEAR(order_date), MONTH(order_date)       -- Groups the data by year and month
ORDER BY YEAR(order_date), MONTH(order_date);      -- Orders the results by year and month

-- Second Query: Group data by Month using DATETRUNC
SELECT 
    DATETRUNC(MONTH, order_date) AS order_date,      -- Truncates order_date to the first day of the month
    SUM(sales_amount) as total_Sales,                -- Sums the sales amount for the truncated month
    COUNT(DISTINCT customer_key) AS total_customers,  -- Counts distinct customers for the truncated month
    SUM(quantity) as total_quantity                  -- Sums the quantity for the truncated month
FROM gold.fact_sales
WHERE order_date IS NOT NULL                       -- Filters out rows where order_date is NULL
GROUP BY DATETRUNC(MONTH, order_date)              -- Groups by the truncated month
ORDER BY DATETRUNC(MONTH, order_date);             -- Orders the results by truncated month

-- Third Query: Group data by Year using DATETRUNC
SELECT 
    DATETRUNC(YEAR, order_date) AS order_date,      -- Truncates order_date to the first day of the year
    SUM(sales_amount) as total_Sales,                -- Sums the sales amount for the truncated year
    COUNT(DISTINCT customer_key) AS total_customers,  -- Counts distinct customers for the truncated year
    SUM(quantity) as total_quantity                  -- Sums the quantity for the truncated year
FROM gold.fact_sales
WHERE order_date IS NOT NULL                       -- Filters out rows where order_date is NULL
GROUP BY DATETRUNC(YEAR, order_date)               -- Groups by the truncated year
ORDER BY DATETRUNC(YEAR, order_date);              -- Orders the results by truncated year

-- Fourth Query: Group data by Year-Month format using FORMAT()
SELECT 
    FORMAT(order_date, 'yyyy-MMM') AS order_date,   -- Formats order_date as 'Year-Month' (e.g., 2014-Jan)
    SUM(sales_amount) as total_Sales,                -- Sums the sales amount for the formatted year-month
    COUNT(DISTINCT customer_key) AS total_customers,  -- Counts distinct customers for the formatted year-month
    SUM(quantity) as total_quantity                  -- Sums the quantity for the formatted year-month
FROM gold.fact_sales
WHERE order_date IS NOT NULL                       -- Filters out rows where order_date is NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')            -- Groups by the formatted year-month
ORDER BY FORMAT(order_date, 'yyyy-MMM');           -- Orders the results by formatted year-month
