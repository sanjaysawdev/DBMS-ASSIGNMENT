SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS Exp1DB;
CREATE DATABASE Exp1DB;
USE Exp1DB;

SET @emp_name  = 'Rahul';
SET @salary    = 25000;
SET @bonus     = 2500.50;
SET @join_date = '2026-01-15';

SELECT @emp_name AS EmpName, @salary AS Salary,
       @bonus AS Bonus, @join_date AS JoinDate;

SELECT 100 INTO @x;
SELECT @x AS X_Value;

-- Assign and display in a single SELECT using :=
SELECT @y := 45 AS Y_Value;

CREATE TABLE DataTypeDemo (
    id          INT,               
    price       DECIMAL(8,2),     
    rating      FLOAT,             
    name        VARCHAR(30),      
    grade       CHAR(1),           
    remarks     TEXT,              
    dob         DATE,              
    login_time  TIME,             
    created_at  DATETIME           
);

INSERT INTO DataTypeDemo VALUES
(1, 1999.50, 4.5, 'Keyboard', 'A', 'Good quality product', '2005-08-20', '10:30:00', '2026-01-10 09:15:00'),
(2,  499.99, 3.8, 'Mouse',    'B', 'Average product',      '2004-03-12', '14:45:30', '2026-02-05 18:20:10');

SELECT * FROM DataTypeDemo;
DESCRIBE DataTypeDemo;

SET @a = 20, @b = 6;

SELECT @a + @b  AS Addition,
       @a - @b  AS Subtraction,
       @a * @b  AS Multiplication,
       @a / @b  AS Division,
       @a DIV @b AS IntegerDivision,
       @a % @b  AS Modulus;

SELECT 10 = 10  AS Equal,
       10 < 5   AS LessThan,
       10 > 5   AS GreaterThan,
       10 <= 10 AS LessOrEqual,
       10 >= 15 AS GreaterOrEqual,
       10 <> 5  AS NotEqual;

CREATE TABLE Emp (
    EmpID  INT PRIMARY KEY,
    Name   VARCHAR(30),
    Dept   VARCHAR(20),
    Salary INT,
    City   VARCHAR(20)
);

INSERT INTO Emp VALUES
(1, 'Rahul',  'IT',      30000, 'Bhubaneswar'),
(2, 'Sneha',  'HR',      25000, 'Cuttack'),
(3, 'Amit',   'Finance', 40000, 'Puri'),
(4, 'Priya',  'IT',      35000, 'Bhubaneswar'),
(5, 'Suresh', 'Sales',   20000, 'Rourkela');

SELECT * FROM Emp;

SELECT * FROM Emp WHERE Dept = 'IT' AND Salary > 30000;

SELECT * FROM Emp WHERE Dept = 'HR' OR Dept = 'Sales';

SELECT * FROM Emp WHERE City IN ('Puri', 'Cuttack');

SELECT * FROM Emp WHERE Salary BETWEEN 25000 AND 35000;

SELECT * FROM Emp WHERE Name LIKE 'S%';

SELECT * FROM Emp WHERE NOT Dept = 'IT';

SELECT * FROM Emp WHERE Salary NOT BETWEEN 25000 AND 35000;

SELECT * FROM Emp WHERE City NOT IN ('Puri', 'Cuttack');

SELECT * FROM Emp WHERE Name NOT LIKE 'S%';
