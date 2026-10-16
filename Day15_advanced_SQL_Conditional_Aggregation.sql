# find the number of books issued on each date, showing only dates that have at least one issue record.
SELECT
    issue_date,
    COUNT(issue_id) AS total_issued
FROM Issued_Books
GROUP BY issue_date
ORDER BY issue_date;


#  total fine amount paid and the total fine amount unpaid in a single row.
SELECT
    SUM(CASE WHEN paid = TRUE THEN amount ELSE 0 END) AS total_paid,
    SUM(CASE WHEN paid = FALSE THEN amount ELSE 0 END) AS total_unpaid
FROM Fines;



# Count how many books are out of stock and how many are in stock, returning both counts in a single row.
SELECT
    SUM(CASE WHEN available_copies > 0 THEN 1 ELSE 0 END) AS in_stock,
    SUM(CASE WHEN available_copies = 0 THEN 1 ELSE 0 END) AS out_of_stock
FROM Books;



# count how many issue records have been returned and how many are currently unreturned.
SELECT
    SUM(CASE WHEN return_date IS NOT NULL THEN 1 ELSE 0 END) AS returned,
    SUM(CASE WHEN return_date IS NULL THEN 1 ELSE 0 END) AS unreturned
FROM Issued_Books;



# shows the number of returned and unreturned issue records for each book.
SELECT
    b.title,
    SUM(CASE
        WHEN i.return_date IS NOT NULL THEN 1
        ELSE 0
    END) AS returned,
    SUM(CASE
        WHEN i.return_date IS NULL THEN 1
        ELSE 0
    END) AS unreturned
FROM Books b
JOIN Issued_Books i
    ON b.book_id = i.book_id
GROUP BY b.book_id, b.title;



# count how many times each book has been issued, including books that have never been issued.
SELECT
    b.book_id,
    b.title,
    COUNT(i.issue_id) AS total_issued
FROM Books b
LEFT JOIN Issued_Books i
    ON b.book_id = i.book_id
GROUP BY b.book_id, b.title
ORDER BY b.title;



# isplay each members name and the total number of times they have issued books, including members who have never issued a book.
SELECT
    m.name,
    COUNT(i.issue_id) AS total_times
FROM Members m
LEFT JOIN Issued_Books i
    ON m.member_id = i.member_id
GROUP BY m.member_id, m.name
ORDER BY m.member_id;



# display the member name and total number of issues, but show only members who have issued books more than once.
SELECT
    m.name,
    COUNT(i.member_id) AS total_times
FROM Members m
LEFT JOIN Issued_Books i
    ON i.member_id = m.member_id
GROUP BY m.member_id, m.name
HAVING COUNT(i.issue_id) > 1;



# display the book ID, title, and total copies for books that have never been issued to any member.
SELECT
    b.book_id,
    b.title,
    b.total_copies
FROM Books b
LEFT JOIN Issued_Books i
    ON i.book_id = b.book_id
WHERE i.issue_id IS NULL;


# Find members who have never issued a book
SELECT
    m.member_id,
    m.name
FROM Members m
LEFT JOIN Issued_Books i
    ON i.member_id = m.member_id
WHERE i.issue_id IS NULL;
