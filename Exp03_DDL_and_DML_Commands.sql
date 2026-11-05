SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS Exp3DB;
CREATE DATABASE Exp3DB;
USE Exp3DB;

CREATE TABLE Persons (
    PersonID  INT PRIMARY KEY,
    LastName  VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50),
    Age       INT,
    City      VARCHAR(50)
);

DESCRIBE Persons;        
SHOW CREATE TABLE Persons;

INSERT INTO Persons (PersonID, LastName, FirstName, Age, City) VALUES
(1, 'Sharma', 'Rahul', 25, 'Bhubaneswar'),
(2, 'Das',    'Sneha', 22, 'Cuttack'),
(3, 'Mishra', 'Amit',  30, 'Puri'),
(4, 'Patra',  'Priya', 27, 'Rourkela'),
(5, 'Nayak',  'Kiran', 35, 'Bhubaneswar');

SELECT * FROM Persons;

SELECT FirstName, LastName, City FROM Persons;

ALTER TABLE Persons ADD Email VARCHAR(100);               
ALTER TABLE Persons ADD Phone VARCHAR(15);                
DESCRIBE Persons;

ALTER TABLE Persons MODIFY City VARCHAR(100);          
ALTER TABLE Persons MODIFY Age SMALLINT;
DESCRIBE Persons;

ALTER TABLE Persons DROP COLUMN Phone;                      
DESCRIBE Persons;

CREATE TABLE Employees (
    EmpID      INT PRIMARY KEY,
    EmpName    VARCHAR(50),
    Department VARCHAR(30),
    Salary     DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Rahul',  'IT',      30000),
(2, 'Sneha',  'HR',      25000),
(3, 'Amit',   'Finance', 40000),
(4, 'Priya',  'IT',      35000),
(5, 'Suresh', 'Sales',   20000);

RENAME TABLE Employees TO Staff;   
SHOW TABLES;
SELECT * FROM Staff;

UPDATE Staff SET Department = 'Finance' WHERE EmpID = 2;
SELECT * FROM Staff;

DELETE FROM Staff WHERE EmpID = 5;
SELECT * FROM Staff;

TRUNCATE TABLE Persons;
SELECT * FROM Persons;
DESCRIBE Persons;

DROP TABLE Persons;
SHOW TABLES;
