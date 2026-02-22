-- 1. Counts book of each author (Ziro included)
SELECT 
    a.full_name,
    COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.full_name
ORDER BY book_count DESC;

-- 2. Average price of each author (Min 2 book)
SELECT 
    a.full_name,
    AVG(b.price) AS avg_price,
    COUNT(b.id) AS book_count
FROM authors a
INNER JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.full_name
HAVING COUNT(b.id) >= 2
ORDER BY avg_price DESC;

-- 3. Authors with more than 3 books
SELECT 
    a.full_name,
    COUNT(b.id) AS book_count
FROM authors a
INNER JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.full_name
HAVING COUNT(b.id) > 3;

-- 4. Sum of price of available books
SELECT 
    SUM(price) AS total_available_price
FROM books
WHERE is_available = 1;

-- 5. The most expensive book of each author
SELECT 
    a.full_name,
    b.title,
    b.price
FROM authors a
INNER JOIN books b ON a.id = b.author_id
INNER JOIN (
    SELECT author_id, MAX(price) AS max_price
    FROM books
    GROUP BY author_id
) mp ON b.author_id = mp.author_id AND b.price = mp.max_price;

-- 6. Number of books in each decade
SELECT 
    FLOOR(publication_year / 10) * 10 AS decade,
    COUNT(*) AS book_count
FROM books
WHERE publication_year IS NOT NULL
GROUP BY decade
ORDER BY decade;