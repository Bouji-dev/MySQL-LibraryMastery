-- add many authors
INSERT INTO authors (full_name) VALUES
    ('Bouji'),
    ('Shapour'),
    ('Pishuli'),
    ('Mashmol');

-- add a book without isbn
INSERT INTO books (title, author_id, publication_year, page_count, price, is_available)
VALUES ('House of darkness', 4, 1992, 230, 123000, 1);    

-- update name
UPDATE authors
SET full_name = 'Ehsan'
WHERE full_name = 'Jalal Al Ahmad';

-- update
UPDATE books
SET isbn = '978-988-99-1234-5'
WHERE isbn IS NULL AND title = 'House of darkness';

-- delete
DELETE FROM authors
WHERE id = 3
AND NOT EXISTS (SELECT 1 FROM  books WHERE author_id = authors.id);

-- desc show
SELECT title, publication_year, author_id
FROM books
ORDER BY publication_year DESC;
