SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS Exp6DB;
CREATE DATABASE Exp6DB;
USE Exp6DB;

CREATE TABLE Department (
    DeptID   INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    EmpID       INT PRIMARY KEY,                      
    EmpName     VARCHAR(50) NOT NULL,                  
    Email       VARCHAR(100) UNIQUE,                   
    Mobile      VARCHAR(10),
    Salary      DECIMAL(10,2) DEFAULT 20000.00,       
    JoiningDate DATE DEFAULT (CURRENT_DATE),        
    DeptID      INT
);

ALTER TABLE Employee
ADD CONSTRAINT fk_emp_dept FOREIGN KEY (DeptID) REFERENCES Department(DeptID);

ALTER TABLE Employee
ADD CONSTRAINT chk_salary CHECK (Salary >= 10000);

ALTER TABLE Employee
ADD CONSTRAINT uq_mobile UNIQUE (Mobile);

SHOW CREATE TABLE Employee;

INSERT INTO Department VALUES
(10, 'IT',      'Bhubaneswar'),
(20, 'HR',      'Cuttack'),
(30, 'Finance', 'Puri');

INSERT INTO Employee VALUES
(101, 'Rahul Sharma', 'rahul@mail.com', '9876543210', 35000, '2024-01-15', 10),
(102, 'Sneha Das',    'sneha@mail.com', '9876543211', 28000, '2024-03-10', 20),
(103, 'Amit Mishra',  'amit@mail.com',  '9876543212', 42000, '2023-07-01', 30);

INSERT INTO Employee (EmpID, EmpName, Email, Mobile, DeptID)
VALUES (104, 'Priya Patra', 'priya@mail.com', '9876543213', 10);

SELECT * FROM Department;
SELECT * FROM Employee;

INSERT INTO Employee VALUES (101, 'Kiran Behera', 'kiran@mail.com', '9876543220', 30000, '2024-05-01', 10);

INSERT INTO Employee VALUES (105, 'Divya Rout', 'divya@mail.com', '9876543221', 30000, '2024-05-01', 99);

INSERT INTO Employee VALUES (106, 'Tarun Jena', 'rahul@mail.com', '9876543222', 30000, '2024-05-01', 10);

INSERT INTO Employee VALUES (107, 'Suresh Nayak', 'suresh@mail.com', '9876543210', 30000, '2024-05-01', 10);

INSERT INTO Employee VALUES (108, NULL, 'null@mail.com', '9876543223', 30000, '2024-05-01', 10);

INSERT INTO Employee VALUES (109, 'Low Pay', 'low@mail.com', '9876543224', 5000, '2024-05-01', 10);

SELECT * FROM Employee;

INSERT INTO Employee (EmpID, EmpName, Email, Mobile, DeptID)
VALUES (110, 'New Joiner', 'newjoiner@mail.com', '9876543230', 20);
SELECT * FROM Employee WHERE EmpID = 110;      -- Salary is now 25000

ALTER TABLE Employee DROP CHECK chk_salary;
ALTER TABLE Employee DROP FOREIGN KEY fk_emp_dept;
ALTER TABLE Employee DROP INDEX uq_mobile;      -- UNIQUE is dropped via its index

SHOW CREATE TABLE Employee;

INSERT INTO Employee VALUES (111, 'Low Pay', 'low@mail.com', '9876543224', 5000, '2024-05-01', 10);
SELECT * FROM Employee;
