# 📘 SQL Learning Notes

My 3-day journey to learn SQL (MySQL): notes, practice code and 3 projects (basic, mid, high).

> **How to use this README:** Read the **Quick Revision Cheat Sheet** (section 7) first. If something is unclear, jump to the detailed section. Then re-run the code in `practice.sql` to refresh your memory.

---

## 📌 Progress Tracker

| Day | Topics | Status |
|-----|--------|--------|
| Day 1 | Database basics, SQL intro, DDL commands, Constraints | ✅ Done |
| Day 2 | Keys, WHERE, LIKE, Group by, Having, ASLIKE, Order by" | ✅ Done |
| Day 3 | _(add topics here as you learn)_ | ⬜ Pending |

| Project | Level | Status |
|---------|-------|--------|
| `project-1-basic` | Basic: Student Records System | ⬜ Pending |
| `project-2-mid` | Mid: multiple tables and JOINs | ⬜ Pending |
| `project-3-high` | High: advanced queries | ⬜ Pending |

---

## 📑 Table of Contents

1. [What is a Database?](#1-what-is-a-database)
2. [What is SQL?](#2-what-is-sql)
3. [Why SQL?](#3-why-sql)
4. [DDL: Data Definition Language](#4-ddl--data-definition-language)
5. [Constraints](#5-constraints)
6. [Practice Code](#6-practice-code)
7. [Quick Revision Cheat Sheet](#7-quick-revision-cheat-sheet)
8. [Common Mistakes (and fixes)](#8-common-mistakes-and-fixes)
9. [How to Run This Code](#9-how-to-run-this-code)
10. [Folder Structure](#10-folder-structure)

---

## 1. What is a Database?

A **database** is an organized collection of data stored electronically.
Think of it as a digital version of an Excel file, but much more powerful: it can store millions of rows, be used by many people at once, and keep the data safe and consistent.

- **Database** → a container (like a folder)
- **Table** → data arranged in rows and columns (like an Excel sheet)
- **Row (record)** → one entry
- **Column (field)** → one property of the entry

---

## 2. What is SQL?

**SQL (Structured Query Language)** is the language used to communicate with a database.
It helps us **store, retrieve and manipulate** data efficiently.

---

## 3. Why SQL?

SQL is the **bridge between humans and data**. We write simple, English-like commands and the database does the heavy work.

---

## 4. DDL – Data Definition Language

**DDL** commands are used to **define, modify or delete the structure** of database objects such as databases, tables and indexes.
They change the *structure*, not the data inside.

| Command | Purpose |
|---------|---------|
| `CREATE` | Create a new database or table |
| `ALTER` | Modify an existing table (add, rename, change or drop columns) |
| `DROP` | Delete a database or table completely |
| `TRUNCATE` | Delete all rows of a table but keep its structure |

### 4.1 CREATE

```sql
-- Create a database
CREATE DATABASE IF NOT EXISTS sales;

-- Select it, so later commands run inside it
USE sales;

-- Create a table
CREATE TABLE stores (
    store_id   INT,
    store_name VARCHAR(200)
);
```

### 4.2 ALTER

```sql
-- Add a column
ALTER TABLE stores_new ADD COLUMN store_city VARCHAR(200);

-- Rename a column (MySQL 8.0+)
ALTER TABLE stores_new RENAME COLUMN store_city TO store_loc;

-- Change the data type of a column
ALTER TABLE stores_new MODIFY COLUMN store_loc VARCHAR(100);

-- Delete a column
ALTER TABLE stores_new DROP COLUMN store_loc;

-- Rename the table
ALTER TABLE stores_new RENAME TO stores_v2;
```

### 4.3 DROP

```sql
DROP TABLE IF EXISTS stores1;       -- deletes the table and its data
DROP DATABASE IF EXISTS sales;      -- deletes the whole database
```

⚠️ DROP cannot be undone. Be careful.

### 4.4 TRUNCATE

```sql
TRUNCATE TABLE stores1;   -- removes all rows, keeps the empty table
```

### DROP vs TRUNCATE (quick comparison)

| | `DROP TABLE` | `TRUNCATE TABLE` |
|---|---|---|
| Removes rows | ✅ | ✅ |
| Removes table structure | ✅ | ❌ (table stays) |
| Can use the table afterwards | ❌ | ✅ |

---

## 5. Constraints

**Constraints** are rules applied to table columns to enforce **data integrity and accuracy**. They make sure the data entered into a database is valid, consistent, and follows the rules you define.

| Constraint | What it does | Example |
|------------|--------------|---------|
| `NOT NULL` | Column cannot be empty | `store_name VARCHAR(200) NOT NULL` |
| `UNIQUE` | No duplicate values allowed in the column | `store_id INT UNIQUE` |
| `PRIMARY KEY` | Uniquely identifies each row (NOT NULL + UNIQUE). One per table | `store_id INT PRIMARY KEY` |
| `CHECK` | Value must satisfy a condition | `age INT CHECK (age >= 18)` |
| `DEFAULT` | Sets a value if none is given | `country VARCHAR(50) DEFAULT 'India'` |

### Example using several constraints

```sql
CREATE TABLE stores_demo (
    store_id   INT PRIMARY KEY,
    store_name VARCHAR(200) NOT NULL,
    store_code VARCHAR(20)  UNIQUE,
    rating     INT          CHECK (rating BETWEEN 1 AND 5),
    country    VARCHAR(50)  DEFAULT 'India'
);
```

> `FOREIGN KEY` (linking two tables) will be covered with JOINs in Project 2.

---

## 6. Practice Code

All the code I practiced on Day 1 is in [`practice.sql`](./practice.sql). It covers:

- Creating a database and tables
- Inserting data
- `UNIQUE` and `NOT NULL` constraints
- `ALTER TABLE`: adding and renaming a column

**Revision tip:** Try to write each command from memory first, then compare with `practice.sql`.

---

## 7. Quick Revision Cheat Sheet

```sql
-- DATABASE
CREATE DATABASE IF NOT EXISTS db_name;
USE db_name;
DROP DATABASE IF EXISTS db_name;
SHOW DATABASES;

-- TABLE
CREATE TABLE table_name (col1 INT, col2 VARCHAR(100));
SHOW TABLES;
DESCRIBE table_name;
DROP TABLE IF EXISTS table_name;
TRUNCATE TABLE table_name;

-- INSERT AND VIEW
INSERT INTO table_name VALUES (1, 'abc'), (2, 'xyz');
SELECT * FROM table_name;

-- ALTER
ALTER TABLE t ADD COLUMN c VARCHAR(100);
ALTER TABLE t RENAME COLUMN old_c TO new_c;
ALTER TABLE t MODIFY COLUMN c VARCHAR(50);
ALTER TABLE t DROP COLUMN c;

-- CONSTRAINTS
NOT NULL | UNIQUE | PRIMARY KEY | CHECK (cond) | DEFAULT value
```

---

## 8. Common Mistakes (and fixes)

| Mistake | Fix |
|---------|-----|
| Forgot `;` at the end of a statement | Every statement ends with `;`, otherwise the next line gets merged into it |
| Typo like `INSERT INTP` | It is `INSERT INTO` |
| No comma between rows in `VALUES` | `(1,'A'),` then `(2,'B');` |
| "Database/Table already exists" error | Use `IF NOT EXISTS` |
| `CREATE TABLE stores;` with no columns | A table needs at least one column |
| Duplicate error when re-running inserts | A `UNIQUE` column rejects the same value twice. Run inserts only once, or `TRUNCATE` first |
| Text in double quotes | Prefer single quotes: `'ABC'` |

---

## 9. How to Run This Code

**Option A: MySQL Workbench (easiest while learning)**
1. Open Workbench and double-click your `local` connection.
2. Paste the SQL in the editor.
3. Run all: **Cmd + Shift + Enter**. Run the current statement: **Cmd + Enter**.

**Option B: VS Code**
1. Install the **SQLTools** and **SQLTools MySQL/MariaDB/TiDB** extensions.
2. Add a MySQL connection (`localhost`, port `3306`, user `root`).
3. Select the code and press **Cmd + E, then Cmd + E**.

Both options use the same MySQL server, so databases created in one show up in the other.

---

## 10. Folder Structure

```
SQL/
├── README.md            ← these notes
├── practice.sql         ← Day 1 practice code
├── project-1-basic/     ← Student Records System
├── project-2-mid/       ← multiple tables and JOINs
└── project-3-high/      ← advanced project
```
---

# 📅 Day 2: Keys, Execution Order and SELECT Queries

**Dataset used:** `ecom` database (star schema): `dim_customer`, `dim_product`, `dim_store`, `dim_date` and `fact_sales`.
**Practice code:** [`day2-practice.sql`](./day2-practice.sql)

---

## 11. Keys

A **key** is a column (or set of columns) used to identify rows or to link tables.

| Key | Meaning | NULL allowed? | How many per table? |
|-----|---------|---------------|---------------------|
| **Primary Key (PK)** | Uniquely identifies each record | ❌ No | Only 1 |
| **Unique Key (UK)** | All values in the column are unique | ✅ Yes (MySQL allows multiple NULLs, SQL Server allows only one) | Many |
| **Foreign Key (FK)** | Links to the primary key of another table | ✅ Yes | Many |
| **Candidate Key** | Any column/set that *could* uniquely identify a row | – | Many |
| **Composite Key** | A key made of 2 or more columns | ❌ (if used as PK) | – |
| **Surrogate Key** | Artificial key, usually auto-increment number | ❌ | – |

### 11.1 Unique Key
Ensures all values in a column (or a combination of columns) are unique. A table can have **multiple** unique keys.
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    email   VARCHAR(100) UNIQUE,
    phone   VARCHAR(20)  UNIQUE
);
```

### 11.2 Primary Key
Uniquely identifies each record. Cannot be NULL. **Only one** primary key per table (it can span several columns, see Composite Key).
```sql
CREATE TABLE dim_store (
    store_key  INT PRIMARY KEY,
    store_name VARCHAR(100)
);
```

### 11.3 Foreign Key
Creates a link between two tables. It makes sure a value in this column **exists in the other table's primary key**.
```sql
CREATE TABLE fact_sales_demo (
    sales_id     INT PRIMARY KEY,
    customer_key INT,
    FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key)
);
```
In `ecom`, `fact_sales` holds foreign keys to all four `dim_` tables. This is exactly how a star schema works.

### 11.4 Candidate Key
A column or set of columns that can uniquely identify a record. A table can have several. **The primary key is chosen from the candidate keys**; the rest are called alternate keys.
Example in `dim_customer`: `customer_key`, `customer_id` and `email` could each identify a customer. We chose `customer_key` as the PK.

### 11.5 Composite Key
A primary key made of **two or more columns**. It identifies a record using the *combination* of columns.
```sql
CREATE TABLE order_items (
    order_id   INT,
    product_id INT,
    quantity   INT,
    PRIMARY KEY (order_id, product_id)
);
```
The same `order_id` can repeat, and so can the same `product_id`, but the same *pair* cannot.

### 11.6 Surrogate Key
An artificial key, usually an auto-increment number with no business meaning. Used when natural keys (like email) are inconvenient or too long.
```sql
CREATE TABLE customers (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,   -- surrogate key
    email        VARCHAR(100) UNIQUE               -- natural key
);
```

---

## 12. SQL Execution Order

We **write** a query in one order, but SQL **runs** it in another.

| Execution step | Clause | What it does |
|:--:|--------|--------------|
| 1 | `FROM` | Picks the table |
| 2 | `WHERE` | Filters **rows** |
| 3 | `GROUP BY` | Groups the rows |
| 4 | `HAVING` | Filters **groups** |
| 5 | `SELECT` | Picks columns / calculates values |
| 6 | `ORDER BY` | Sorts the result |
| 7 | `LIMIT` | Cuts the result to N rows |

```sql
SELECT                                  -- step 5
    category, AVG(unit_price) AS avg_price
FROM dim_product                        -- step 1
WHERE unit_price > 0                    -- step 2
GROUP BY category                       -- step 3
HAVING avg_price > 500                  -- step 4
ORDER BY avg_price DESC                 -- step 6
LIMIT 5;                                -- step 7
```

**Why this matters:** `WHERE` runs *before* `SELECT`, so it cannot use an alias or an aggregate such as `AVG()`. Use `HAVING` for those. (MySQL lets `HAVING` and `ORDER BY` use aliases, but this is a MySQL extra and is not standard SQL.)

---

## 13. SELECT, LIMIT and Indentation

```sql
USE ecom;                                -- choose the database

SELECT * FROM dim_customer;              -- all columns (avoid on big tables)

SELECT first_name, last_name             -- only needed columns
FROM dim_customer
LIMIT 100;                               -- only first 100 rows
```
- `*` means all columns.
- Always add `LIMIT` while exploring big tables (it stops Workbench from hanging).
- Writing each clause on its own line with indentation makes queries easy to read.

---

## 14. WHERE: Filtering Rows

Filters rows **before** grouping. Use `=` (single equals) for comparison, never `==`.

| Operator | Meaning |
|----------|---------|
| `=` | equal to |
| `!=` or `<>` | not equal |
| `>`  `<`  `>=`  `<=` | greater, less |
| `AND` | both conditions true |
| `OR` | at least one true |
| `NOT` | reverses a condition |

```sql
-- Level 1: single condition
SELECT * FROM dim_customer
WHERE gender = 'M';

-- Level 2: AND / OR (use brackets to control the logic)
SELECT * FROM dim_customer
WHERE gender = 'M'
  AND (country = 'China' OR join_date > '2025-04-20');
```

⚠️ **Dates** must be written as `'YYYY-MM-DD'` in quotes. Writing `04/20/2025` is treated as a division, not a date.

**Handy extras:**
```sql
WHERE country IN ('India', 'China', 'USA')        -- match any in a list
WHERE unit_price BETWEEN 100 AND 500              -- inclusive range
WHERE email IS NULL                               -- check for NULL (never "= NULL")
WHERE country NOT IN ('India')
```

---

## 15. LIKE: Pattern Matching

Used for text searches. Two wildcards:

| Wildcard | Meaning |
|----------|---------|
| `%` | any number of characters (including none) |
| `_` | exactly **one** character |

| Pattern | Matches |
|---------|---------|
| `'A%'` | starts with A |
| `'%n'` | ends with n |
| `'A%n'` | starts with A **and** ends with n |
| `'%an%'` | contains "an" anywhere |
| `'A__t%n'` | A + any 2 characters + t + anything + n |

```sql
SELECT * FROM dim_customer WHERE first_name LIKE 'A%';
SELECT * FROM dim_customer WHERE first_name LIKE 'A%n';
SELECT * FROM dim_customer WHERE first_name LIKE 'A__t%n';
```

---

## 16. ORDER BY: Sorting

Default is **ASC** (smallest to largest, A to Z). Use `DESC` for the reverse.
```sql
SELECT * FROM dim_product ORDER BY unit_price;                  -- low to high
SELECT * FROM dim_product ORDER BY unit_price DESC;             -- high to low
SELECT * FROM dim_product ORDER BY category ASC, unit_price DESC;  -- by category, then price
```

---

## 17. Alias (`AS`)

Gives a column or table a temporary, readable name in the result. It does not change the real table.
```sql
SELECT
    product_key,
    brand AS 'Brand name',     -- quotes allow spaces
    category
FROM dim_product;
```
`AS` is optional (`brand b` also works), but writing it keeps the code clear.

---

## 18. GROUP BY and Aggregate Functions

`GROUP BY` puts rows with the same value into one group, then an aggregate function calculates one result per group.

| Function | Returns |
|----------|---------|
| `COUNT()` | number of rows |
| `SUM()` | total |
| `AVG()` | average |
| `MIN()` / `MAX()` | smallest / largest |

```sql
SELECT
    category,
    AVG(unit_price) AS avg_price,
    SUM(unit_price) AS total_price
FROM dim_product
GROUP BY category;
```
**Rule:** every column in `SELECT` that is *not* inside an aggregate function must appear in `GROUP BY`.

---

## 19. HAVING vs WHERE

| | `WHERE` | `HAVING` |
|---|---------|----------|
| Filters | individual **rows** | **groups** |
| Runs | before `GROUP BY` | after `GROUP BY` |
| Can use aggregates (`AVG`, `SUM`)? | ❌ | ✅ |

```sql
SELECT category, AVG(unit_price) AS avg_price
FROM dim_product
GROUP BY category
HAVING avg_price > 500;       -- keep only categories whose average is above 500
```

---

## 20. Day 2 Quick Cheat Sheet

```sql
SELECT col1, col2 AS alias, AGG(col3)
FROM table
WHERE row_condition
GROUP BY col1, col2
HAVING group_condition
ORDER BY col1 DESC
LIMIT 10;

-- Operators:  =  !=  >  <  >=  <=  AND  OR  NOT  IN  BETWEEN  LIKE  IS NULL
-- Wildcards:  %  (many)    _  (one)
-- Aggregates: COUNT  SUM  AVG  MIN  MAX
-- Execution:  FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY > LIMIT
```

## 21. Common Mistakes (Day 2)

| Mistake | Fix |
|---------|-----|
| `WHERE gender == 'M'` | Use a single `=` |
| `join_date > 04/20/2025` | `join_date > '2025-04-20'` |
| `avg_price >. 500` (typo) | `avg_price > 500` |
| Using `AVG()` or an alias in `WHERE` | Use `HAVING` |
| `WHERE email = NULL` | `WHERE email IS NULL` |
| Column in `SELECT` missing from `GROUP BY` | Add it to `GROUP BY` or wrap it in an aggregate |
| Filtering on a column the table doesn't have (e.g. `country` in `dim_product`) | Check columns first with `DESCRIBE dim_product;` |
| `SELECT *` on a big table | Add `LIMIT` |
