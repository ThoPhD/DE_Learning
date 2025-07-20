-- Find all the days where the temperature was higher than the previous day.

CREATE TABLE Weather (
    Day DATE PRIMARY KEY,
    Temperature INT
);

INSERT INTO Weather (Day, Temperature) VALUES
('2025-06-01', 78),
('2025-06-02', 79),
('2025-06-03', 78),
('2025-06-04', 80),
('2025-06-05', 79),
('2025-06-06', 81);

-- Expected Output:

-- Day         | Temperature
- ------------|------------
-- 2025-06-02  | 79
-- 2025-06-04  | 80
-- 2025-06-06  | 81

WITH cte AS (
	SELECT 
	  Day,
	  Temperature,
	  LAG(Temperature) OVER (ORDER BY Day) AS Previous_Temperature
	FROM Weather
)
SELECT Day, Temperature
FROM cte
WHERE Temperature - Previous_Temperature > 0 AND Previous_Temperature IS NOT NULL;

