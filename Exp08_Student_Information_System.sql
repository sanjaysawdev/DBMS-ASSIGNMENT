SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS StudentDB;
CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name      VARCHAR(50),
    Age       INT,
    Gender    CHAR(1),
    Address   VARCHAR(100),
    Phone     VARCHAR(10) UNIQUE
);

CREATE TABLE Courses (
    CourseID   INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(50) NOT NULL,
    Credits    INT NOT NULL,
    Capacity   INT NOT NULL
);

CREATE TABLE Enrollments (
    EnrollmentID   INT PRIMARY KEY AUTO_INCREMENT,
    StudentID      INT NOT NULL,
    CourseID       INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Grade          CHAR(2),
    Status         VARCHAR(15) DEFAULT 'Active',
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID)  REFERENCES Courses(CourseID)
);

INSERT INTO Students (Name, Age, Gender, Address, Phone) VALUES
('Rahul Sharma', 20, 'M', 'Bhubaneswar', '9876543210'),
('Sneha Das',    19, 'F', 'Cuttack',     '9876543211'),
('Amit Mishra',  21, 'M', 'Puri',        '9876543212'),
('Priya Patra',  20, 'F', 'Rourkela',    '9876543213'),
('Kiran Behera', 22, 'M', 'Berhampur',   '9876543214'),
('Divya Rout',   19, 'F', 'Balasore',    '9876543215');

INSERT INTO Courses (CourseName, Credits, Capacity) VALUES
('Database Systems',   4, 60),
('Data Structures',    4, 50),
('Operating Systems',  3, 45),
('Machine Learning',   4, 40),
('Computer Networks',  3, 55),
('Software Testing',   2, 30);

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade, Status) VALUES
(1, 1, '2026-01-10', NULL, 'Active'),
(1, 4, '2026-01-12', NULL, 'Active'),
(2, 1, '2026-01-11', NULL, 'Active'),
(3, 2, '2026-01-15', 'A',  'Completed'),
(4, 3, '2026-01-16', NULL, 'Active'),
(2, 5, '2026-01-18', 'B',  'Completed');

SELECT * FROM Students;

SELECT * FROM Courses;

SELECT s.StudentID, s.Name, s.Age, s.Gender, s.Phone, c.CourseName, e.Status
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses  c ON e.CourseID  = c.CourseID;

SELECT c.CourseName, s.Name AS StudentName, e.EnrollmentDate
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses  c ON e.CourseID  = c.CourseID;

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Status)
VALUES (5, 1, CURDATE(), 'Active');
UPDATE Courses SET Capacity = Capacity - 1 WHERE CourseID = 1;
SELECT CourseID, CourseName, Capacity FROM Courses WHERE CourseID = 1;

UPDATE Enrollments SET Grade = 'A', Status = 'Completed'
WHERE StudentID = 1 AND CourseID = 1;
SELECT * FROM Enrollments;

UPDATE Courses SET Capacity = Capacity + 10 WHERE CourseID = 4;
SELECT * FROM Courses WHERE CourseID = 4;

DELETE FROM Students WHERE StudentID = 6;
SELECT * FROM Students;

DELETE FROM Courses WHERE CourseID = 6;
SELECT * FROM Courses;

ALTER TABLE Students ADD Email VARCHAR(100);
UPDATE Students SET Email = CONCAT(LOWER(SUBSTRING_INDEX(Name, ' ', 1)), '@student.edu');
SELECT * FROM Students;

ALTER TABLE Students DROP COLUMN Address;
DESCRIBE Students;

RENAME TABLE Enrollments TO Registrations;
SHOW TABLES;

TRUNCATE TABLE Registrations;
SELECT * FROM Registrations;

INSERT INTO Registrations (StudentID, CourseID, EnrollmentDate, Grade, Status) VALUES
(1, 1, '2026-01-10', 'A',  'Completed'),
(1, 4, '2026-01-12', NULL, 'Active'),
(2, 1, '2026-01-11', NULL, 'Active'),
(3, 2, '2026-01-15', 'A',  'Completed'),
(4, 3, '2026-01-16', NULL, 'Active'),
(5, 1, '2026-02-01', NULL, 'Active');

ALTER TABLE Students MODIFY Name VARCHAR(50) NOT NULL;
DESCRIBE Students;

ALTER TABLE Students ADD CONSTRAINT chk_age CHECK (Age >= 18);
SHOW CREATE TABLE Students;

SELECT s.Name, c.CourseName, r.Status
FROM Students s
INNER JOIN Registrations r ON s.StudentID = r.StudentID
INNER JOIN Courses c       ON r.CourseID  = c.CourseID;

SELECT s.Name, c.CourseName, r.Status
FROM Students s
LEFT JOIN Registrations r ON s.StudentID = r.StudentID
LEFT JOIN Courses c       ON r.CourseID  = c.CourseID;

SELECT COUNT(*) AS TotalStudents FROM Students;

SELECT MAX(Credits) AS MaxCredits, MIN(Credits) AS MinCredits FROM Courses;

SELECT COUNT(*) AS ActiveEnrollments FROM Registrations WHERE Status = 'Active';

CREATE VIEW ActiveEnrollmentsView AS
SELECT c.CourseName, s.Name AS StudentName, r.EnrollmentDate
FROM Registrations r
JOIN Students s ON r.StudentID = s.StudentID
JOIN Courses  c ON r.CourseID  = c.CourseID
WHERE r.Status = 'Active';

SELECT * FROM ActiveEnrollmentsView;

DELIMITER $$
CREATE PROCEDURE GetActiveEnrollments()
BEGIN
    SELECT c.CourseName, s.Name AS StudentName, r.EnrollmentDate
    FROM Registrations r
    JOIN Students s ON r.StudentID = s.StudentID
    JOIN Courses  c ON r.CourseID  = c.CourseID
    WHERE r.Status = 'Active';
END$$
DELIMITER ;

CALL GetActiveEnrollments();
