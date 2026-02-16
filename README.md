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

