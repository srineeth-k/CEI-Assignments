# Week 2 Data Engineering Assignment

## Summary

In this assignment, I worked with the Superstore Sales dataset from Kaggle using SQL (MySQL). The objective was to analyze sales data through filtering, aggregation, sorting, business-oriented queries, and data validation. The dataset contains sales transactions, customer information, product details, shipping information, and profitability metrics, making it suitable for performing end-to-end SQL-based analysis.

## Data Loading and Exploration

I imported the Superstore dataset into MySQL Workbench using the Table Data Import Wizard and stored it in a relational table. After loading the data, I explored the schema using DESCRIBE and reviewed sample records using SELECT statements. This helped me understand the structure of the dataset, column types, and available business attributes.

## Data Filtering

I applied multiple WHERE clause filters to retrieve specific subsets of data based on region, category, sales amount, and date ranges. These queries helped identify high-value transactions, region-specific sales performance, and category-level activity.

## Aggregation and Analysis

I used GROUP BY along with aggregate functions such as SUM(), AVG(), and COUNT() to analyze sales, quantity, and profit across regions, categories, sub-categories, and customers. These aggregations provided insights into overall business performance and customer purchasing patterns.

## Sorting and Ranking

I used ORDER BY and LIMIT to identify top-performing products, customers, and categories. Ranking queries were used to determine products generating the highest sales and profits.

## Business Use Cases

I implemented business-focused queries to:

* Analyze monthly sales trends.
* Identify top customers based on revenue contribution.
* Detect duplicate records.
* Evaluate sales performance over time.

## Data Validation

I performed data quality checks by verifying row counts, checking for missing values, validating date ranges, and reviewing sales statistics. These checks ensured the reliability and consistency of the dataset.

## Key Learnings

Through this assignment, I gained practical experience in:

* SQL data exploration.
* Filtering and conditional queries.
* Aggregation using GROUP BY.
* Ranking and sorting techniques.
* Business analytics using SQL.
* Data validation and quality checks.

## Tools Used

* MySQL 8.0
* MySQL Workbench
* SQL
* Superstore Sales Dataset (Kaggle)

## Conclusion

This assignment strengthened my understanding of SQL for data analysis by applying filtering, aggregation, ranking, trend analysis, and validation techniques to a real-world sales dataset.
