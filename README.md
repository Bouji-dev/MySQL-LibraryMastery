# LibraryVault

A complete project-based MySQL mastery course using Python (CLI Library Management System)

## Day 1 – Foundation & First Database

**Title of Day:** Day 1 – MySQL Setup, First Database & Basic Table

**Topic Covered:**
- MySQL 8.4 installation options (Docker / native)
- Creating database with modern charset (utf8mb4)
- Best practices for character set & collation
- Creating table with AUTO_INCREMENT primary key
- InnoDB as default & recommended engine

**Implemented Sections:**
- Created `library_vault` database
- Created `authors` table
- Inserted first test row

**Key Notes:**
- Always use `utf8mb4` + `utf8mb4_0900_ai_ci` for new projects (full emoji & multilingual support)
- InnoDB is the default and safest choice for most use-cases
- `AUTO_INCREMENT` must be part of a key/index
- Case-sensitivity differs between OS (be consistent → lowercase recommended)

## Day 2 – Data Types, Constraints & First Relationship

**Title of Day:** Day 2 – Choosing Proper Data Types + Constraints + Foreign Key

**Topic Covered:**
- Appropriate data types for real-world library data (UNSIGNED, SMALLINT, DECIMAL, TINYINT)
- Constraints: NOT NULL, UNIQUE, DEFAULT, CHECK
- Foreign Key relationship with ON DELETE RESTRICT / ON UPDATE CASCADE
- InnoDB requirement for foreign keys
- Why VARCHAR(255) is not always the best choice

**Implemented Sections:**
- Created `books` table
- Added proper data types and constraints
- Established first Foreign Key (books → authors)
- Inserted test rows
- Demonstrated FK protection (failed delete)

**Key Notes:**
- Use UNSIGNED for non-negative values (ids, counts, years)
- Prefer SMALLINT UNSIGNED for publication_year (covers year 0–65535)
- CHECK constraint is enforced in MySQL 8.0+
- FOREIGN KEY requires InnoDB engine
- ON DELETE RESTRICT prevents deleting authors who have books

## Day 3 – Basic DML & First CRUD Operations

**Title of Day:** Day 3 – INSERT, SELECT, UPDATE, DELETE + Filtering & Sorting

**Topic Covered:**
- DML vs DDL
- INSERT (single & multi-row)
- SELECT with WHERE, LIKE, ORDER BY, LIMIT
- UPDATE & DELETE with mandatory WHERE clause
- Handling NULL values (IS NULL / IS NOT NULL)
- Safe deletion using NOT EXISTS subquery

**Implemented Sections:**
- Added more test data to authors and books
- Performed full CRUD operations
- Demonstrated safe UPDATE/DELETE patterns
- Queried books sorted by year (NULLs last)

**Key Notes:**
- ALWAYS use WHERE with UPDATE and DELETE
- NULL comparison uses IS NULL / IS NOT NULL (not = NULL)
- ORDER BY ... NULLS LAST is very useful (MySQL 8.0.21+) and ISNULL() for older than MySQL 8.0.21
- Multi-row INSERT is more efficient
- Test DELETE with subquery to avoid deleting parents with children
