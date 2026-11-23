# 📘 SQL Learning Notes

My 3-day journey to learn SQL (MySQL): notes, practice code and 3 projects (basic, mid, high).

> **How to use this README:** Read the **Quick Revision Cheat Sheet** (section 7) first. If something is unclear, jump to the detailed section. Then re-run the code in `practice.sql` to refresh your memory.

---

## 📌 Progress Tracker

| Day | Topics | Status |
|-----|--------|--------|
| Day 1 | Database basics, SQL intro, DDL commands, Constraints | ✅ Done |
| Day 2 | _(add topics here as you learn)_ | ⬜ Pending |
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