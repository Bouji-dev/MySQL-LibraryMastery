-- 1. books which is expensive than average
SELECT title, price
FROM books
WHERE price > (SELECT AVG(price) FROM books);

-- 2. authors with price greater than 200000
SELECT DISTINCT a.full_name
FROM authors a
INNER JOIN books b ON a.id = b.author_id
WHERE b.price > 200000;

-- 2. authors with price greater than 200000 (with subquery)
SELECT full_name
FROM authors
WHERE id IN (
    SELECT author_id 
    FROM books 
    WHERE price > 200000
);

-- 3. ranking base on price
SELECT 
    title,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS rank
FROM books;

-- 4. Numbering of books in each author
SELECT 
    a.full_name,
    b.title,
    b.price,
    ROW_NUMBER() OVER (
        PARTITION BY a.id 
        ORDER BY b.price DESC
    ) AS book_rank_in_author
FROM authors a
LEFT JOIN books b ON a.id = b.author_id;

-- 5. second expensive book (DENSE_RANK)
SELECT title, price
FROM (
    SELECT 
        title,
        price,
        DENSE_RANK() OVER (ORDER BY price DESC) AS rnk
    FROM books
) t
WHERE rnk = 2;

-- 6. with CTE
WITH avg_price AS (
    SELECT AVG(price) AS avg_p
    FROM books
)
SELECT 
    b.title,
    b.price,
    ap.avg_p AS average_price
FROM books b
CROSS JOIN avg_price ap
WHERE b.price > ap.avg_p;