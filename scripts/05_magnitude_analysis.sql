/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Query 1: Find total customers by countries
-- This query groups customers by their country and counts the total number of customers in each country
SELECT
    country,                                      -- Select the country
    COUNT(customer_key) AS total_customers         -- Count the number of customers in each country
FROM gold.dim_customers
GROUP BY country                                 -- Group by country to calculate the total number of customers in each
ORDER BY total_customers DESC;                   -- Order the countries by the number of customers in descending order

-- Query 2: Find total customers by gender
-- This query groups customers by gender and counts the total number of customers in each gender
SELECT
    gender,                                      -- Select the gender
    COUNT(customer_key) AS total_customers         -- Count the number of customers in each gender
FROM gold.dim_customers
GROUP BY gender                                 -- Group by gender to calculate the total number of customers in each gender
ORDER BY total_customers DESC;                   -- Order the genders by the number of customers in descending order

-- Query 3: Find total products by category
-- This query groups products by category and counts the total number of products in each category
SELECT
    category,                                    -- Select the product category
    COUNT(product_key) AS total_products          -- Count the number of products in each category
FROM gold.dim_products
GROUP BY category                               -- Group by category to calculate the total number of products in each category
ORDER BY total_products DESC;                   -- Order the categories by the total number of products in descending order

-- Query 4: What is the average cost in each category?
-- This query calculates the average cost of products within each category
SELECT
    category,                                    -- Select the product category
    AVG(cost) AS avg_cost                         -- Calculate the average cost of products in each category
FROM gold.dim_products
GROUP BY category                               -- Group by category to calculate the average cost of products in each category
ORDER BY avg_cost DESC;                          -- Order the categories by average cost in descending order

-- Query 5: What is the total revenue generated for each category?
-- This query calculates the total revenue generated from each product category by summing up sales amounts
SELECT
    p.category,                                  -- Select the product category
    SUM(f.sales_amount) AS total_revenue          -- Sum the sales amount to get total revenue for each category
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key             -- Join fact_sales with dim_products to associate products with their categories
GROUP BY p.category                             -- Group by category to calculate the total revenue generated from each category
ORDER BY total_revenue DESC;                    -- Order by total revenue in descending order

-- Query 6: What is the total revenue generated by each customer?
-- This query calculates the total revenue generated by each customer by summing their sales amount
SELECT
    c.customer_key,                              -- Select the customer key
    c.first_name,                                -- Select the customer's first name
    c.last_name,                                 -- Select the customer's last name
    SUM(f.sales_amount) AS total_revenue          -- Sum the sales amount to calculate total revenue for each customer
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key           -- Join fact_sales with dim_customers to associate sales with customers
GROUP BY 
    c.customer_key,                              -- Group by customer to calculate total revenue per customer
    c.first_name,                                -- Group by customer's first name
    c.last_name                                  -- Group by customer's last name
ORDER BY total_revenue DESC;                     -- Order customers by total revenue in descending order

-- Query 7: What is the distribution of sold items across countries?
-- This query calculates the total quantity of items sold in each country by summing up the sales quantity
SELECT
    c.country,                                   -- Select the country
    SUM(f.quantity) AS total_sold_items           -- Sum the quantity of items sold to get total sold items per country
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key           -- Join fact_sales with dim_customers to associate sales with customers
GROUP BY c.country                              -- Group by country to calculate total items sold in each country
ORDER BY total_sold_items DESC;                  -- Order countries by total sold items in descending order
