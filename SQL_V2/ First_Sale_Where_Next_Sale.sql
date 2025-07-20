-- Write a Query to Find First Sale Where Next Sale is 30+ Days Later

-- Description: Find the first sale (i.e with the earliest SaleDate) for each BookID
-- where the next sale (if it exists) occurred more than 30 days later

CREATE TABLE BookSales (
    SaleID INT PRIMARY KEY,
    BookID INT,
    SaleDate DATE,
    Price DECIMAL(10, 2)
);

INSERT INTO BookSales (SaleID, BookID, SaleDate, Price) VALUES
(1, 101, '2023-01-05', 19.99),
(2, 101, '2023-01-10', 21.99),
(3, 101, '2023-02-01', 25.99),
(4, 102, '2023-01-15', 17.50),
(5, 102, '2023-02-05', 18.00),
(6, 102, '2023-03-01', 22.00),
(7, 103, '2023-01-20', 10.00),
(8, 103, '2023-02-20', 15.00),
(9, 104, '2023-01-01', 5.00),
(10, 104, '2023-04-01', 8.00);

-- Expected Output:

-- BookID FirstSaleDate NextSaleDate

-- 103   2023-01-20 2023-02-20
-- 104   2023-01-01 2023-04-01
WITH cte AS (
	SELECT *,
	ROW_NUMBER() OVER(PARTITION BY bookid ORDER BY saledate) AS rn,
	LEAD(saledate) OVER(PARTITION BY bookid) AS next_sale_date
	FROM BookSales
)

SELECT bookid, saledate, next_sale_date
FROM cte
WHERE rn = 1
AND next_sale_date - saledate > 30
