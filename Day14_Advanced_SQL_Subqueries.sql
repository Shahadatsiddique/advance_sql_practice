# 1. books whose available_copies is greater than the average available_copies
SELECT
    b.title,
    b.genre,
    b.available_copies
FROM Books b
WHERE b.available_copies > (
    SELECT AVG(b2.available_copies)
    FROM Books b2
    WHERE b2.genre = b.genre
);


# 2. members who have at least one matching record in Issued_Books
SELECT
    m.member_id,
    m.name
FROM Members m
WHERE EXISTS (
    SELECT *
    FROM Issued_Books ib
    WHERE ib.member_id = m.member_id
);



# 3. books that have never appeared in Issued_Books
SELECT
    b.book_id,
    b.title
FROM Books b
WHERE NOT EXISTS (
    SELECT *
    FROM Issued_Books ib
    WHERE ib.book_id = b.book_id
);


# 4. members whose number of issue records is greater than one
SELECT
    m.member_id,
    m.name
FROM Members m
WHERE (
    SELECT COUNT(*)
    FROM Issued_Books ib
    WHERE ib.member_id = m.member_id
) > 1;



# 5. books whose available_copies is greater than the average availability of all books.
SELECT
    book_id,
    title,
    available_copies
FROM Books
WHERE available_copies > (
    SELECT AVG(available_copies)
    FROM Books
);



# 6. Members who issued a book with zero available copies
SELECT
    m.member_id,
    m.name
FROM Members m
WHERE EXISTS (
    SELECT *
    FROM Issued_Books ib
    WHERE ib.member_id = m.member_id
      AND EXISTS (
          SELECT *
          FROM Books b
          WHERE b.book_id = ib.book_id
            AND b.available_copies = 0
      )
);



# 7. Books that have never been issued (repeat practice)
SELECT
    b.book_id,
    b.title
FROM Books b
WHERE NOT EXISTS (
    SELECT *
    FROM Issued_Books ib
    WHERE b.book_id = ib.book_id
);



# 8. Members who have never issued a book
SELECT
    m.member_id,
    m.name
FROM Members m
WHERE NOT EXISTS (
    SELECT *
    FROM Issued_Books i
    WHERE m.member_id = i.member_id
);


# 9. Members who issued a book titled Clean Code
SELECT
    m.member_id,
    m.name
FROM Members m
WHERE EXISTS (
    SELECT *
    FROM Issued_Books i
    WHERE i.member_id = m.member_id
      AND EXISTS (
          SELECT *
          FROM Books b
          WHERE b.book_id = i.book_id
            AND b.title = 'Clean Code'
      )
);



# 10. Find the members who have issued more than one book record
SELECT m.member_id, m.name
FROM Members m
WHERE (
    SELECT COUNT(*)
    FROM Issued_Books i
    WHERE m.member_id = i.member_id
) > 1;


# 11. Find books that have never been issued
SELECT b.book_id, b.title
FROM Books b
WHERE NOT EXISTS (
    SELECT *
    FROM Issued_Books i
    WHERE b.book_id = i.book_id
);




# 12. Members who issued Clean Code
SELECT m.member_id, m.name
FROM Members m
WHERE EXISTS (
    SELECT *
    FROM Issued_Books i
    WHERE m.member_id = i.member_id
      AND EXISTS (
          SELECT *
          FROM Books b
          WHERE b.book_id = i.book_id
            AND b.title = 'Clean Code'
      )
);
