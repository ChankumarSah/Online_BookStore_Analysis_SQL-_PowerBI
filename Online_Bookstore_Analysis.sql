-- =====================================
-- DATABASE SETUP
-- =====================================

-- Create Database
CREATE DATABASE OnlineBookstore;

-- Use Database
USE OnlineBookstore;

-- Drop Tables if they exist
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;

-- Create Books Table
CREATE TABLE Books (
    Book_ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);

-- Create Customers Table
CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- Create Orders Table
CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),

    CONSTRAINT FK_Customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID),

    CONSTRAINT FK_Book
        FOREIGN KEY (Book_ID)
        REFERENCES Books(Book_ID)
);

-- =====================================
-- BASIC DATA EXPLORATION
-- =====================================

-- View Tables
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- Retrieve all books in Fiction genre
SELECT * FROM Books 
WHERE Genre = 'Fiction';

-- Books published after 1950
SELECT * FROM Books
WHERE Published_Year > 1950;

-- Customers from Canada
SELECT * FROM Customers
WHERE Country = 'Canada';

-- Available genres
SELECT DISTINCT Genre FROM Books;


-- =====================================
-- SALES ANALYSIS
-- =====================================

-- Orders placed in November 2023
SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- Total revenue generated
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

-- Average price of Fantasy books
SELECT AVG(Price) AS Avg_Fantasy_Price
FROM Books
WHERE Genre = 'Fantasy';

-- Total books sold per genre
SELECT 
b.Genre,
SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b
ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- Most frequently ordered books
SELECT 
o.Book_ID,
b.Title,
COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Books b
ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC
LIMIT 5;

-- Top 3 most expensive Fantasy books
SELECT *
FROM Books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC
LIMIT 3;

-- Monthly revenue
SELECT 
MONTH(Order_Date) AS Month,
SUM(Total_Amount) AS Revenue
FROM Orders
GROUP BY MONTH(Order_Date)
ORDER BY Month;

-- Revenue by Genre
SELECT 
b.Genre,
SUM(o.Total_Amount) AS Revenue
FROM Orders o
JOIN Books b
ON o.Book_ID = b.Book_ID
GROUP BY b.Genre
ORDER BY Revenue DESC;


-- =====================================
-- CUSTOMER ANALYSIS
-- =====================================

-- Customers who placed more than 1 quantity order
SELECT *
FROM Orders
WHERE Quantity > 1;

-- Customers who placed at least 2 orders
SELECT 
o.Customer_ID,
c.Name,
COUNT(o.Order_ID) AS Order_Count
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY o.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- Cities where customers spent more than $30
SELECT DISTINCT
c.City
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- Top cities by number of orders
SELECT 
c.City,
COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY Total_Orders DESC;

-- Customer lifetime value
SELECT 
c.Customer_ID,
c.Name,
COUNT(o.Order_ID) AS Total_Orders,
SUM(o.Total_Amount) AS Lifetime_Value
FROM Customers c
JOIN Orders o
ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY Lifetime_Value DESC;


-- =====================================
-- INVENTORY ANALYSIS
-- =====================================

-- Total stock available
SELECT SUM(Stock) AS Total_Stock
FROM Books;

-- Most expensive book
SELECT *
FROM Books
ORDER BY Price DESC
LIMIT 1;

-- Books with lowest stock
SELECT *
FROM Books
ORDER BY Stock ASC
LIMIT 5;

-- Remaining stock after orders
SELECT 
b.Book_ID,
b.Title,
b.Stock,
COALESCE(SUM(o.Quantity),0) AS Ordered_Quantity,
b.Stock - COALESCE(SUM(o.Quantity),0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o
ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock
ORDER BY b.Book_ID;