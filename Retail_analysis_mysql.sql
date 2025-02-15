CREATE DATABASE TATASales;
USE TATASales;

CREATE TABLE Onlineretail(
  InvoiceNo int,
  StockCode int,
  Description text,
  Quantity int,
  InvoiceDate text,
  UnitPrice double,
  CustomerID int,
  Country text
  );
 
SELECT * from onlineretail;
DESC onlineretail;

SELECT count(*) FROM onlineretail
 WHERE CustomerID = 0 ;

SELECT COUNT(*) FROM onlineretail;

SELECT count(*) FROM onlineretail
 WHERE StockCode = 0 ;
 
 SELECT count(*) FROM onlineretail
 WHERE InvoiceNo = 0 ;
 
 SET SQL_SAFE_UPDATES = 0;
 DELETE FROM onlineretail WHERE InvoiceNo = 0;


-- DATA ANALYSIS
-- Count how many distinct stockcodes are there?

SELECT COUNT(DISTINCT StockCode) AS distinct_stockcode_count
 FROM onlineretail;


-- List all distinct stockcodes and show there associated description
SELECT DISTINCT StockCode, Description
FROM onlineretail;

-- Top 5 best-selling products
SELECT Description, SUM(Quantity) AS TotalSold
FROM onlineretail
GROUP BY Description
ORDER BY TotalSold DESC
LIMIT 5;

-- Top spending customers
SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalSpent
FROM onlineretail
GROUP BY CustomerID
ORDER BY TotalSpent DESC
LIMIT 5;

-- Top 10 products across all countries
SELECT StockCode, COUNT(StockCode) AS Countofproducts
From onlineretail
WHERE StockCode IS NOT NULL
Group BY StockCode
ORDER BY Countofproducts DESC
LIMIT 10;


-- Top 10 distinct products country wise and rank them 1 to 10 
WITH RankedProducts AS (
  SELECT 
    Country, 
    StockCode, 
    COUNT(*) AS purchase_count,  -- Add COUNT(*) properly
    ROW_NUMBER() OVER (PARTITION BY Country ORDER BY COUNT(*) DESC) AS ranked  
  FROM onlineretail  
  GROUP BY Country, StockCode  
)  
SELECT Country, StockCode, ranked  
FROM RankedProducts  
WHERE ranked <= 10
ORDER BY ranked ASC, Country;

--  Monthly Sales Analysis
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, SUM(Quantity * UnitPrice) AS Revenue
FROM onlineretail
GROUP BY Month
ORDER BY Month;

-- Top 5 Countries by Revenue

SELECT Country, SUM(Quantity * UnitPrice) AS Revenue
FROM onlineretail
GROUP BY Country
ORDER BY Revenue DESC
LIMIT 5;

-- average revenue per order
SELECT AVG(Total) AS Average_Order_Value
FROM (
  SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS Total
  FROM onlineretail
  GROUP BY InvoiceNo
) AS OrderTotals;





 