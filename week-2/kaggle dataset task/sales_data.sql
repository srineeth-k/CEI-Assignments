-- View table structure before changes
DESCRIBE sales;

-- Rename columns for easier querying
ALTER TABLE sales
CHANGE COLUMN `Row ID` row_id INT;

ALTER TABLE sales
CHANGE COLUMN `Order ID` order_id TEXT;

ALTER TABLE sales
CHANGE COLUMN `Order Date` order_date TEXT;

ALTER TABLE sales
CHANGE COLUMN `Ship Date` ship_date TEXT;

ALTER TABLE sales
CHANGE COLUMN `Ship Mode` ship_mode TEXT;

ALTER TABLE sales
CHANGE COLUMN `Customer ID` customer_id TEXT;

ALTER TABLE sales
CHANGE COLUMN `Customer Name` customer_name TEXT;

ALTER TABLE sales
CHANGE COLUMN `Postal Code` postal_code INT;

ALTER TABLE sales
CHANGE COLUMN `Product ID` product_id TEXT;

ALTER TABLE sales
CHANGE COLUMN `Product Name` product_name TEXT;

ALTER TABLE sales
CHANGE COLUMN `Sub-Category` sub_category TEXT;

-- View updated table structure
DESCRIBE sales;

-- 2. Explore table

-- Count total records
SELECT COUNT(*) AS total_rows FROM sales;

-- Display sample records
SELECT * FROM sales LIMIT 5;

-- 3. WHERE filters

-- Filter records from South region
SELECT * FROM sales WHERE region = 'South' LIMIT 5;

-- Filter Office Supplies category
SELECT * FROM sales WHERE category = 'Office Supplies' LIMIT 5;

-- Filter sales between 1000 and 2000
SELECT order_id, order_date, customer_name, category, sales FROM sales WHERE sales BETWEEN 1000 AND 2000
ORDER BY sales DESC LIMIT 5;

-- Multiple filter conditions
SELECT order_id, order_date, customer_name, region, category, sales
FROM sales WHERE region = 'South' AND category = 'Technology' AND sales > 1000
ORDER BY sales DESC LIMIT 5;

-- Filter records for a specific date
SELECT * FROM sales WHERE STR_TO_DATE(order_date, '%m/%d/%Y') = '2016-05-15';

-- Filter records between two dates
SELECT order_id, order_date, customer_name, sales
FROM sales  WHERE STR_TO_DATE(order_date,'%m/%d/%Y')
BETWEEN '2016-01-01' AND '2016-12-31' ORDER BY STR_TO_DATE(order_date,'%m/%d/%Y');

-- 4. GROUP BY Aggregations, 5.Sort and limit results

-- Sales summary by region
SELECT region, ROUND(SUM(sales),2) AS total_sales,
SUM(quantity) AS total_quantity, ROUND(AVG(sales),2) AS average_sales
FROM sales GROUP BY region ORDER BY total_sales DESC LIMIT 5;

-- Sales summary by category
SELECT category, ROUND(SUM(sales),2) AS total_sales,
SUM(quantity) AS total_quantity, ROUND(AVG(sales),2) AS average_sales
FROM sales GROUP BY category ORDER BY total_sales DESC LIMIT 5;

-- Sales summary by sub-category
SELECT sub_category, ROUND(SUM(sales),2) AS total_sales,
SUM(quantity) AS total_quantity, ROUND(AVG(sales),2) AS average_sales
FROM sales GROUP BY sub_category ORDER BY total_sales DESC LIMIT 5;

-- Top customers by sales
SELECT customer_name, ROUND(SUM(sales),2) AS total_sales,
SUM(quantity) AS total_quantity, ROUND(AVG(sales),2) AS average_sales
FROM sales GROUP BY customer_name ORDER BY total_sales DESC LIMIT 5;

-- Profit summary by region
SELECT region, ROUND(SUM(profit),2) AS total_profit,
ROUND(AVG(profit),2) AS average_profit
FROM sales GROUP BY region ORDER BY total_profit DESC;

-- Top products by sales
SELECT product_name, ROUND(SUM(sales),2) AS total_sales,
SUM(quantity) AS total_quantity, ROUND(AVG(sales),2) AS average_sales
FROM sales GROUP BY product_name ORDER BY total_sales DESC LIMIT 10;

-- Top profitable products
SELECT product_name, ROUND(SUM(profit),2) AS total_profit
FROM sales GROUP BY product_name ORDER BY total_profit DESC LIMIT 10;

-- 6. Use cases (monthly trends, top customers, duplicates)

-- Monthly sales trend
SELECT DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
ROUND(SUM(sales), 2) AS monthly_sales,
SUM(quantity) AS monthly_quantity,
ROUND(SUM(profit), 2) AS monthly_profit
FROM sales GROUP BY month ORDER BY month;

-- Top 10 customers
SELECT customer_name, ROUND(SUM(sales), 2) AS total_sales,
SUM(quantity) AS total_quantity,ROUND(SUM(profit), 2) AS total_profit
FROM sales GROUP BY customer_name ORDER BY total_sales DESC LIMIT 10;

-- Check duplicate records
SELECT order_id, product_id, COUNT(*) AS duplicate_count
FROM sales GROUP BY order_id, product_id
HAVING COUNT(*) > 1 ORDER BY duplicate_count DESC;

-- 7.Validate Results

-- Check missing values
SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS missing_customer_name,
SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS missing_product_name,
SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_quantity,
SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM sales;

-- Check sales statistics
SELECT ROUND(MIN(sales), 2) AS minimum_sales, ROUND(MAX(sales), 2) AS maximum_sales,
ROUND(AVG(sales), 2) AS average_sales
FROM sales;

-- Check date range
SELECT MIN(STR_TO_DATE(order_date, '%m/%d/%Y')) AS earliest_order_date,
MAX(STR_TO_DATE(order_date, '%m/%d/%Y')) AS latest_order_date
FROM sales;
