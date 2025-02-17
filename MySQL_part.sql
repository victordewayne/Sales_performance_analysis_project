CREATE DATABASE EcommerceDB;
USE EcommerceDB;

CREATE TABLE Customers(
    CustomerID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(20),
    Email VARCHAR(100),
    Country VARCHAR(100)
    );
    
CREATE TABLE Orders(
	OrderID VARCHAR(20) PRIMARY KEY,
    CustomerID VARCHAR(20),
    OrderDate DATE,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    );
    
CREATE TABLE Products(
	ProductID VARCHAR(20) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    BasePrice DECIMAL(10,2)
    
    );
    
SELECT * FROM Customers ;

#importing the data into customer table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers_split.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(CustomerID, Name, Email, Country);

SELECT * FROM Customers ;

ALTER TABLE Customers  
MODIFY COLUMN Country VARCHAR(100);

#importing data into the products table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products_split.csv'
INTO TABLE Products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(ProductID, ProductName, Category, BasePrice);

SELECT * FROM Products ;

#importing the data into the orders table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders_split.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS
(OrderID, CustomerID, OrderDate, TotalPrice);

SELECT * FROM Orders ;

#query for checking missing values 
SELECT 
    (SELECT COUNT(*) FROM Customers WHERE Name IS NULL OR Email IS NULL OR Country IS NULL) AS MissingCustomers,
    (SELECT COUNT(*) FROM Products WHERE ProductName IS NULL OR Category IS NULL OR BasePrice IS NULL) AS MissingProducts,
    (SELECT COUNT(*) FROM Orders WHERE OrderDate IS NULL OR TotalPrice IS NULL) AS MissingOrders;
    

#query for checking duplicates
SELECT CustomerID, COUNT(*) FROM Customers GROUP BY CustomerID HAVING COUNT(*) > 1;
SELECT ProductID, COUNT(*) FROM Products GROUP BY ProductID HAVING COUNT(*) > 1;
SELECT OrderID, COUNT(*) FROM Orders GROUP BY OrderID HAVING COUNT(*) > 1;

SELECT MIN(CustomerID) FROM Customers GROUP BY Email;


#Normalizing data

UPDATE Customers SET Name = CONCAT(UCASE(LEFT(Name,1)), LCASE(SUBSTRING(Name,2)));
UPDATE Customers SET Email = LOWER(Email);
UPDATE Products SET ProductName = TRIM(ProductName);


SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;

