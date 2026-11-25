-- =====================================================
-- Day 3 Practice: Joins, DML, Transformations
-- =====================================================


-- ---------- SETUP: demo tables for joins ----------
-- (own database, so your other data is not touched)
CREATE DATABASE IF NOT EXISTS joins_demo;
USE joins_demo;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    id    INT PRIMARY KEY,
    name  VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id  INT,
    amount   DECIMAL(10,2)
);

INSERT INTO customers VALUES
(101, 'Aman',   'aman@mail.com'),
(102, 'Simran', 'simran@mail.com'),
(103, 'Rohit',  'rohit@mail.com'),
(104, 'Priya',  'cc');

INSERT INTO orders VALUES
(1, 101, 500.00),
(2, 101, 250.00),
(3, 102, 800.00),
(4, 999, 100.00);     -- 999 has no matching customer


-- ---------- 1. JOINS ----------
-- INNER JOIN: only matching rows
SELECT *
FROM orders o
INNER JOIN customers c
    ON o.cust_id = c.id;

-- LEFT JOIN: all orders, even without a customer
SELECT *
FROM orders o
LEFT JOIN customers c
    ON o.cust_id = c.id;

-- RIGHT JOIN: all customers, even without orders
SELECT *
FROM orders o
RIGHT JOIN customers c
    ON o.cust_id = c.id;

-- FULL JOIN: MySQL does not support it,
-- so use LEFT JOIN + UNION + RIGHT JOIN
SELECT *
FROM orders o
LEFT JOIN customers c
    ON o.cust_id = c.id

UNION

SELECT *
FROM orders o
RIGHT JOIN customers c
    ON o.cust_id = c.id;

-- Find unmatched rows: orders that have no customer
SELECT o.order_id, o.cust_id
FROM orders o
LEFT JOIN customers c
    ON o.cust_id = c.id
WHERE c.id IS NULL;


-- ---------- 2. DML COMMANDS ----------
-- UPDATE
UPDATE customers
SET name = 'ABC'
WHERE id = 101;

SELECT * FROM customers;

-- DELETE
DELETE FROM customers
WHERE email = 'cc';

SELECT * FROM customers;


-- ---------- 3. JOIN ON THE REAL ecom DATA ----------
USE ecom;

SELECT
    c.country,
    SUM(f.total_amount) AS total_sales
FROM fact_sales f
INNER JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_sales DESC;


-- ---------- 4. TRANSFORMATIONS ----------
-- 4.1 Numeric
SELECT
    unit_price,
    unit_price * 0.90    AS dis_price,
    unit_price + 10      AS price_plus_10,
    unit_price / 10      AS frac_price,
    ROUND(unit_price, 1) AS rounded_price
FROM dim_product
LIMIT 20;

-- 4.2 Date: current date and time
SELECT
    NOW()           AS 'current_timestamp',
    UTC_DATE(),
    UTC_TIME(),
    UTC_TIMESTAMP();

-- 4.3 Date: extract and calculate
SELECT
    date,
    YEAR(date),
    MONTH(date),
    DAY(date),
    DAYNAME(date),
    WEEKDAY(date),
    DATE(UTC_TIMESTAMP())  AS today_utc,
    ADDDATE(date, 2)       AS plus_2_days,
    SUBDATE(date, 2)       AS minus_2_days,
    DATEDIFF(DATE(UTC_TIMESTAMP()), date) AS days_since
FROM
    dim_date
LIMIT 20;