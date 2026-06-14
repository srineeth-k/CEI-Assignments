create database Superstore_db;
use superstore_db;
SELECT COUNT(*) FROM superstore_raw;
DESCRIBE superstore_raw;

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

INSERT INTO customers
SELECT DISTINCT
    `Customer ID`,
    `Customer Name`,
    Segment
FROM superstore_raw;

SELECT COUNT(*) FROM customers;

CREATE TABLE products (
    product_id VARCHAR(30) PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

INSERT INTO products
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;

SELECT COUNT(*) FROM products;
DROP TABLE products;

CREATE TABLE products (
    product_id VARCHAR(30),
    product_name VARCHAR(255),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);
INSERT INTO products
SELECT DISTINCT
    `Product ID`,
    `Product Name`,
    Category,
    `Sub-Category`
FROM superstore_raw;
SELECT COUNT(*) FROM products;

DROP TABLE orders;
CREATE TABLE orders (
    order_id VARCHAR(30),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    product_id VARCHAR(30),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

INSERT INTO orders
SELECT DISTINCT
    `Order ID`,
    `Order Date`,
    `Ship Date`,
    `Ship Mode`,
    `Customer ID`,
    `Product ID`,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore_raw;

SELECT COUNT(*) FROM orders;

-- Step 2: Perform Required Queries
-- Q1. Orders where sales are greater than average sales
SELECT * FROM orders
WHERE sales > (SELECT AVG(sales) FROM orders);

-- Q2. Highest sales order for each customer
SELECT o.order_id, o.customer_id, o.product_id, o.sales
FROM orders o
JOIN (
    SELECT customer_id, MAX(sales) AS max_sales
    FROM orders GROUP BY customer_id
) m
ON o.customer_id = m.customer_id AND o.sales = m.max_sales
ORDER BY o.customer_id;

-- Q3. Total sales for each customer
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs JOIN customers c ON cs.customer_id = c.customer_id
ORDER BY cs.total_sales DESC;

-- Q4. Customers whose total sales are above average
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs JOIN customers c ON cs.customer_id = c.customer_id
WHERE cs.total_sales > (SELECT AVG(total_sales) FROM customer_sales)
ORDER BY cs.total_sales DESC;

-- Q5. Rank all customers based on total sales
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales,
RANK() OVER(ORDER BY cs.total_sales DESC) AS sales_rank
FROM customer_sales cs JOIN customers c ON cs.customer_id = c.customer_id;

-- Q6. Row numbers to each order within a customer
SELECT customer_id, order_id, product_id, sales,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY sales DESC) AS order_number
FROM orders;

-- Q7. Top 3 customers based on total sales
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders GROUP BY customer_id
),
ranked_customers AS (
    SELECT customer_id, total_sales,
    RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
)
SELECT c.customer_name, rc.total_sales, rc.sales_rank
FROM ranked_customers rc JOIN customers c ON rc.customer_id = c.customer_id
WHERE rc.sales_rank <= 3
ORDER BY rc.sales_rank;


-- Step 3: Final Combined Query
-- Customer name, total sales and rank using JOIN, CTE and window function
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders GROUP BY customer_id
),
ranked_customers AS (
    SELECT customer_id, total_sales,
    RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
)
SELECT c.customer_name, rc.total_sales, rc.sales_rank
FROM ranked_customers rc JOIN customers c ON rc.customer_id = c.customer_id
ORDER BY rc.sales_rank;


-- Mini Project: Customer Sales Insights
-- Q1. Top 5 customers
SELECT c.customer_name, SUM(o.sales) AS total_sales
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name ORDER BY total_sales DESC
LIMIT 5;

-- Q2. Bottom 5 customers
SELECT c.customer_name, SUM(o.sales) AS total_sales
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name ORDER BY total_sales ASC
LIMIT 5;

-- Q3. Customers who made only one order
SELECT c.customer_name, COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) = 1;

-- Q4. Customers with above average sales
SELECT c.customer_name, SUM(o.sales) AS total_sales
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.sales) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(sales) AS customer_total
        FROM orders GROUP BY customer_id
    ) t
)
ORDER BY total_sales DESC;

-- Q5. Highest order value per customer
SELECT c.customer_name, o.order_id, o.sales AS highest_order_value
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
JOIN (
    SELECT customer_id, MAX(sales) AS max_sales
    FROM orders GROUP BY customer_id
) m
ON o.customer_id = m.customer_id AND o.sales = m.max_sales
ORDER BY c.customer_name;