WITH recursive numbers AS(
	SELECT 2 AS number

	UNION ALL

	SELECT number + 2
	FROM numbers
	WHERE number < 10
)
SELECT number
FROM numbers


-- Generate a Series of Dates: between 2025-05-05 to 2025-06-12
WITH recursive date_series AS(
	SELECT '2025-05-05'::Date AS date

	UNION ALL

	SELECT (date + Interval '1 Day')::Date
	FROM date_series
	WHERE date < '2025-06-12'::Date
)
SELECT date
FROM date_series


-- Calculating Factorial using recursive CTE
WITH recursive factorial_cte AS(
	SELECT 1 AS n, 1 AS factorial
	UNION
	SELECT n + 1, factorial * (n + 1)
	FROM factorial_cte
	WHERE n < 8
)
SELECT *
FROM factorial_cte
