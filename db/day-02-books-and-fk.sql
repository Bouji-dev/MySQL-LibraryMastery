USE library_vault;

-- ┌──────────────────────────────────────────────┐
-- │             (books table)                    │
-- └──────────────────────────────────────────────┘
CREATE TABLE books (
    id              INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    
    title           VARCHAR(300) NOT NULL,
    isbn            VARCHAR(20)  UNIQUE,               
    
    author_id       INT UNSIGNED NOT NULL,
    
    publication_year SMALLINT UNSIGNED,
    page_count      SMALLINT UNSIGNED,
    
    price           DECIMAL(10,2) DEFAULT 0.00,
    
    is_available    TINYINT UNSIGNED NOT NULL DEFAULT 1 
                    CHECK (is_available IN (0, 1, 2)),  
    
    created_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- Relationship with authors table
    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id) 
        REFERENCES authors(id)
        ON DELETE RESTRICT          
        ON UPDATE CASCADE
) ENGINE=InnoDB           
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


-- ┌──────────────────────────────────────────────┐
-- │                   tests                      │
-- └──────────────────────────────────────────────┘
INSERT INTO books (title, isbn, author_id, publication_year, page_count, price, is_available)
VALUES 
    ('The little prince', '978-964-369-001-4', 1, 1943, 96, 85000.00, 1),
    ('School manager', NULL, 1, 1958, 144, 65000.00, 1),
    ('Blind owl', '978-964-448-001-0', 2, 1937, 112, 95000.00, 0);