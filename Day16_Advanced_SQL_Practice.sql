-- # using a CTE named BookSummary that displays only books whose total_copies are greater than 3.
-- WITH BookSummary AS (
--     SELECT
--         book_id,
--         title,
--         total_copies
--     FROM Books
-- )
-- SELECT *
-- FROM BookSummary
-- WHERE total_copies > 3;



-- # create a CTE named MemberSummary that calculates how many times each member has issued a book. Then display only members with more than one issue.
-- WITH MemberSummary AS (
--     SELECT
--         m.member_id,
--         m.name,
--         COUNT(i.issue_id) AS total_issues
--     FROM Members m
--     LEFT JOIN Issued_Books i
--         ON m.member_id = i.member_id
--     GROUP BY m.member_id, m.name
-- )
-- SELECT *
-- FROM MemberSummary
-- WHERE total_issues > 1;



-- # Rank books by total copies
-- SELECT
--     book_id,
--     title,
--     total_copies,
--     ROW_NUMBER() OVER (
--         ORDER BY total_copies DESC
--     ) AS row_num
-- FROM Books;



-- # Rank the books from the highest number of copies to the lowest.
-- SELECT
--     title,
--     total_copies,
--     RANK() OVER (
--         ORDER BY total_copies DESC
--     ) AS book_rank
-- FROM Books;


-- # Rank the books from the highest number of copies to the lowest using dense(rank).
-- SELECT
--     title,
--     total_copies,
--     dense_rank() OVER (
--         ORDER BY total_copies DESC
--     ) AS book_rank
-- FROM Books;



-- # Display the top 2 books ranked by total_copies
-- WITH RankedBooks AS (
--     SELECT
--         book_id,
--         title,
--         total_copies,
--         DENSE_RANK() OVER (
--             ORDER BY total_copies DESC
--         ) AS book_rank
--     FROM Books
-- )
-- SELECT *
-- FROM RankedBooks
-- WHERE book_rank <= 2;



-- # Display every book with its total_copies and a ROW_NUMBER() ordered by total_copies DESC. Use a CTE named BookRanking, then display only the row with row_num = 1.
-- WITH BookRanking AS (
--     SELECT
--         book_id,
--         title,
--         total_copies,
--         ROW_NUMBER() OVER (
--             ORDER BY total_copies DESC
--         ) AS row_num
--     FROM Books
-- )
-- SELECT *
-- FROM BookRanking
-- WHERE row_num = 1;


-- # Display each book's title, genre, total_copies, and ROW_NUMBER() as genre_row_num.
-- SELECT
--     title,
--     genre,
--     total_copies,
--     ROW_NUMBER() OVER (
--         PARTITION BY genre
--         ORDER BY total_copies desc
--     ) AS genre_row_num
-- FROM Books;



-- # Use a CTE named GenreRanking to rank books within each genre using ROW_NUMBER(). Then display only the book with genre_row_num = 1 for each genre.
-- WITH GenreRanking AS (
--     SELECT
--         title,
--         genre,
--         total_copies,
--         ROW_NUMBER() OVER (
--             PARTITION BY genre
--             ORDER BY total_copies DESC
--         ) AS genre_row_num
--     FROM Books
-- )
-- SELECT *
-- FROM GenreRanking
-- WHERE genre_row_num = 1;


-- # RANK() with PARTITION BY
-- SELECT
--     title,
--     genre,
--     total_copies,
--     RANK() OVER (
--         PARTITION BY genre
--         ORDER BY total_copies DESC
--     ) AS genre_rank
-- FROM Books;



-- # Find genres with multiple books
-- WITH GenreRanking AS (
--     SELECT
--         title,
--         genre,
--         total_copies,
--         RANK() OVER (
--             PARTITION BY genre
--             ORDER BY total_copies DESC
--         ) AS genre_rank
--     FROM Books
-- )
-- SELECT *
-- FROM GenreRanking
-- WHERE genre_rank = 1;



-- # Running total with SUM() OVER()
-- SELECT
--     issue_id,
--     member_id,
--     issue_date,
--     COUNT(*) OVER (
--         ORDER BY issue_date, issue_id
--     ) AS running_total
-- FROM Issued_Books;



-- # COUNT() OVER()
-- # Write a query displaying issue_id, member_id, and total_issue_records, where total_issue_records shows the total number of rows in the entire Issued_Books table on every row.
-- SELECT
--     issue_id,
--     member_id,
--     COUNT(*) OVER() AS total_issue_records
-- FROM Issued_Books;



-- # LAG()
-- SELECT
--     issue_id,
--     issue_date,
--     LAG(issue_date) OVER (
--         ORDER BY issue_date, issue_id
--     ) AS previous_issue_date
-- FROM Issued_Books;



-- # LEAD()
-- SELECT
--     issue_id,
--     issue_date,
--     LEAD(issue_date) OVER (
--         ORDER BY issue_date, issue_id
--     ) AS next_issue_date
-- FROM Issued_Books;
