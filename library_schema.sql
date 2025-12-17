-- Reset existing tables (drop in reverse FK order)
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;

-------------------------------------------------------
-- CREATE TABLES
-------------------------------------------------------

CREATE TABLE Authors (
    author_id INTEGER PRIMARY KEY, 
    name TEXT,
    country TEXT
);

CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY,
    title TEXT,
    author_id INTEGER,
    genre TEXT,
    year_published INTEGER,
    available INTEGER,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE members (
    member_id INTEGER PRIMARY KEY,
    name TEXT,
    join_date TEXT
);

CREATE TABLE Loans (
    loan_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    member_id INTEGER,
    loan_date TEXT,
    return_date TEXT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

-------------------------------------------------------
-- INSERT DATA
-------------------------------------------------------

INSERT INTO Authors VALUES (1, 'J.K. Rowling', 'UK');
INSERT INTO Authors VALUES (2, 'George R.R. Martin', 'USA');
INSERT INTO Authors VALUES (3, 'Haruki Murakami', 'Japan');
INSERT INTO Authors VALUES (4, 'Isabel Allende', 'Chile');
INSERT INTO Authors VALUES (5, 'Chinua Achebe', 'Nigeria');
INSERT INTO Authors VALUES (6, 'Margaret Atwood', 'Canada');
INSERT INTO Authors VALUES (7, 'Gabriel Garcia Marquez', 'Colombia');
INSERT INTO Authors VALUES (8, 'Fyodor Dostoevsky', 'Russia');
INSERT INTO Authors VALUES (9, 'Jane Austen', 'UK');
INSERT INTO Authors VALUES (10, 'Mark Twain', 'USA');
INSERT INTO Authors VALUES (11, 'Leo Tolstoy', 'Russia');
INSERT INTO Authors VALUES (12, 'Ernest Hemingway', 'USA');
INSERT INTO Authors VALUES (13, 'Toni Morrison', 'USA');
INSERT INTO Authors VALUES (14, 'Khaled Hosseini', 'Afghanistan');
INSERT INTO Authors VALUES (15, 'J.R.R. Tolkien', 'UK');
INSERT INTO Authors VALUES (16, 'C.S. Lewis', 'UK');
INSERT INTO Authors VALUES (17, 'Virginia Woolf', 'UK');
INSERT INTO Authors VALUES (18, 'James Baldwin', 'USA');
INSERT INTO Authors VALUES (19, 'Salman Rushdie', 'India');
INSERT INTO Authors VALUES (20, 'Alice Walker', 'USA');

.exit