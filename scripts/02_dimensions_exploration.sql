/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Query 1: Retrieve a list of unique countries from which customers originate
-- This query retrieves a list of distinct countries where customers come from
SELECT DISTINCT 
    country  -- Selects the unique country names from the dim_customers table
FROM gold.dim_customers
ORDER BY country;  -- Orders the list of countries alphabetically

-- Query 2: Retrieve a list of unique categories, subcategories, and products
-- This query retrieves distinct combinations of product categories, subcategories, and product names
SELECT DISTINCT 
    category,       -- Selects the unique product categories
    subcategory,    -- Selects the unique subcategories within each category
    product_name    -- Selects the unique product names within each subcategory
FROM gold.dim_products
ORDER BY category, subcategory, product_name;  -- Orders the list first by category, then subcategory, and finally by product name
