DROP DATABASE IF EXISTS Exp5DB;
CREATE DATABASE Exp5DB;
USE Exp5DB;

CREATE TABLE Employee (
    EmpID       INT PRIMARY KEY,
    EmpName     VARCHAR(30),
    Designation VARCHAR(30),
    Department  VARCHAR(30),
    Salary      DECIMAL(10,2),
    JoinDate    DATE
);

INSERT INTO Employee VALUES
(1, 'Rahul Sharma', 'Developer', 'IT',      30500.75, '2020-06-15'),
(2, 'Sneha Das',    'Analyst',   'IT',      27250.40, '2021-03-10'),
(3, 'Amit Mishra',  'Manager',   'Finance', 45800.60, '2018-01-20'),
(4, 'Priya Patra',  'Clerk',     'HR',      18400.25, '2022-09-05'),
(5, 'Suresh Nayak', 'Manager',   'Sales',   48200.90, '2017-11-12'),
(6, 'Kiran Behera', 'Clerk',     'Finance', 19750.10, '2023-02-28'),
(7, 'Divya Rout',   'Developer', 'IT',      33900.55, '2019-07-01'),
(8, 'Tarun Jena',   'Salesman',  'Sales',   22100.30, '2021-12-14');

SELECT * FROM Employee;

SELECT EmpName, UPPER(EmpName) AS UpperCase, LOWER(EmpName) AS LowerCase FROM Employee;

SELECT EmpName, LENGTH(EmpName) AS NameLength FROM Employee;

SELECT CONCAT(EmpName, ' - ', Designation) AS EmployeeDetails FROM Employee;

SELECT EmpName, SUBSTRING(EmpName, 1, 3) AS FirstThree FROM Employee;

SELECT EmpName, Salary, ROUND(Salary) AS RoundedSalary,
       ROUND(Salary, 1) AS OneDecimal, ROUND(Salary, -2) AS NearestHundred
FROM Employee;

SELECT EmpName, Salary, ABS(Salary - 30000) AS AbsDifference FROM Employee;

SELECT CURDATE() AS CurrentDate, NOW() AS CurrentDateTime;

SELECT EmpName, JoinDate,
       DATEDIFF(CURDATE(), JoinDate)              AS DaysOfService,
       FLOOR(DATEDIFF(CURDATE(), JoinDate) / 365) AS YearsOfService
FROM Employee;

SELECT COUNT(*)    AS TotalEmployees,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary,
       AVG(Salary) AS AvgSalary,
       SUM(Salary) AS TotalSalary
FROM Employee;

SELECT Department,
       COUNT(*)    AS Employees,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary,
       MAX(Salary) AS HighestSalary,
       MIN(Salary) AS LowestSalary
FROM Employee
GROUP BY Department
ORDER BY TotalSalary DESC;
