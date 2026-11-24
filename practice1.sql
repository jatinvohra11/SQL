-- =====================================================
-- Day 2 Practice: SELECT, WHERE, LIKE, ORDER BY,
-- GROUP BY, HAVING   (database: ecom)
-- =====================================================

USE ecom;

-- 1. FIRST SELECT --
SELECT * FROM dim_customer LIMIT 10;

-- 2. SPECIFIC COLUMNS + LIMIT --
SELECT
    first_name,
    last_name
FROM
    dim_customer
LIMIT 100;


-- 3. WHERE CLAUSE --
-- Level 1
SELECT *
FROM dim_customer
WHERE gender = 'M'
LIMIT 20;

-- Level 2 (AND / OR)
SELECT *
FROM dim_customer
WHERE gender = 'M'
  AND (country = 'China' OR join_date > '2025-04-20')
LIMIT 20;

-- Extras: IN, BETWEEN, IS NULL
SELECT * FROM dim_customer WHERE country IN ('India', 'China') LIMIT 20;
SELECT * FROM dim_product  WHERE unit_price BETWEEN 100 AND 500 LIMIT 20;
SELECT * FROM dim_customer WHERE email IS NULL LIMIT 20;


-- 4. LIKE OPERATOR --
-- starts with A
SELECT * FROM dim_customer WHERE first_name LIKE 'A%' LIMIT 20;

-- starts with A and ends with n
SELECT * FROM dim_customer WHERE first_name LIKE 'A%n' LIMIT 20;

-- A + any 2 characters + t + anything + n
SELECT * FROM dim_customer WHERE first_name LIKE 'A__t%n' LIMIT 20;

-- contains "an" anywhere
SELECT * FROM dim_customer WHERE first_name LIKE '%an%' LIMIT 20;


-- 5. SORTING (default is ASC) --
SELECT * FROM dim_product ORDER BY unit_price LIMIT 20;
SELECT * FROM dim_product ORDER BY unit_price DESC LIMIT 20;
SELECT * FROM dim_product ORDER BY category ASC, unit_price DESC LIMIT 20;


-- 6. ALIAS --
SELECT
    product_key,
    product_id,
    brand AS 'Brand name',
    category
FROM
    dim_product
LIMIT 20;


-- 7. GROUPING --
-- 7.1 aggregate per category
SELECT
    category,
    AVG(unit_price) AS 'AVERAGE PRICE',
    SUM(unit_price) AS 'TOTAL PRICE'
FROM
    dim_product
GROUP BY
    category;

-- 7.2 HAVING (filter groups)
SELECT
    category,
    AVG(unit_price) AS avg_price,
    SUM(unit_price) AS total_price
FROM
    dim_product
GROUP BY
    category
HAVING
    avg_price > 500;

-- 7.3 full execution-order example
SELECT
    category,
    AVG(unit_price) AS avg_price
FROM dim_product
WHERE unit_price > 0
GROUP BY category
HAVING avg_price > 500
ORDER BY avg_price DESC
LIMIT 5;

-- 7.4 COUNT per group
SELECT country, COUNT(*) AS total_customers
FROM dim_customer
GROUP BY country
ORDER BY total_customers DESC;