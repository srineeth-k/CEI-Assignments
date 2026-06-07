USE ecommerce_db;
SHOW TABLES;
-- =====================================================
-- Section A — SQL Basics
-- =====================================================

-- Q1. Display all columns and rows from customers table
SELECT * FROM customers;

-- Q2. Display first name, last name and city of customers
SELECT first_name, last_name, city
FROM customers;

-- Q3. List all unique product categories
SELECT DISTINCT category FROM products;

-- Q4. Primary Keys
-- customers.customer_id
-- products.product_id
-- orders.order_id
-- order_items.item_id
-- A Primary Key must be UNIQUE and NOT NULL because it uniquely identifies each record in a table.
-- UNIQUE ensures no two records have the same identifier.
-- NOT NULL ensures every record has an identifier.

-- Q5. Email constraints
DESC customers;
-- email has UNIQUE and NOT NULL constraints.
--  An attempt to insert a duplicate email will result in a UNIQUE constraint violation.

-- Example:
INSERT INTO customers
VALUES (109,'Test','User','aarav.s@email.com', 'Mumbai','Maharashtra','2024-09-01',FALSE);

-- Q6. CHECK constraint on unit_price

INSERT INTO products
VALUES (209,'Test Product','Electronics', 'TestBrand',-50,100);

-- Error occurs because:  Check constraint 'products_chk_1' is violated.
-- CHECK (unit_price > 0)

-- =====================================================
-- Section B — Filtering & Optimization
-- =====================================================

-- Q7. Retrieve all Delivered orders
SELECT * FROM orders WHERE status = 'Delivered';

-- Q8. Electronics products with price > 2000
SELECT * FROM products WHERE category = 'Electronics' AND unit_price > 2000;

-- Q9. Customers from Maharashtra who joined in 2024
SELECT * FROM customers  WHERE state = 'Maharashtra' 
AND join_date BETWEEN '2024-01-01' AND '2024-12-31';

-- Q10. Orders between 2024-08-10 and 2024-08-25 which are not cancelled
SELECT * FROM orders
WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25'
AND status <> 'Cancelled';

-- Q11. Index explanation
-- idx_orders_date is an index created on the order_date column.
-- It helps MySQL find rows faster when filtering or sorting by order_date.
-- Without an index, MySQL may scan the whole orders table.

SELECT * FROM orders WHERE order_date BETWEEN '2024-08-10' AND '2024-08-25';

-- Q12. Index-friendly date query
-- This query may not use index efficiently:
SELECT * FROM customers WHERE YEAR(join_date) = 2024;

-- Better  query:
SELECT * FROM customers WHERE join_date >= '2024-01-01' AND join_date < '2025-01-01';

-- =====================================================
-- Section C — Aggregation
-- =====================================================
-- Q13. Count total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Q14. Total revenue from Delivered orders
SELECT SUM(total_amount) AS delivered_revenue FROM orders WHERE status = 'Delivered';

-- Q15. Average unit price of products in each category
SELECT category, ROUND(AVG(unit_price),2) AS average_unit_price
FROM products GROUP BY category;

-- Q16. Count of orders and total revenue by order status
SELECT status, COUNT(*) AS order_count, SUM(total_amount) AS total_revenue
FROM orders GROUP BY status ORDER BY total_revenue DESC;

-- Q17. Most expensive and cheapest product in each category
SELECT category, MAX(unit_price) AS expensive_product_price,
       MIN(unit_price) AS cheapest_product_price
FROM products GROUP BY category;

-- Q18. Categories where average unit price is greater than 2000
SELECT category, ROUND(AVG(unit_price),2) AS avg_unit_price
FROM products GROUP BY category HAVING AVG(unit_price) > 2000;


-- =====================================================
-- Section D — Joins & Relationships
-- =====================================================

-- Q19. Display orders with customer names
SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount
FROM orders o INNER JOIN customers c ON o.customer_id = c.customer_id;

-- Q20. List all customers and their orders
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Q21. Join orders, order_items and products
SELECT o.order_id, p.product_name, oi.quantity, oi.unit_price, oi.discount_pct
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Q22. LEFT JOIN vs RIGHT JOIN
-- LEFT JOIN:
-- Returns all records from the left table and matching records from the right table.
SELECT c.customer_id, c.first_name, o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- RIGHT JOIN:
-- Returns all records from the right table and matching records from the left table.
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- FULL OUTER JOIN:
-- Returns all matching and non-matching rows from both tables.
-- Useful when we want complete data from both tables.

-- Q23. Foreign Key Relationships
-- orders.customer_id → customers.customer_id
-- order_items.order_id → orders.order_id
-- order_items.product_id → products.product_id

-- Example that violates Foreign Key:
INSERT INTO orders VALUES (1011,999,'2024-09-01','Pending',1000);
-- Error occurs because customer_id 999 does not exist in customers table.


-- =====================================================
-- Section E — CASE, ACID, Transactions
-- =====================================================
-- Q24. Product price tiers using CASE
SELECT product_name, unit_price,
       CASE
            WHEN unit_price < 1000 THEN 'Budget'
            WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
            ELSE 'Premium'
       END AS price_tier
FROM products;


-- Q25. Count Delivered vs Not Delivered
SELECT
SUM(CASE WHEN status='Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
SUM(CASE WHEN status<>'Delivered' THEN 1 ELSE 0 END) AS not_delivered_orders
FROM orders;


-- Q26. ACID Properties
-- A = Atomicity
-- All operations succeed or all fail.

-- C = Consistency
-- Database remains valid before and after transaction.

-- I = Isolation
-- Concurrent transactions do not interfere with each other.

-- D = Durability
-- Once committed, changes remain permanent.

-- Example:
-- During a bank transfer, money is deducted from one account and added to another.
-- If any step fails, rollback occurs.


-- Q27. Transaction Example
START TRANSACTION;
INSERT INTO orders
VALUES (1011,102,CURDATE(),'Pending',1598.00);

INSERT INTO order_items
VALUES (5016,1011,206,1,1299.00,0);

INSERT INTO order_items
VALUES (5017,1011,208,1,599.00,0);

UPDATE products SET stock_qty = stock_qty - 1 WHERE product_id = 206;

UPDATE products SET stock_qty = stock_qty - 1 WHERE product_id = 208;

COMMIT;

