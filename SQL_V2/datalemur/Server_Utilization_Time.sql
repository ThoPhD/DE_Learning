--https://datalemur.com/questions/total-utilization-time

WITH server_utilization_cte AS (
  SELECT *,
    DENSE_RANK() OVER(PARTITION BY server_id ORDER BY status_time) AS rn,
    LAG(status_time) OVER(PARTITION BY server_id ORDER BY status_time) AS start_time
  FROM server_utilization
),

server_running_hours AS(
  SELECT
    EXTRACT(EPOCH FROM status_time - start_time) / 3600 AS running_hours
  FROM server_utilization_cte
  WHERE rn % 2 = 0
)

SELECT (SUM(running_hours) / 24)::INT AS total_uptime_days
FROM server_running_hours

--Method 2: FROM Datalemur Solution
WITH running_time
AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER (
      PARTITION BY server_id
      ORDER BY status_time) AS stop_time
  FROM server_utilization
)

SELECT
  DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM running_time
WHERE session_status = 'start'
  AND stop_time IS NOT NULL;
