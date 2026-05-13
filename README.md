Superstore SQL Analysis
SQL analysis of Kaggle's Superstore dataset (10,000+ rows) using MySQL.
The goal was to answer real business questions about sales performance, customer behavior, shipping efficiency, and regional trends.

Key Findings

West region dominates revenue — $10,189 in sales across 48 orders, nearly 2.5x more than South ($4,153 across only 18 orders)
Technology is the highest-grossing category — Phones alone generated $5,481 making it the top sub-category, followed closely by Furniture/Tables at $5,113
Pennsylvania has the highest average order value at $1,158 per order — significantly ahead of Kentucky ($993) and Missouri ($839)
Brosina Hoffman is the top customer in the West with $3,714 in total sales; Tracy Blumstein leads the East with $3,322
Office Supplies underperforms — Storage is the best sub-category at only $2,990, far behind Technology and Furniture


Business Questions Answered
#QuestionTechnique Used1Which region generates the most sales and orders?GROUP BY, ORDER BY2What is the top-selling sub-category within each category?CTE + ROW_NUMBER() Window Function3Which customers placed only one order?GROUP BY + HAVING4Which months had above-average sales?CTE + Subquery5Who are the top 3 customers by sales in each region?CTE + ROW_NUMBER() Window Function6What is the yearly sales trend?STR_TO_DATE, GROUP BY7Which states have the highest average order value?CTE + AVG, ORDER BY8How do sales break down by segment and category?GROUP BY (multiple columns)9Which products appear only once in orders?GROUP BY + HAVING10What is the average shipping time per ship mode?CTE + DATEDIFF

SQL Concepts Used

CTEs (Common Table Expressions) — used in 6 out of 10 queries
Window Functions — ROW_NUMBER(), RANK() with PARTITION BY
Aggregate Functions — SUM, COUNT, AVG
Date Functions — STR_TO_DATE(), YEAR(), MONTH(), DATEDIFF()
Subqueries — for above-average comparisons
HAVING — for post-aggregation filtering
Multi-column GROUP BY


Dataset

Source: Kaggle Superstore Dataset
File: train.csv
Rows: 10,000+
Columns used: Order ID, Order Date, Ship Date, Ship Mode, Customer Name, Region, State, Category, Sub-Category, Sales


Tools

MySQL Workbench
Kaggle (dataset source)
GitHub (version control)


How to Run

Download train.csv from the Kaggle link above
Import into MySQL as a table named train
Run queries from superstore_analysis.sql in order
