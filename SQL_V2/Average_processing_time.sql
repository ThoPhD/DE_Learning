CREATE TABLE Activity (
    machine_id INT,
    process_id INT,
    activity_type VARCHAR(10),
    timestamp DECIMAL(10,3)
);

INSERT INTO Activity (machine_id, process_id, activity_type, timestamp) VALUES
(0, 0, 'start', 0.712),
(0, 0, 'end', 1.520),
(0, 1, 'start', 3.140),
(0, 1, 'end', 4.120),
(1, 0, 'start', 0.550),
(1, 0, 'end', 1.550),
(1, 1, 'start', 0.430),
(1, 1, 'end', 1.420),
(2, 0, 'start', 4.100),
(2, 0, 'end', 4.512),
(2, 1, 'start', 2.500),
(2, 1, 'end', 5.000);

-- Write a Query to find the average time each machine takes to complete a process.

WITH activity_temp AS ( SELECT machine_id,
	process_id,
	CASE WHEN activity_type = 'start' THEN timestamp ELSE NULL END AS start_time,
	CASE WHEN activity_type = 'end' THEN timestamp ELSE NULL END AS end_time
FROM Activity),

activity_with_process_time AS (
SELECT machine_id,
	process_id,
	MAX(end_time) - MAX(start_time) AS process_time
FROM activity_temp
GROUP BY 1, 2)

SELECT machine_id,
ROUND(AVG(process_time), 3) AS avg_process_time
FROM activity_with_process_time
GROUP BY 1
;

SELECT * FROM Activity;

-- Method 2:

WITH cte AS(
SELECT *, 
timestamp - LAG(timestamp) OVER(PARTITION BY machine_id, process_id ORDER BY process_id) AS process_time
FROM Activity)

SELECT machine_id,
	ROUND(AVG(process_time), 3) AS avg_process_time
FROM cte
WHERE process_time IS NOT NULL
GROUP BY 1
;

