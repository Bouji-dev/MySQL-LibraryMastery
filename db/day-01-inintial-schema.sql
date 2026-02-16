-- 1. create database
CREATE DATABASE library_vault
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

-- 2. select
USE library_vault;

-- 3. create table
CREATE TABLE authors(
    id          INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(120) NOT NULL,
    create_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;

-- 4. test
INSERT INTO authors (full_name) VALUES ('Jalal Al Ahmad');

-- 5. show
SELECT * FROM authors;