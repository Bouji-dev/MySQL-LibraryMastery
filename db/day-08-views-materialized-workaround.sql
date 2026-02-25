-- 1. View - available books by author
CREATE VIEW available_books_with_author AS
SELECT 
    b.title,
    b.price,
    b.is_available,
    a.full_name AS author_name
FROM books b
INNER JOIN authors a ON b.author_id = a.id
WHERE b.is_available = 1;

-- 2. View -  the most expensive book by any author
CREATE VIEW most_expensive_per_author AS
SELECT 
    a.full_name,
    b.title,
    b.price,
    b.publication_year
FROM authors a
INNER JOIN books b ON a.id = b.author_id
WHERE b.price = (
    SELECT MAX(price)
    FROM books b2
    WHERE b2.author_id = a.id
);

-- Auxiliary table for keeping the number of books per author
CREATE TABLE author_book_stats (
    author_id       INT UNSIGNED PRIMARY KEY,
    full_name       VARCHAR(120) NOT NULL,
    book_count      INT UNSIGNED NOT NULL DEFAULT 0,
    last_updated    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_author_name (full_name)
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


-- insert first data (execute once)
INSERT INTO author_book_stats (author_id, full_name, book_count)
SELECT 
    a.id,
    a.full_name,
    COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.id, a.full_name
ON DUPLICATE KEY UPDATE 
    book_count = VALUES(book_count);

DELIMITER //

--  after INSERT new book
CREATE TRIGGER trg_after_insert_book
AFTER INSERT ON books
FOR EACH ROW
BEGIN
    INSERT INTO author_book_stats (author_id, full_name, book_count)
    SELECT 
        a.id,
        a.full_name,
        COUNT(b.id)
    FROM authors a
    LEFT JOIN books b ON a.id = b.author_id
    WHERE a.id = NEW.author_id
    GROUP BY a.id, a.full_name
    ON DUPLICATE KEY UPDATE 
        book_count = VALUES(book_count),
        last_updated = NOW();
END //

--  after DELETE book
CREATE TRIGGER trg_after_delete_book
AFTER DELETE ON books
FOR EACH ROW
BEGIN
    INSERT INTO author_book_stats (author_id, full_name, book_count)
    SELECT 
        a.id,
        a.full_name,
        COUNT(b.id)
    FROM authors a
    LEFT JOIN books b ON a.id = b.author_id
    WHERE a.id = OLD.author_id
    GROUP BY a.id, a.full_name
    ON DUPLICATE KEY UPDATE 
        book_count = VALUES(book_count),
        last_updated = NOW();
END //

-- after UPDATE (if author_id change )
CREATE TRIGGER trg_after_update_book_author
AFTER UPDATE ON books
FOR EACH ROW
BEGIN
    -- if author_id has changed
    IF NEW.author_id <> OLD.author_id OR NEW.author_id IS NULL OR OLD.author_id IS NULL THEN
        -- old author
        INSERT INTO author_book_stats (author_id, full_name, book_count)
        SELECT 
            a.id,
            a.full_name,
            COUNT(b.id)
        FROM authors a
        LEFT JOIN books b ON a.id = b.author_id
        WHERE a.id = OLD.author_id
        GROUP BY a.id, a.full_name
        ON DUPLICATE KEY UPDATE 
            book_count = VALUES(book_count),
            last_updated = NOW();

        -- new author
        INSERT INTO author_book_stats (author_id, full_name, book_count)
        SELECT 
            a.id,
            a.full_name,
            COUNT(b.id)
        FROM authors a
        LEFT JOIN books b ON a.id = b.author_id
        WHERE a.id = NEW.author_id
        GROUP BY a.id, a.full_name
        ON DUPLICATE KEY UPDATE 
            book_count = VALUES(book_count),
            last_updated = NOW();
    END IF;
END //

DELIMITER ;