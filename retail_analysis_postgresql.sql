CREATE TABLE onlineretail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC(10,2),
    CustomerID INT,
    Country VARCHAR(100)
);
SELECT * FROM onlineretail LIMIT 10;

SELECT COUNT(*) AS total_transactions FROM onlineretail;

-- To find the most popular products
SELECT StockCode, Description, COUNT(*) AS purchase_count
FROM onlineretail
GROUP BY StockCode, Description
ORDER BY purchase_count DESC
LIMIT 10;

-- Top 10 countries by Sales
SELECT Country, SUM(Quantity * UnitPrice) AS total_sales
FROM onlineretail
GROUP BY Country
ORDER BY total_sales DESC
LIMIT 10;

-- Top 10 customers
SELECT CustomerID, SUM(Quantity * UnitPrice) AS total_spent
FROM onlineretail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- Most purchased products per country
WITH RankedProducts AS (
    SELECT 
        Country, 
        StockCode, 
        Description,
        COUNT(*) AS purchase_count,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY COUNT(*) DESC) AS ranked  
    FROM onlineretail  
    GROUP BY Country, StockCode, Description  
)  
SELECT Country, StockCode, Description, purchase_count  
FROM RankedProducts  
WHERE ranked <= 10
ORDER BY ranked ASC, Country;





