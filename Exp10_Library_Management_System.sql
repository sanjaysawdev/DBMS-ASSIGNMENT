SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Books (
    BookID          INT PRIMARY KEY AUTO_INCREMENT,
    Title           VARCHAR(100),
    Author          VARCHAR(50) NOT NULL,
    PublicationYear INT,
    TotalCopies     INT NOT NULL DEFAULT 1,
    AvailableCopies INT NOT NULL DEFAULT 1
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name     VARCHAR(50) NOT NULL,
    Phone    VARCHAR(10) UNIQUE,
    Address  VARCHAR(100),
    JoinDate DATE
);

CREATE TABLE IssueReturn (
    IssueID    INT PRIMARY KEY AUTO_INCREMENT,
    BookID     INT NOT NULL,
    MemberID   INT NOT NULL,
    IssueDate  DATE NOT NULL,
    ReturnDate DATE,
    Status     VARCHAR(10) DEFAULT 'Issued',
    FOREIGN KEY (BookID)   REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

INSERT INTO Books (Title, Author, PublicationYear, TotalCopies, AvailableCopies) VALUES
('Database System Concepts',     'Silberschatz',     2019, 5, 5),
('The C Programming Language',   'Kernighan',        1988, 3, 3),
('Introduction to Algorithms',   'Cormen',           2009, 4, 4),
('Operating System Concepts',    'Galvin',           2018, 6, 6),
('Computer Networks',            'Tanenbaum',        2010, 4, 4),
('Clean Code',                   'Robert C. Martin', 2008, 2, 2);

INSERT INTO Members (Name, Phone, Address, JoinDate) VALUES
('Rahul Sharma', '9876543210', 'Bhubaneswar', '2025-06-10'),
('Sneha Das',    '9876543211', 'Cuttack',     '2025-07-15'),
('Amit Mishra',  '9876543212', 'Puri',        '2025-08-01'),
('Priya Patra',  '9876543213', 'Rourkela',    '2025-09-12'),
('Kiran Behera', '9876543214', 'Berhampur',   '2025-10-05'),
('Divya Rout',   '9876543215', 'Balasore',    '2025-11-20');

INSERT INTO IssueReturn (BookID, MemberID, IssueDate, ReturnDate, Status) VALUES
(1, 1, '2026-01-05', NULL,         'Issued'),
(2, 2, '2026-01-08', '2026-01-20', 'Returned'),
(3, 3, '2026-01-10', NULL,         'Issued'),
(4, 4, '2026-01-12', NULL,         'Issued'),
(1, 2, '2026-01-15', '2026-01-28', 'Returned');

UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE BookID IN (1, 3, 4);

SELECT * FROM Books;

SELECT * FROM Members;

SELECT i.IssueID, b.Title, m.MemberID, m.Name, m.Phone, i.IssueDate, i.Status
FROM IssueReturn i
JOIN Books   b ON i.BookID   = b.BookID
JOIN Members m ON i.MemberID = m.MemberID;

SELECT b.Title, m.Name AS MemberName, i.IssueDate
FROM IssueReturn i
JOIN Books   b ON i.BookID   = b.BookID
JOIN Members m ON i.MemberID = m.MemberID;

INSERT INTO IssueReturn (BookID, MemberID, IssueDate, Status)
VALUES (5, 5, CURDATE(), 'Issued');
UPDATE Books SET AvailableCopies = AvailableCopies - 1 WHERE BookID = 5;
SELECT BookID, Title, TotalCopies, AvailableCopies FROM Books WHERE BookID = 5;

UPDATE IssueReturn SET Status = 'Returned', ReturnDate = CURDATE() WHERE IssueID = 1;
UPDATE Books SET AvailableCopies = AvailableCopies + 1 WHERE BookID = 1;
SELECT * FROM IssueReturn;
k
UPDATE Books SET TotalCopies = TotalCopies + 3, AvailableCopies = AvailableCopies + 3
WHERE BookID = 2;
SELECT * FROM Books WHERE BookID = 2;

DELETE FROM Members WHERE MemberID = 6;
SELECT * FROM Members;

DELETE FROM Books WHERE BookID = 6;
SELECT * FROM Books;

ALTER TABLE Books ADD ISBN VARCHAR(17);
UPDATE Books SET ISBN = CONCAT('978-81-', LPAD(BookID, 5, '0'), '-0');
SELECT * FROM Books;

ALTER TABLE Members DROP COLUMN Address;
DESCRIBE Members;

RENAME TABLE IssueReturn TO Transactions;
SHOW TABLES;

TRUNCATE TABLE Transactions;
SELECT * FROM Transactions;

INSERT INTO Transactions (BookID, MemberID, IssueDate, ReturnDate, Status) VALUES
(1, 1, '2026-01-05', '2026-01-25', 'Returned'),
(2, 2, '2026-01-08', '2026-01-20', 'Returned'),
(3, 3, '2026-01-10', NULL,         'Issued'),
(4, 4, '2026-01-12', NULL,         'Issued'),
(5, 5, '2026-02-01', NULL,         'Issued');

ALTER TABLE Books MODIFY Title VARCHAR(100) NOT NULL;
DESCRIBE Books;

ALTER TABLE Members ADD CONSTRAINT chk_phone CHECK (Phone REGEXP '^[0-9]{10}$');
SHOW CREATE TABLE Members;

SELECT m.Name, b.Title, t.IssueDate, t.Status
FROM Members m
INNER JOIN Transactions t ON m.MemberID = t.MemberID
INNER JOIN Books        b ON t.BookID   = b.BookID;

SELECT m.Name, b.Title, t.IssueDate, t.Status
FROM Members m
LEFT JOIN Transactions t ON m.MemberID = t.MemberID
LEFT JOIN Books        b ON t.BookID   = b.BookID;

SELECT COUNT(*)         AS DistinctTitles  FROM Books;
SELECT SUM(TotalCopies) AS TotalBookCopies FROM Books;

SELECT MAX(PublicationYear) AS LatestYear, MIN(PublicationYear) AS OldestYear FROM Books;

SELECT COUNT(*) AS BooksCurrentlyIssued FROM Transactions WHERE Status = 'Issued';

CREATE VIEW IssuedBooksView AS
SELECT b.Title, m.Name AS MemberName, t.IssueDate
FROM Transactions t
JOIN Books   b ON t.BookID   = b.BookID
JOIN Members m ON t.MemberID = m.MemberID
WHERE t.Status = 'Issued';

SELECT * FROM IssuedBooksView;

DELIMITER $$
CREATE PROCEDURE GetIssuedBooks()
BEGIN
    SELECT b.Title, m.Name AS MemberName, t.IssueDate
    FROM Transactions t
    JOIN Books   b ON t.BookID   = b.BookID
    JOIN Members m ON t.MemberID = m.MemberID
    WHERE t.Status = 'Issued';
END$$
DELIMITER ;

CALL GetIssuedBooks();
