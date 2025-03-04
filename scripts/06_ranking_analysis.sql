/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Query 1: Which 5 products are generating the highest revenue?
-- Simple Ranking: Selecting the top 5 products based on total sales revenue
SELECT TOP 5
    p.product_name,                                  -- Select the product name
    SUM(f.sales_amount) AS total_revenue              -- Sum up the total revenue for each product
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key                 -- Join fact_sales and dim_products on product_key
GROUP BY p.product_name                             -- Group the result by product name
ORDER BY total_revenue DESC;                        -- Order the result in descending order of total revenue

-- Query 2: Complex but flexible ranking using Window Functions
-- Ranking the products using RANK() function and selecting the top 5 ranked products
SELECT *
FROM (
    SELECT
        p.product_name,                              -- Select product name
        SUM(f.sales_amount) AS total_revenue,         -- Sum up the total revenue for each product
        RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products  -- Apply RANK() window function to rank products by total revenue
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key            -- Join fact_sales and dim_products on product_key
    GROUP BY p.product_name                          -- Group the result by product name
) AS ranked_products
WHERE rank_products <= 5;                           -- Filter the top 5 ranked products

-- Query 3: What are the 5 worst-performing products in terms of sales?
-- Simple Ranking: Selecting the top 5 products generating the lowest revenue
SELECT TOP 5
    p.product_name,                                  -- Select the product name
    SUM(f.sales_amount) AS total_revenue              -- Sum up the total revenue for each product
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key                 -- Join fact_sales and dim_products on product_key
GROUP BY p.product_name                             -- Group the result by product name
ORDER BY total_revenue;                             -- Order the result in ascending order of total revenue (worst performing products)

-- Query 4: Find the top 10 customers who have generated the highest revenue
-- Selecting the top 10 customers based on total revenue
SELECT TOP 10
    c.customer_key,                                  -- Select customer key
    c.first_name,                                    -- Select customer's first name
    c.last_name,                                     -- Select customer's last name
    SUM(f.sales_amount) AS total_revenue              -- Sum up the total revenue for each customer
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key               -- Join fact_sales and dim_customers on customer_key
GROUP BY 
    c.customer_key,                                  -- Group by customer key
    c.first_name,                                    -- Group by first name
    c.last_name                                      -- Group by last name
ORDER BY total_revenue DESC;                        -- Order the result in descending order of total revenue (top customers)

-- Query 5: The 3 customers with the fewest orders placed
-- Selecting the top 3 customers who placed the fewest orders
SELECT TOP 3
    c.customer_key,                                  -- Select customer key
    c.first_name,                                    -- Select customer's first name
    c.last_name,                                     -- Select customer's last name
    COUNT(DISTINCT order_number) AS total_orders      -- Count the number of distinct orders per customer
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key               -- Join fact_sales and dim_customers on customer_key
GROUP BY 
    c.customer_key,                                  -- Group by customer key
    c.first_name,                                    -- Group by first name
    c.last_name                                      -- Group by last name
ORDER BY total_orders;                              -- Order the result in ascending order of total orders (fewest orders)
