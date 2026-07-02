CREATE DATABASE superstore_db;
USE superstore_db;
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
SELECT * FROM sales_data;
SELECT customer_name, sales, profit FROM sales_data;
SELECT * FROM sales_data WHERE category = 'Technology';
SELECT * FROM sales_data ORDER BY sales DESC;
SELECT * FROM sales_data ORDER BY profit DESC LIMIT 10;
SELECT COUNT(*) FROM sales_data;
SELECT MIN(year), MAX(year) FROM sales_data;
SELECT * FROM sales_data LIMIT 5;
DROP TABLE sales_data;
SELECT VERSION();
SHOW VARIABLES LIKE 'local_infile';

TRUNCATE TABLE sales_data;
LOAD DATA LOCAL INFILE 'C:/Users/user/Data Analytics Projects/Superstore Sales Analysis/Dataset/Global_Superstore_Clean.csv'
INTO TABLE sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id,
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
 year);
TRUNCATE TABLE sales_data;

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