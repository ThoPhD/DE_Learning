-- Problem Name: Past Active Customers

-- Problem Statement
-- Find customers who have not placed any orders yet in 2025 but had placed orders in every month of 2024
-- and had placed orders in at least 6 of months in 2023.

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    customer_name VARCHAR(100),
    order_date DATE
);

-- Step 1: Insert customers with special ordering patterns
-- These customers:
-- - Have orders in EVERY MONTH of 2024
-- - Have orders in AT LEAST 6 MONTHS of 2023
-- - Have NO orders in 2025

-- Customer 1: Alice
-- Customer 2: Bob
-- (Add more if needed)

-- Orders for 2023 (at least 6 months)
INSERT INTO orders (customer_id, customer_name, order_date)
VALUES
(1, 'Alice', '2023-01-15'),
(1, 'Alice', '2023-02-20'),
(1, 'Alice', '2023-04-10'),
(1, 'Alice', '2023-06-18'),
(1, 'Alice', '2023-09-25'),
(1, 'Alice', '2023-11-03'),

(2, 'Bob', '2023-03-08'),
(2, 'Bob', '2023-05-14'),
(2, 'Bob', '2023-07-19'),
(2, 'Bob', '2023-08-23'),
(2, 'Bob', '2023-09-23'),
(2, 'Bob', '2023-09-24'),
(2, 'Bob', '2023-10-01'),
(2, 'Bob', '2023-12-30');

-- Orders for 2024 (every month)
DO $$
DECLARE
    m INT;
BEGIN
    FOR m IN 1..12 LOOP
        INSERT INTO orders (customer_id, customer_name, order_date)
        VALUES 
        (1, 'Alice', make_date(2024, m, 10)),
        (2, 'Bob', make_date(2024, m, 15));
    END LOOP;
END $$;

-- Step 2: Insert other customers with various patterns including 2025
-- Customer 3: Charlie (ordered in all years including 2025)
INSERT INTO orders (customer_id, customer_name, order_date)
VALUES
(3, 'Charlie', '2022-07-22'),
(3, 'Charlie', '2023-03-05'),
(3, 'Charlie', '2024-08-17'),
(3, 'Charlie', '2025-01-12');

-- Customer 4: Dana (only ordered in 2025)
INSERT INTO orders (customer_id, customer_name, order_date)
VALUES
(4, 'Dana', '2025-04-02');


WITH orders_by_year_month AS (
    SELECT 
        customer_id,
        EXTRACT(YEAR FROM order_date)::INT AS order_year,
        EXTRACT(MONTH FROM order_date)::INT AS order_month
    FROM orders
    GROUP BY customer_id, order_year, order_month
),

-- Find customers with orders in every month of 2024
customers_2024_all_months AS (
    SELECT customer_id
    FROM orders_by_year_month
    WHERE order_year = 2024
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_month) = 12
),

-- Find customers with orders in at least 6 months of 2023
customers_2023_min_6_months AS (
    SELECT customer_id
    FROM orders_by_year_month
    WHERE order_year = 2023
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_month) >= 6
),

-- Find customers with any order in 2025 (to exclude)
customers_with_orders_2025 AS (
    SELECT DISTINCT customer_id
    FROM orders_by_year_month
    WHERE order_year = 2025
)

-- Final filter: 2024 all months, 2023 at least 6 months, and NO 2025 orders
SELECT DISTINCT
	o.customer_name,
    c2024.customer_id
FROM orders o
JOIN
    customers_2024_all_months c2024
ON o.customer_id = c2024.customer_id
JOIN 
    customers_2023_min_6_months c2023
    ON o.customer_id = c2023.customer_id
LEFT JOIN 
    customers_with_orders_2025 c2025
    ON o.customer_id = c2025.customer_id
WHERE 
    c2025.customer_id IS NULL;

