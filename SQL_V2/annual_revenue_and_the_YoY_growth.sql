-- Calculate total revenue and the Year over year growth percent

--- Create Transaction table
CREATE TABLE transactions (
    customer_id INT,
    transaction_date DATE,
    amount NUMERIC
);

-- Insert values
INSERT INTO transactions (customer_id, transaction_date, amount) VALUES
(1, '2018-01-10', 100),

(1, '2022-01-10', 100),
(2, '2022-03-15', 200),
(3, '2022-07-20', 150),
(1, '2023-02-12', 300),
(2, '2023-04-25', 400),
(3, '2023-08-05', 250),
(1, '2024-01-10', 500),
(2, '2024-03-15', 600),
(3, '2024-07-20', 550);

-- Method 1: Without step by year
WITH revenue_by_year AS(
	SELECT EXTRACT(year FROM transaction_date) AS current_year,
		SUM(amount) AS total_revenue
	FROM transactions
	GROUP BY current_year
),
yoy_revenue AS (
	SELECT current_year,
		total_revenue,
		LAG(total_revenue) OVER(order by current_year) AS previous_year_revenue
	FROM revenue_by_year
)

SELECT current_year,
	total_revenue,
	previous_year_revenue,
	ROUND((100 * (total_revenue - previous_year_revenue) / previous_year_revenue), 2) AS yoy_growth_percent
FROM yoy_revenue


-- Method 2: With step = 1 year
WITH revenue_by_year AS(
	SELECT EXTRACT(year FROM transaction_date) AS current_year,
		SUM(amount) AS total_revenue
	FROM transactions
	GROUP BY current_year
)

SELECT 
    t1.current_year,
    t1.total_revenue,
    t2.total_revenue AS previous_year_revenue,
	ROUND((t1.total_revenue - t2.total_revenue) * 100 / t2.total_revenue, 2) AS yoy_growth_percent
FROM revenue_by_year t1
LEFT JOIN revenue_by_year t2 
    ON t1.current_year = t2.current_year + 1
ORDER BY t1.current_year;

-- Method 3: Using Lag function with condition check
WITH revenue_by_year AS(
	SELECT EXTRACT(year FROM transaction_date) AS current_year,
		SUM(amount) AS total_revenue
	FROM transactions
	GROUP BY current_year
),
revenue_with_history AS (
	SELECT 
	    current_year,
	    total_revenue,
	    LAG(current_year) OVER (ORDER BY current_year) AS prev_year,
	    LAG(total_revenue) OVER (ORDER BY current_year) AS prev_revenue
  FROM revenue_by_year
)

SELECT 
  current_year,
  total_revenue,
  CASE 
    WHEN current_year - prev_year = 1 THEN prev_revenue
    ELSE NULL
  END AS previous_year_revenue
FROM revenue_with_history
ORDER BY current_year;
