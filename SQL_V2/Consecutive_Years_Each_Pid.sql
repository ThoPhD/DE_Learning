-- Write a query to find out the events with 3 or more consitive years for each pid

CREATE TABLE pid_events ( pid INT, year INT );
-- Insert data into the table 
INSERT INTO pid_events VALUES (1, 2019), (1, 2020), (1, 2021), (2, 2022), (2, 2021),(3, 2019), (3, 2021), (3, 2022);

WITH cte AS(
	SELECT *, 
	LAG(year) OVER(PARTITION BY pid ORDER BY year) AS prev_year,
	LEAD(year) OVER(PARTITION BY pid ORDER BY year) AS next_year
	FROM pid_events
)

SELECT DISTINCT pid
FROM cte
WHERE year - prev_year = 1
	AND next_year - year = 1
	