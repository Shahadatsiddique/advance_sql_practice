# Create a view named AvailableBooks using your existing Books table. The view should display only books where available_copies > 0.
CREATE VIEW AvailableBooks AS
SELECT
    book_id,
    title,
    author,
    available_copies
FROM Books
WHERE available_copies > 0;
SELECT * FROM AvailableBooks;


# create view AvailableBooksSorted from books where available_copies > 0 and Sort by available_copies in descending order
CREATE VIEW AvailableBooksSorted AS
SELECT
    book_id,
    title,
    available_copies
FROM Books
WHERE available_copies > 0

SELECT *
FROM AvailableBooksSorted
ORDER BY available_copies DESC;



# Write a CREATE OR REPLACE VIEW query to update AvailableBooks to display book_id, title, author, genre, and available_copies, including only books where available_copies > 0.
CREATE OR REPLACE VIEW AvailableBooks AS
SELECT book_id, title, author, genre, available_copies
FROM Books
WHERE available_copies > 0;



# Write a query to delete the AvailableBooksSorted view without deleting the original Books table.
DROP VIEW AvailableBooksSorted;



# Write a query to create a view named BookInventory showing each book's book_id, title, total_copies, and available_copies, including all books regardless of availability.
CREATE VIEW BookInventory AS
SELECT
    book_id,
    title,
    total_copies,
    available_copies
FROM Books;
SELECT * FROM BookInventory;


# Create a view named TechnologyBooks showing book_id, title, author, and available_copies for books whose genre is 'Technology'.
CREATE VIEW TechnologyBooks AS
SELECT book_id, title, author, available_copies
FROM Books
WHERE genre = 'Technology';
select * from TechnologyBooks;



# Create a view named LowStockBooks showing book_id, title, and available_copies for books with fewer than 3 available copies.
CREATE VIEW LowStockBooks AS
SELECT book_id, title, available_copies
FROM Books
WHERE available_copies < 3;
select * from LowStockBooks;



# Create a view named BookAuthors showing each book's title and author, but only for books whose author is 'James Clear'
CREATE VIEW BookAuthors AS
SELECT title, author
FROM Books
WHERE author = 'James Clear';
select * from BookAuthors;



# Create a view named RecentlyIssuedBooks showing issue_id, book_id, member_id, and issue_date from the Issued_Books table for records where issue_date is after '2026-10-05'.
CREATE VIEW RecentlyIssuedBooks AS
SELECT issue_id, book_id, member_id, issue_date
FROM Issued_Books
WHERE issue_date > '2026-10-05';
select * from RecentlyIssuedBooks;



# Create a view named UnreturnedBooks showing issue_id, book_id, member_id, and issue_date for books that have not yet been returned (return_date IS NULL).
CREATE VIEW UnreturnedBooks AS
SELECT issue_id, book_id, member_id, issue_date
FROM Issued_Books
WHERE return_date IS NULL;
select * from UnreturnedBooks;



# Create a view named MemberIssueCount showing each member_id and the total number of books issued by that member using the Issued_Books table.
CREATE VIEW MemberIssueCount AS
SELECT
    member_id,
    COUNT(issue_id) AS total_issues
FROM Issued_Books
GROUP BY member_id;



# Create a view named BookIssueCount showing each book_id and the total number of times that book appears in Issued_Books, using COUNT() and GROUP BY.
CREATE VIEW BookIssueCount AS
SELECT
    book_id,
    COUNT(issue_id) AS total_issues
FROM Issued_Books
GROUP BY book_id;



# reate a view named ReturnedBooks showing issue_id, book_id, member_id, and return_date for records where return_date IS NOT NULL.
CREATE VIEW ReturnedBooks AS
SELECT issue_id, book_id, member_id, return_date
FROM Issued_Books
WHERE return_date IS NOT NULL;



# Create BooksWithMultipleIssues which Show books that have been issued more than once, with their book_id and total issue count.
CREATE VIEW BooksWithMultipleIssues AS
SELECT
    book_id,
    COUNT(issue_id) AS total_issues
FROM Issued_Books
GROUP BY book_id
HAVING COUNT(issue_id) > 1;



# Create MemberIssueSummary which Show each member's member_id, total issues, returned issues, and unreturned issues.
CREATE VIEW MemberIssueSummary AS
SELECT
    member_id,
    COUNT(issue_id) AS total_issues,
    SUM(CASE
        WHEN return_date IS NOT NULL THEN 1
        ELSE 0
    END) AS returned_issues,
    SUM(CASE
        WHEN return_date IS NULL THEN 1
        ELSE 0
    END) AS unreturned_issues
FROM Issued_Books
GROUP BY member_id;
