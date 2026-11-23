-- =====================================================
-- Day 1 Practice: DDL commands and Constraints (MySQL)
-- Run top to bottom. Safe to re-run the CREATE statements
-- (IF NOT EXISTS). The INSERT sections are marked below.
-- =====================================================


-- 1. CREATING DATABASE --
CREATE DATABASE IF NOT EXISTS sales;


-- 2. CREATING TABLES --
USE sales;

CREATE TABLE IF NOT EXISTS stores (
    store_id   INT,
    store_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS stores1 (
    store_id   INT,
    store_name VARCHAR(200)
);


-- 3. INSERT SOME VALUES --
-- (Running this twice will add the rows twice, since stores1 has no constraints.)
INSERT INTO stores1 VALUES
(1, 'ABC'),
(2, 'XYZ');

SELECT * FROM stores1;


-- 4. CONSTRAINTS --
-- store_id must be unique, store_name cannot be empty.
CREATE TABLE IF NOT EXISTS stores_new (
    store_id   INT UNIQUE,
    store_name VARCHAR(200) NOT NULL
);

-- Run this only once. A second run fails with a "Duplicate entry"
-- error, because store_id is UNIQUE. That is the constraint working.
INSERT INTO stores_new VALUES
(3, 'Jatin'),
(4, 'vohra');

SELECT * FROM stores_new;


-- 5. ALTER COMMAND --
-- Add a new column
ALTER TABLE stores_new
ADD COLUMN store_city VARCHAR(200);

-- Rename the column (run once; the second run fails because
-- store_city no longer exists)
ALTER TABLE stores_new
RENAME COLUMN store_city TO store_loc;

-- Check the final structure
DESCRIBE stores_new;
SELECT * FROM stores_new;
