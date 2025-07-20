-- Write a Query to Find Customers Whose First Order Was Their Biggest

CREATE TABLE Ordering_a (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO Ordering_a (order_id, customer_id, order_date, amount) VALUES
-- Customer 201: First order 150, later 300 → Not qualified
(1, 201, '2023-01-01', 150.00),
(3, 201, '2023-01-10', 300.00),

-- Customer 202: First order 200, has 250 later → Not qualified
(2, 202, '2023-01-05', 200.00),
(5, 202, '2023-01-20', 50.00),
(7, 202, '2023-02-01', 250.00),

-- Customer 203: Only one order → Qualified (first and max are same)
(4, 203, '2023-01-15', 100.00),

-- Customer 204: First and only order is 400 → Qualified
(6, 204, '2023-01-25', 400.00),

-- Customer 205: First order is 500, second is 100 → Qualified
(8, 205, '2023-01-02', 500.00),
(9, 205, '2023-01-05', 100.00),

-- Customer 206: First order 100, second 100 → Qualified (same amount both times)
(10, 206, '2023-01-01', 100.00),
(11, 206, '2023-01-02', 100.00),

-- Customer 207: First order 100, second 200 → Not qualified
(12, 207, '2023-01-01', 100.00),
(13, 207, '2023-01-10', 200.00);

-- Expected Output:

-- customer_id

-- 203
-- 204
-- 205
-- 206

WITH first_Ordering AS (
	SELECT *, row_number() over(partition by customer_id order by order_date) AS rn,
	MAX(amount) OVER(PARTITION BY customer_id) AS max_amount
	FROM Ordering_a
)
SELECT customer_id, order_date, amount
FROM first_Ordering fo
WHERE rn = 1
AND amount = max_amount
