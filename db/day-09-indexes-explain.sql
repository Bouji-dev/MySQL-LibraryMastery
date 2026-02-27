-- befor index
EXPLAIN SELECT * FORM books WHERE author_id = 5;

-- create index
CREATE INDEX idx_books_author ON books(author_id);

-- after index
EXPLAIN SELECT * FORM books WHERE author_id = 5;

-- create composite index
CREATE INDEX   idx_author_pubyear ON books(author_id, publication_year);

EXPLAIN SELECT * FROM books WHERE author_id = 1 ORDER BY publication_year DESC;