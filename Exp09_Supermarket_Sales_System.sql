SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS SupermarketDB;
CREATE DATABASE SupermarketDB;
USE SupermarketDB;

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(50),
    Category    VARCHAR(30),
    Price       DECIMAL(10,2) NOT NULL,
    StockQty    INT NOT NULL DEFAULT 0
);

CREATE TABLE Customers (
    CustomerID   INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(50) NOT NULL,
    Phone        VARCHAR(10) UNIQUE,
    Address      VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID     INT PRIMARY KEY AUTO_INCREMENT,
    ProductID  INT NOT NULL,
    CustomerID INT NOT NULL,
    Quantity   INT NOT NULL,
    SaleDate   DATE NOT NULL,
    Status     VARCHAR(15) DEFAULT 'Pending',
    FOREIGN KEY (ProductID)  REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Products (ProductName, Category, Price, StockQty) VALUES
('Basmati Rice 5kg', 'Grocery',   450.00, 100),
('Amul Milk 1L',     'Dairy',      60.00, 200),
('Wheat Flour 10kg', 'Grocery',   380.00,  80),
('Toothpaste',       'Personal',   95.00, 150),
('Orange Juice 1L',  'Beverages', 120.00,  90),
('Chocolate Bar',    'Snacks',     40.00, 300);

INSERT INTO Customers (CustomerName, Phone, Address) VALUES
('Rahul Sharma', '9876543210', 'Bhubaneswar'),
('Sneha Das',    '9876543211', 'Cuttack'),
('Amit Mishra',  '9876543212', 'Puri'),
('Priya Patra',  '9876543213', 'Rourkela'),
('Kiran Behera', '9876543214', 'Berhampur'),
('Divya Rout',   '9876543215', 'Balasore');

INSERT INTO Sales (ProductID, CustomerID, Quantity, SaleDate, Status) VALUES
(1, 1, 2, '2026-02-01', 'Completed'),
(2, 1, 5, '2026-02-01', 'Completed'),
(3, 2, 1, '2026-02-03', 'Pending'),
(4, 3, 3, '2026-02-05', 'Completed'),
(5, 4, 2, '2026-02-06', 'Pending');

SELECT * FROM Products;

SELECT * FROM Customers;

SELECT s.SaleID, p.ProductName, p.Category, p.Price, s.Quantity,
       c.CustomerName, c.Phone, s.SaleDate, s.Status
FROM Sales s
JOIN Products  p ON s.ProductID  = p.ProductID
JOIN Customers c ON s.CustomerID = c.CustomerID;

SELECT p.ProductName, c.CustomerName, s.SaleDate
FROM Sales s
JOIN Products  p ON s.ProductID  = p.ProductID
JOIN Customers c ON s.CustomerID = c.CustomerID;

INSERT INTO Sales (ProductID, CustomerID, Quantity, SaleDate, Status)
VALUES (4, 5, 4, CURDATE(), 'Pending');
UPDATE Products SET StockQty = StockQty - 4 WHERE ProductID = 4;
SELECT ProductID, ProductName, StockQty FROM Products WHERE ProductID = 4;

UPDATE Sales SET Status = 'Completed' WHERE SaleID = 3;
SELECT * FROM Sales;

UPDATE Products SET Price = Price * 1.10 WHERE ProductID = 1;
SELECT ProductID, ProductName, Price FROM Products WHERE ProductID = 1;

DELETE FROM Customers WHERE CustomerID = 6;
SELECT * FROM Customers;

DELETE FROM Products WHERE ProductID = 6;
SELECT * FROM Products;

ALTER TABLE Products ADD ExpiryDate DATE;
UPDATE Products SET ExpiryDate = '2026-12-31' WHERE Category IN ('Grocery', 'Beverages');
UPDATE Products SET ExpiryDate = '2026-03-15' WHERE Category = 'Dairy';
SELECT * FROM Products;

ALTER TABLE Customers DROP COLUMN Address;
DESCRIBE Customers;

RENAME TABLE Sales TO Transactions;
SHOW TABLES;

TRUNCATE TABLE Transactions;
SELECT * FROM Transactions;

INSERT INTO Transactions (ProductID, CustomerID, Quantity, SaleDate, Status) VALUES
(1, 1, 2, '2026-02-01', 'Completed'),
(2, 1, 5, '2026-02-01', 'Completed'),
(3, 2, 1, '2026-02-03', 'Completed'),
(4, 3, 3, '2026-02-05', 'Completed'),
(5, 4, 2, '2026-02-06', 'Pending'),
(4, 5, 4, '2026-02-10', 'Pending');

ALTER TABLE Products MODIFY ProductName VARCHAR(50) NOT NULL;
DESCRIBE Products;

ALTER TABLE Products ADD CONSTRAINT chk_price CHECK (Price > 0);
SHOW CREATE TABLE Products;

SELECT c.CustomerName, p.ProductName, t.Quantity, t.Status
FROM Customers c
INNER JOIN Transactions t ON c.CustomerID = t.CustomerID
INNER JOIN Products     p ON t.ProductID  = p.ProductID;

SELECT c.CustomerName, p.ProductName, t.Quantity, t.Status
FROM Customers c
LEFT JOIN Transactions t ON c.CustomerID = t.CustomerID
LEFT JOIN Products     p ON t.ProductID  = p.ProductID;

SELECT COUNT(*) AS TotalProducts FROM Products;

SELECT MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice FROM Products;

SELECT COUNT(*) AS CompletedSales FROM Transactions WHERE Status = 'Completed';

CREATE VIEW CompletedSalesView AS
SELECT p.ProductName, c.CustomerName, t.SaleDate
FROM Transactions t
JOIN Products  p ON t.ProductID  = p.ProductID
JOIN Customers c ON t.CustomerID = c.CustomerID
WHERE t.Status = 'Completed';

SELECT * FROM CompletedSalesView;

DELIMITER $$
CREATE PROCEDURE GetCompletedSales()
BEGIN
    SELECT p.ProductName, c.CustomerName, t.SaleDate
    FROM Transactions t
    JOIN Products  p ON t.ProductID  = p.ProductID
    JOIN Customers c ON t.CustomerID = c.CustomerID
    WHERE t.Status = 'Completed';
END$$
DELIMITER ;

CALL GetCompletedSales();
