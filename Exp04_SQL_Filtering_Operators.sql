SET SQL_SAFE_UPDATES = 0;   

DROP DATABASE IF EXISTS Exp4DB;
CREATE DATABASE Exp4DB;
USE Exp4DB;

CREATE TABLE Employee (
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(30) NOT NULL,
    Designation VARCHAR(30),
    Salary      DECIMAL(10,2)
);

INSERT INTO Employee VALUES
(101, 'Suresh', 'Manager',   45000),
(102, 'Rahul',  'Clerk',     15000),
(103, 'Ramesh', 'Analyst',   28000),
(104, 'Priya',  'Developer', 32000),
(105, 'Miller', 'Clerk',     12000),
(106, 'Allen',  'Salesman',  18000),
(107, 'Kumar',  'Analyst',   30000),
(108, 'Sunil',  'Developer', 25000),
(109, 'Ravi',   'Manager',   50000),
(110, 'Divya',  'Clerk',     NULL),
(111, 'Tarun',  'Salesman',  NULL),
(112, 'Walter', 'Salesman',  9000);

SELECT * FROM Employee;


SELECT * FROM Employee WHERE Salary BETWEEN 10000 AND 30000;

SELECT * FROM Employee WHERE Salary NOT BETWEEN 10000 AND 30000;

SELECT * FROM Employee WHERE Designation IN ('Manager', 'Clerk');
SELECT * FROM Employee WHERE Designation NOT IN ('Manager', 'Clerk');

SELECT * FROM Employee WHERE Salary IS NULL;
SELECT * FROM Employee WHERE Salary IS NOT NULL;

SELECT EmpName FROM Employee WHERE EmpName LIKE 'S%';    -- starts with S
SELECT EmpName FROM Employee WHERE EmpName LIKE '%R';    -- ends with R
SELECT EmpName FROM Employee WHERE EmpName LIKE '%U%';   -- contains U
SELECT EmpName FROM Employee WHERE EmpName LIKE '%A%';   -- contains A
SELECT EmpName FROM Employee WHERE EmpName LIKE '%LL%';  -- contains LL
SELECT EmpName FROM Employee WHERE EmpName LIKE '%E%';   -- contains E

SELECT * FROM Employee WHERE Salary =  30000;
SELECT * FROM Employee WHERE Salary != 30000;
SELECT * FROM Employee WHERE Salary >  30000;
SELECT * FROM Employee WHERE Salary <  30000;
SELECT * FROM Employee WHERE Salary >= 30000;
SELECT * FROM Employee WHERE Salary <= 30000;

SELECT * FROM Employee WHERE Designation = 'Clerk'   AND Salary > 12000;
SELECT * FROM Employee WHERE Designation = 'Manager' OR  Salary < 15000;

SELECT * FROM Employee ORDER BY EmpName ASC;
SELECT * FROM Employee ORDER BY EmpName DESC;

SELECT DISTINCT Designation FROM Employee;

SELECT Designation, COUNT(*) AS TotalEmployees, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Designation;

SELECT Designation, COUNT(*) AS TotalEmployees, AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Designation
HAVING COUNT(*) > 2;

SELECT Designation, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY Designation
HAVING SUM(Salary) > 50000;

DELETE FROM Employee WHERE EmpName LIKE 'Wal%';
SELECT * FROM Employee;

UPDATE Employee SET Salary = Salary + 2000 WHERE EmpName LIKE 'R%';
SELECT * FROM Employee WHERE EmpName LIKE 'R%';

SELECT EmpName,
       Salary,
       Salary * 0.10            AS Bonus,
       Salary * 0.05            AS TaxDeduction,
       Salary + Salary * 0.10 - Salary * 0.05 AS NetSalary,
       Salary * 2               AS DoubleSalary
FROM Employee
WHERE Salary IS NOT NULL;
