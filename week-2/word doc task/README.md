# Week 2 SQL Assignment

## Summary

In this assignment, I worked with a relational E-Commerce Sales Database using SQL (MySQL). The objective was to understand database design, relationships, constraints, filtering, aggregation, joins, transactions, and advanced SQL concepts through a practical business scenario.

## Database Design and Setup

I created a relational database consisting of four tables: customers, products, orders, and order_items. The schema included Primary Keys, Foreign Keys, UNIQUE constraints, NOT NULL constraints, CHECK constraints, and indexes to ensure data integrity and efficient querying.

After creating the tables, I inserted the provided sample data and verified the relationships between tables.

## SQL Basics and Constraints

I performed basic data retrieval operations using SELECT statements and explored table contents. I examined how Primary Keys uniquely identify records and how constraints such as UNIQUE and CHECK help prevent invalid data from being inserted.

## Filtering and Query Optimization

I used WHERE clauses to filter data based on order status, category, price, customer location, and date ranges. I also studied the role of indexes in improving query performance and learned how index-friendly queries can be written for efficient data retrieval.

## Aggregation and Reporting

I applied aggregate functions including COUNT(), SUM(), AVG(), MIN(), and MAX() to generate business summaries. Using GROUP BY and HAVING, I analyzed order volumes, revenue, product pricing, and category performance.

## Joins and Relationships

I implemented INNER JOIN, LEFT JOIN, and multi-table joins to combine information from customers, orders, products, and order_items. These queries demonstrated how related data can be retrieved across multiple tables using Foreign Key relationships.

## CASE Statements and Conditional Logic

I used CASE expressions to categorize products into pricing tiers and to summarize order delivery status. This helped demonstrate conditional logic within SQL queries.

## Transactions and ACID Properties

I studied ACID principles and implemented transaction handling using START TRANSACTION, COMMIT, and ROLLBACK. This exercise demonstrated how multiple database operations can be executed safely and consistently as a single unit of work.

## Key Learnings

Through this assignment, I gained practical experience in:

* Relational database design.
* Primary and Foreign Keys.
* Database constraints.
* SQL filtering and optimization.
* Aggregation and reporting.
* Multi-table joins.
* CASE statements.
* Transactions and ACID properties.

## Tools Used

* MySQL 8.0
* MySQL Workbench

## Conclusion

This assignment provided hands-on experience with relational databases and advanced SQL concepts. It strengthened my understanding of database relationships, data integrity, query optimization, joins, aggregations, and transaction management in an e-commerce environment.
