-- 1. All books + their authors
SELECT 
    b.title,
    b.publication_year,
    b.price,
    a.full_name AS author_name
FROM books b
LEFT JOIN authors a ON b.author_id = a.id;

-- 2. All authors with their books (even has no book)
SELECT 
    a.full_name,
    b.title,
    b.price
FROM authors a
LEFT JOIN books b ON a.id = b.author_id;


-- 3. Just books which has authors (INNER JOIN)
SELECT 
    b.title,
    a.full_name
FROM books b
INNER JOIN authors a ON b.author_id = a.id;

-- 4. books which their authors name including with 's' 
SELECT 
    b.title,
    a.full_name
FROM books b
INNER JOIN authors a ON b.author_id = a.id
WHERE a.full_name LIKE '%s%';

-- 5. Number of books of each author
SELECT 
    a.full_name,
    COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.full_name
ORDER BY book_count DESC;


-- 6. The most expensive book of each author
SELECT 
    a.full_name,
    b.title,
    b.price,
    b.publication_year
FROM authors a
INNER JOIN books b ON a.id = b.author_id
INNER JOIN (
    SELECT author_id, MAX(price) AS max_price
    FROM books
    GROUP BY author_id
) maxp ON b.author_id = maxp.author_id AND b.price = maxp.max_price;