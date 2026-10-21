# Using your existing Books table, write a SQL query to create an index named idx_books_title on the title column.
CREATE INDEX idx_books_title
ON Books(title);


# Write a SQL query to create an index named idx_members_email on the email column of your Members table.
CREATE INDEX idx_members_email
ON Members(email);


# use EXPLAIN to check the query's execution plan.
EXPLAIN
SELECT *
FROM Books
WHERE title = 'Atomic Habits';


# Write the SQL command to display all indexes on the Books table
SHOW INDEX FROM Books;


# You have an index on Books(title). Now write a SQL command to remove the index idx_books_title from the Books table.
DROP INDEX idx_books_title ON Books;


# Write a query to display the execution plan for finding a member whose email is 'rahul@example.com'.
EXPLAIN
SELECT *
FROM Members
WHERE email = 'rahul@example.com';


# Write a query to find all books whose available_copies is greater than 2, and use EXPLAIN to inspect its execution plan.
EXPLAIN
SELECT *
FROM Books
WHERE available_copies > 2;


# Write a SQL query to create an index named idx_books_available on the available_copies column of the Books table.
CREATE INDEX idx_books_available
ON Books(available_copies);


# Write a SQL query to create an index named idx_books_genre_available on genre and available_copies in the Books table.
CREATE INDEX idx_books_genre_available
ON Books(genre, available_copies);


# Write a query to find books in the Technology genre with more than 1 available copy, then inspect its execution plan using EXPLAIN.
EXPLAIN
SELECT *
FROM Books
WHERE genre = 'Technology'
  AND available_copies > 1;


# Write a query to show the execution plan for finding books whose titles begin with 'Clean'
EXPLAIN
SELECT *
FROM Books
WHERE title LIKE 'Clean%';


# Write a SQL query to display all indexes on the Members table.
SHOW INDEX FROM Members;


# Write a SQL query to remove the index named idx_members_email from the Members table.
DROP INDEX idx_members_email ON Members;


# Write a SQL query to display the execution plan for finding members whose name starts with 'R'.
EXPLAIN
SELECT *
FROM Members
WHERE name LIKE 'R%';


# Write a query to find books where available_copies is exactly 0 and display the execution plan.
EXPLAIN
SELECT *
FROM Books
WHERE available_copies = 0;
