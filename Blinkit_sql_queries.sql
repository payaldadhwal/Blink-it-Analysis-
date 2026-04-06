create database blinkit;
use blinkit;
drop table if exists blinkit_grocery;
CREATE TABLE Blinkit_grocery (
    item_identifier VARCHAR(20),
    item_weight FLOAT,
    item_fat_content VARCHAR(50),
    item_visibility FLOAT,
    item_type VARCHAR(50),
    item_MRP FLOAT,
    outlet_identifier VARCHAR(50),
    outlet_establishment_year INT,
    outlet_size VARCHAR(50),
    outlet_location_type VARCHAR(50),
    outlet_type VARCHAR(50),
    item_outlet_sales FLOAT
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/blinkit.grocery.csv'
INTO TABLE blinkit_grocery
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Data Exploration
-- Count of Rows
SELECT COUNT(*) FROM blinkit_grocery;

-- Sample Data
SELECT * FROM blinkit_grocery
LIMIT 10;

-- Null Values
SELECT * FROM blinkit_grocery
WHERE item_identifier IS NULL
OR
item_weight IS NULL
OR
item_fat_content IS NULL
OR
item_visibility IS NULL
OR
item_type IS NULL
OR
item_MRP IS NULL
OR
outlet_identifier IS NULL
OR
outlet_establishment_year IS NULL
OR
outlet_size IS NULL
OR
outlet_location_type IS NULL
or
outlet_type IS NULL
OR
item_outlet_sales IS NULL;

-- Check distinct values in categorical columns

SELECT DISTINCT item_fat_content FROM blinkit_grocery;
SET SQL_SAFE_UPDATES = 0;
UPDATE Blinkit_grocery
SET item_fat_content = 'Regular'
WHERE item_fat_content = 'reg';

UPDATE Blinkit_grocery
SET item_fat_content = 'Low Fat'
WHERE item_fat_content IN ('LF', 'lf', 'Lf');

SELECT DISTINCT item_type FROM Blinkit_grocery;
SELECT DISTINCT outlet_size FROM Blinkit_grocery;

SET SQL_SAFE_UPDATES = 0;

UPDATE Blinkit_grocery
SET outlet_size = 'Medium'
WHERE outlet_size IS NULL OR outlet_size = '0';

SET SQL_SAFE_UPDATES = 1;  
SELECT DISTINCT outlet_size FROM Blinkit_grocery;

SELECT DISTINCT outlet_location_type FROM Blinkit_grocery;
SELECT DISTINCT outlet_type FROM Blinkit_grocery;

-- Question 1: List all items with MRP greater than 200.

SELECT item_identifier, item_type, item_MRP
FROM Blinkit_grocery
WHERE item_MRP > 200;

-- Question 2: Count the no. of Outlets by Outlet Type.
SELECT outlet_type, COUNT(DISTINCT outlet_identifier) AS outlet_count
FROM Blinkit_grocery
GROUP BY outlet_type;

-- Question 3: Calculate average MRP by item type.

SELECT item_type, AVG(item_MRP) AS avg_MRP
FROM Blinkit_grocery
GROUP BY item_type;

-- Question 4: Find items with low fat content.

SELECT item_identifier, item_fat_content, item_type
FROM Blinkit_grocery
WHERE item_fat_content = 'low fat';

-- Question 5: Calculate total sales by outlet size.

SELECT outlet_size, SUM(item_outlet_sales) AS total_sales
FROM Blinkit_grocery
GROUP BY outlet_size
ORDER BY total_sales DESC;

-- Question 6: Top 5 selling items across all outlets.

SELECT item_identifier, item_type, SUM(item_outlet_sales) AS total_sales
FROM Blinkit_grocery
GROUP BY item_identifier, item_type
ORDER BY total_sales DESC
LIMIT 5;

-- Question 7: Outlet with the highest average MRP.

SELECT outlet_identifier, outlet_type, AVG(item_MRP) AS avg_MRP
FROM Blinkit_grocery
GROUP BY outlet_identifier, outlet_type
ORDER BY avg_MRP DESC
LIMIT 1;

-- Question 8: Items available in multiple outlet types.

SELECT item_identifier, COUNT(DISTINCT outlet_type) AS outlet_type_count
FROM Blinkit_grocery
GROUP BY item_identifier
HAVING outlet_type_count > 1;

-- Question 9: Year-wise trend of total sales.

SELECT outlet_establishment_year, SUM(item_outlet_sales) AS total_sales
FROM Blinkit_grocery
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year;

-- Question 10: Rank items by sales within each category.

SELECT item_type, item_identifier, 
       SUM(item_outlet_sales) AS total_sales,
       RANK() OVER (PARTITION BY item_type ORDER BY SUM(item_outlet_sales) DESC) AS sales_rank
FROM Blinkit_grocery
GROUP BY item_type, item_identifier;

-- Question 11: Compare total sales of Regular vs low fat items.

SELECT item_fat_content, SUM(item_outlet_sales) AS total_sales
FROM Blinkit_grocery
GROUP BY item_fat_content
ORDER BY total_sales DESC;

-- Question 12: Items with sales above average for their category.

WITH category_avg AS (
    SELECT item_type, AVG(item_outlet_sales) AS avg_sales
    FROM Blinkit_grocery
    GROUP BY item_type
)
SELECT b.item_identifier, b.item_type, b.item_outlet_sales
FROM Blinkit_grocery b
JOIN category_avg c ON b.item_type = c.item_type
WHERE b.item_outlet_sales > c.avg_sales;


