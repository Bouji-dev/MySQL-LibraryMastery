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

## Day 4 – Advanced Filtering & Pattern Matching

**Title of Day:** Day 4 – Powerful WHERE clause (LIKE, REGEXP, IN, BETWEEN, compound conditions)

**Topic Covered:**
- LIKE vs REGEXP (use cases & performance)
- Common LIKE patterns (% , _)
- REGEXP for complex patterns (digits, length, alternations)
- Combining conditions with AND/OR/NOT + parentheses importance
- IN / NOT IN
- BETWEEN
- NULL-safe comparisons (IS NULL / IS NOT NULL)

**Implemented Sections:**
- Multiple pattern-based search queries on books & authors
- Compound conditions with logical operators
- Safe NULL handling
- Sorted and filtered result sets

**Key Notes:**
- LIKE '%...%' usually causes full table scan
- REGEXP almost always full scan
- Parentheses are critical in mixed AND/OR conditions
- NULL comparison must use IS NULL / IS NOT NULL
- Test complex WHERE clauses with SELECT before UPDATE/DELETE


## Day 5 – JOINs & Combining Data from Multiple Tables

**Title of Day:** Day 5 – INNER JOIN, LEFT JOIN, RIGHT JOIN + combined reports

**Topic Covered:**
- Difference between INNER, LEFT, RIGHT JOIN
- Using table aliases for readability
- Joining on foreign key (author_id → authors.id)
- Handling missing matches (NULL values in LEFT JOIN)
- Aggregate with JOIN (COUNT books per author)
- Finding max value per group with subquery + JOIN

**Implemented Sections:**
- Basic INNER JOIN for matched records
- LEFT JOIN to include all books/authors
- Counting books per author (including zero)
- Finding most expensive book per author

**Key Notes:**
- INNER JOIN = only matching rows from both tables
- LEFT JOIN = all from left table + matching from right (NULL if no match)
- Always write ON condition to avoid accidental CROSS JOIN
- Use aliases (b for books, a for authors) in every real project
- Test JOIN with small SELECT before adding GROUP BY / aggregates


## Day 6 – Aggregation, GROUP BY & HAVING

**Title of Day:** Day 6 – GROUP BY, Aggregate Functions, HAVING + statistical reports

**Topic Covered:**
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
- GROUP BY clause
- HAVING vs WHERE
- Combining JOIN + GROUP BY
- Grouping by calculated values (decade example)
- Finding max/min per group with subquery

**Implemented Sections:**
- Books count per author (including zero)
- Average price per author with minimum book count filter
- Total price of available books
- Most expensive book per author
- Books count by decade

**Key Notes:**
- Non-aggregated columns in SELECT must appear in GROUP BY
- HAVING filters groups (after aggregation), WHERE filters rows (before)
- Use LEFT JOIN when you want to include groups with zero count
- Test aggregate queries with small data first
- FLOOR(year / 10) * 10 is a common way to group by decade


## Day 7 – Subqueries, CTEs & Window Functions

**Title of Day:** Day 7 – Subqueries (scalar/correlated), Common Table Expressions, basic Window Functions

**Topic Covered:**
- Subquery in WHERE, SELECT, FROM
- Correlated vs non-correlated subqueries
- CTE (WITH clause) for readability and reuse
- Window Functions: ROW_NUMBER, RANK, DENSE_RANK
- PARTITION BY + ORDER BY in OVER clause
- Combining CTE/Subquery with JOIN

**Implemented Sections:**
- Books more expensive than average
- Authors with expensive books (subquery IN)
- Global and per-author ranking with ROW_NUMBER
- Second most expensive book with DENSE_RANK
- CTE for average price comparison

**Key Notes:**
- Correlated subqueries can be slow on large tables
- CTE improves readability and allows reuse
- Window functions keep all rows (unlike GROUP BY)
- Always include OVER clause in window functions
- Subquery in FROM needs alias


## Day 8 – Views & Materialized Views Workaround

**Title of Day:** Day 8 – Creating, using and managing Views + workaround for Materialized Views in MySQL

**Topic Covered:**
- What is a View (virtual table)
- Simple vs Complex Views
- Updatable Views rules and limitations
- Security & abstraction benefits
- Materialized Views absence in MySQL → workaround with physical table + triggers + events
- Refresh strategies (trigger-based, scheduled event)

**Implemented Sections:**
- View for available books with author names
- View for most expensive book per author
- Physical table + trigger for author book count
- Event scheduler for periodic refresh

**Key Notes:**
- Views are just stored queries – executed on the fly
- Complex Views are read-only in most cases
- Updatable Views have strict rules (single table, no aggregates, etc.)
- Materialized Views workaround is common: table + triggers + events
- Always test performance when using Views in production

## Day 9 – Indexes, EXPLAIN & Performance Tuning

**Title of Day:** Day 9 – Understanding Indexes, creating them, analyzing queries with EXPLAIN

**Topic Covered:**
- What is an Index and how it speeds up queries
- Types: PRIMARY, UNIQUE, INDEX, FULLTEXT, Composite
- Creating / Dropping / Viewing Indexes
- EXPLAIN output analysis (type, key, rows, Extra)
- Best practices for indexing foreign keys, WHERE, ORDER BY columns
- Trade-offs: speed vs write performance & disk space

**Implemented Sections:**
- Added indexes on author_id, composite (author_id + year), price
- Compared EXPLAIN before/after indexing
- Tested FULLTEXT search on title
- Analyzed selectivity and useless indexes

**Key Notes:**
- Index on foreign keys is almost always necessary
- Composite index order matters (leftmost prefix rule)
- EXPLAIN 'type=ALL' → full scan → add index!
- Over-indexing slows down writes and wastes space
- FULLTEXT for natural language search, not exact matches
