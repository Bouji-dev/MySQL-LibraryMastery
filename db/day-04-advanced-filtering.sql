-- 1. Find books that have no isbn and price > 120000
SELECT title, isbn, price, publication_year
FROM books
WHERE isbn IS NULL
AND price > 120000;

-- 2. Find books whose title contains at least one digit (use REGEXP)
SELECT title, publication_year, page_count
FROM books
WHERE title REGEXP '[0-9]';

-- 3. Find books published before 1350 OR with price > 200000
SELECT title, publication_year, price, is_available
FROM books
WHERE publication_year < 1350
OR price > 200000;

-- 4. Find books whose author's name contains 'z' or 'gh' and book is available (is_available = 1)
SELECT 
    b.title,
    b.price,
    b.is_available,
    a.full_name AS author_name
FROM books b
INNER JOIN authors a ON b.author_id = a.id
WHERE (a.full_name LIKE '%z%' OR a.full_name LIKE '%gh%')
AND b.is_available = 1;

-- 5. Find books whose title starts with 'ch' or 's' and page_count > 250
SELECT title, page_count, publication_year
FROM books
WHERE (title LIKE 'ch%' OR title LIKE 's%')
AND page_count > 250;

-- 6. Find books whose isbn starts with '978964' and publication_year > 1375
SELECT title, isbn, publication_year, price
FROM books
WHERE isbn LIKE '978964%'
AND publication_year > 1375;

-- 7. Show unavailable books (is_available = 0) sorted by price descending 
--    (only title, price, year)
SELECT title, price, publication_year
FROM books
WHERE is_available = 0
ORDER BY price DESC;