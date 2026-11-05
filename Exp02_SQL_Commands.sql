DROP DATABASE IF EXISTS EmployeeDB;
DROP DATABASE IF EXISTS CompanyEmployeeDB;
DROP DATABASE IF EXISTS ProductStoreDB;
DROP DATABASE IF EXISTS RetailProductDB;

CREATE DATABASE EmployeeDB;
SHOW DATABASES;

USE EmployeeDB;
SELECT DATABASE() AS CurrentDatabase;

CREATE TABLE Employee (EmpID INT PRIMARY KEY, EmpName VARCHAR(30));
INSERT INTO Employee VALUES (1, 'Rahul'), (2, 'Sneha');

CREATE DATABASE CompanyEmployeeDB;
RENAME TABLE EmployeeDB.Employee TO CompanyEmployeeDB.Employee;  
DROP DATABASE EmployeeDB;                                       
SHOW DATABASES;

USE CompanyEmployeeDB;
SHOW TABLES;
SELECT * FROM Employee;    

DROP DATABASE CompanyEmployeeDB;
SHOW DATABASES;

CREATE DATABASE ProductStoreDB;
USE ProductStoreDB;
CREATE TABLE Product (ProductID INT PRIMARY KEY, ProductName VARCHAR(30));
INSERT INTO Product VALUES (1, 'Laptop'), (2, 'Phone');
SHOW DATABASES;

CREATE DATABASE RetailProductDB;
RENAME TABLE ProductStoreDB.Product TO RetailProductDB.Product;
DROP DATABASE ProductStoreDB;
SHOW DATABASES;

USE RetailProductDB;
SHOW TABLES;
SELECT * FROM Product;

DROP DATABASE RetailProductDB;
SHOW DATABASES;
