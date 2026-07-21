/*==========================================================
1. DATABASE CREATION
==========================================================*/
CREATE DATABASE superstore_db;
USE superstore_db;
/*==========================================================
2. TABLE CREATION
==========================================================*/
CREATE TABLE sales_data (
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales FLOAT,
    quantity INT,
    discount FLOAT,
    profit FLOAT,
    shipping_cost FLOAT,
    order_priority VARCHAR(20),
    year INT
);
/*==========================================================
3. DATA CLEANING
==========================================================*/
SELECT * FROM sales_data;
SELECT customer_name, sales, profit FROM sales_data;
SELECT * FROM sales_data WHERE category = 'Technology';
SELECT * FROM sales_data ORDER BY sales DESC;
SELECT * FROM sales_data ORDER BY profit DESC LIMIT 10;
/*==========================================================
5. AGGREGATE FUNCTIONS
==========================================================*/
SELECT COUNT(*) FROM sales_data;
SELECT MIN(year), MAX(year) FROM sales_data;
SELECT * FROM sales_data LIMIT 5;
SHOW VARIABLES LIKE 'local_infile';
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.7/Uploads/Global_Superstore_Clean.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
order_id,
order_date,
ship_date,
ship_mode,
customer_name,
segment,
state,
country,
market,
region,
product_id,
category,
sub_category,
product_name,
sales,
quantity,
discount,
profit,
shipping_cost,
order_priority,
year
);

SELECT COUNT(*) AS total_rows
FROM sales_data;
SELECT DISTINCT category
FROM sales_data;
SELECT *
FROM sales_data
WHERE category = 'Technology';
SELECT DISTINCT category
FROM sales_data;
SELECT DISTINCT region
FROM sales_data;
SELECT DISTINCT ship_mode
FROM sales_data;
SELECT customer_name, profit
FROM sales_data
WHERE profit > 5000;
SELECT product_name, sales
FROM sales_data
WHERE sales < 100;
SELECT product_name, discount
FROM sales_data
WHERE discount <= 0.2;
SELECT *
FROM sales_data
WHERE category != 'Furniture';
SELECT product_name, category
FROM sales_data
WHERE category != 'Technology';
SELECT *
FROM sales_data
WHERE category = 'Technology'
AND profit > 1000;
SELECT *
FROM sales_data
WHERE category = 'Technology'
OR category = 'Furniture';
SELECT customer_name
FROM sales_data
WHERE customer_name LIKE 'A%';
SELECT product_name
FROM sales_data
WHERE product_name LIKE '%Chair%';
SELECT COUNT(*)
FROM sales_data;
SELECT COUNT(*)
FROM sales_data
WHERE category = 'Furniture';
/*==========================================================
6. GROUP BY & HAVING
==========================================================*/
SELECT SUM(profit)
FROM sales_data
WHERE category = 'Technology';
SELECT AVG(profit)
FROM sales_data;
SELECT MAX(profit)
FROM sales_data
WHERE category = 'Technology';
SELECT category, SUM(sales)
FROM sales_data
GROUP BY category;
SELECT category, SUM(sales)
FROM sales_data
GROUP BY category
HAVING SUM(sales) > 4000000;
SELECT category, SUM(sales)
FROM sales_data
WHERE category = 'Furniture'
GROUP BY category;
SELECT category, SUM(sales) AS Total_Sales
FROM sales_data
GROUP BY category
ORDER BY Total_Sales DESC;
SELECT category,
       SUM(sales) AS Total_Sales
FROM sales_data
GROUP BY category
ORDER BY Total_Sales DESC
LIMIT 2;
SELECT customer_name, category, sales
FROM sales_data
WHERE category IN ('Furniture', 'Technology');
SELECT customer_name, sales
FROM sales_data
WHERE sales BETWEEN 1000 AND 5000;
SELECT product_name, category
FROM sales_data
WHERE category NOT IN ('Furniture', 'Technology');
SELECT Product_name, sales
FROM sales_data WHERE sales NOT BETWEEN 500 AND 2000;
SELECT customer_name
FROM sales_data
WHERE profit IS NULL;
SELECT customer_name
FROM sales_data
WHERE profit IS NOT NULL;
/*==========================================================
7. CASE STATEMENTS
==========================================================*/
SELECT product_name,
       sales,
       CASE
           WHEN sales >= 5000 THEN 'High Sales'
           ELSE 'Low Sales'
       END AS Sales_Category
FROM sales_data;
SELECT product_name,
       discount,
       CASE
           WHEN discount = 0 THEN 'No Discount'
           WHEN discount <= 0.2 THEN 'Low Discount'
           ELSE 'High Discount'
       END AS Discount_Level
FROM sales_data;
/*==========================================================
8. STRING FUNCTIONS
==========================================================*/
SELECT UPPER(customer_name)
FROM sales_data; 
SELECT LOWER(customer_name)
FROM sales_data;
SELECT UPPER(customer_name),
       country
FROM sales_data;
SELECT customer_name,
       LENGTH(customer_name)
FROM sales_data;
SELECT CONCAT(customer_name, ' - ', country) AS Customer_Info
FROM sales_data;
SELECT TRIM(customer_name)
FROM sales_data;
/*==========================================================
9. DATE FUNCTIONS
==========================================================*/
SELECT order_date,
       YEAR(order_date) AS Order_Year
FROM sales_data;
SELECT order_date,
       MONTH(order_date) AS Order_Month
FROM sales_data;
SELECT order_date,
       DAY(order_date) AS Order_Day
FROM sales_data;
DESCRIBE sales_data;
SELECT order_date,
       STR_TO_DATE(order_date, '%m/%d/%Y') AS Converted_Date
FROM sales_data
LIMIT 10;
SELECT order_date,
       YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS Order_Year
FROM sales_data;
SELECT order_date,
       MONTH(STR_TO_DATE(order_date, '%m/%d/%Y')) AS Order_Month
FROM sales_data;
SELECT order_date,
       DAY(STR_TO_DATE(order_date, '%m/%d/%Y')) AS Order_Day
FROM sales_data; 
ALTER TABLE sales_data
ADD COLUMN order_date_new DATE;
UPDATE sales_data
SET order_date_new = STR_TO_DATE(order_date, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 0;
DESCRIBE sales_data;
SELECT @@SQL_SAFE_UPDATES;
UPDATE sales_data
SET order_date_new = STR_TO_DATE(order_date, '%m/%d/%Y');
SELECT
    YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS Order_Year
FROM sales_data;
/*==========================================================
10. SUBQUERIES
==========================================================*/
SELECT product_name, sales
FROM sales_data
WHERE sales >
(
    SELECT AVG(sales)
    FROM sales_data
); 
/*==========================================================
11. WINDOW FUNCTIONS
==========================================================*/
SELECT product_name,
       sales,
       ROW_NUMBER() OVER (ORDER BY sales DESC) AS Row_Num
FROM sales_data;
SELECT product_name,
       sales,
       RANK() OVER (ORDER BY sales DESC) AS Sales_Rank
FROM sales_data;
SELECT product_name,
       sales,
       DENSE_RANK() OVER (ORDER BY sales DESC) AS Sales_Rank
FROM sales_data;
/*==========================================================
12. VIEWS
==========================================================*/

CREATE VIEW High_Profit_Products AS
SELECT product_name,
       profit
FROM sales_data
WHERE profit > 1000;
SELECT *
FROM High_Profit_Products;
SELECT product_name,
       profit
FROM sales_data
WHERE profit > 1000;
/*==========================================================
13. JOINS
==========================================================*/
CREATE DATABASE sql_practice;
USE sql_practice;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO customers VALUES
(1,'John','Bangalore'),
(2,'Alice','Chennai'),
(3,'David','Hyderabad'),
(4,'Maria','Mumbai'),
(5,'Sam','Delhi');
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    amount INT
);
INSERT INTO orders VALUES
(101,1,'Laptop',80000),
(102,2,'Mouse',500),
(103,1,'Keyboard',2000),
(104,4,'Monitor',15000),
(105,6,'Printer',10000); 
SELECT * FROM customers;
SELECT * FROM orders;
SELECT customers.customer_name,
       orders.product,
       orders.amount
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;
SELECT customers.customer_name,
       orders.product,
       orders.amount
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;
SELECT customers.customer_name,
       orders.product,
       orders.amount
FROM customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id;