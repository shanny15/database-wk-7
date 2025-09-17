-- Question 1
WITH Normalized1NF AS (
    SELECT 
        OrderID,
        CustomerName,
        LTRIM(RTRIM(value)) AS Product
    FROM ProductDetail
    CROSS APPLY STRING_SPLIT(Products, ',')
)


-- Question 2

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM Normalized1NF;


-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT DEFAULT 1, -- default since no quantity info in ProductDetail
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product)
SELECT OrderID, Product
FROM Normalized1NF;
