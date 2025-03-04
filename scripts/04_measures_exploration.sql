/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Query 1: Find the Total Sales
-- This query calculates the total sales amount across all orders in the fact_sales table
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales;

-- Query 2: Find how many items are sold
-- This query calculates the total number of items sold by summing the quantity of products sold in all orders
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales;

-- Query 3: Find the average selling price
-- This query calculates the average selling price of all items sold by averaging the price of products in the fact_sales table
SELECT AVG(price) AS avg_price FROM gold.fact_sales;

-- Query 4: Find the Total number of Orders
-- This query counts the total number of orders placed in the system by counting the distinct order_number in the fact_sales table
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales;

-- Query 5: Find the Total number of distinct Orders
-- This query counts the total number of unique orders (removing duplicates) placed by counting distinct order_number values
SELECT COUNT(DISTINCT order_number) AS total_orders FROM gold.fact_sales;

-- Query 6: Find the Total number of Products
-- This query counts the total number of products available in the product catalog (dim_products table)
SELECT COUNT(product_name) AS total_products FROM gold.dim_products;

-- Query 7: Find the Total number of Customers
-- This query counts the total number of customers in the system by counting the customer_key from the dim_customers table
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers;

-- Query 8: Find the Total number of Customers that have placed an order
-- This query counts how many unique customers have placed at least one order by counting distinct customer_key from the fact_sales table
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

-- Query 9: Generate a Report that shows all key metrics of the business
-- This query generates a report by combining all key metrics (e.g., total sales, total quantity, etc.) into a single result using UNION ALL
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
