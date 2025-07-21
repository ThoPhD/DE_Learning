-- https://datalemur.com/questions/odd-even-measurements

WITH measurements_with_rn AS (
  SELECT measurement_value,
    measurement_time,
    measurement_time::date AS measurement_day,
    ROW_NUMBER() OVER(PARTITION BY measurement_time::date ORDER BY  measurement_time) AS rn
  FROM measurements
)

SELECT
  measurement_day,
  sum(measurement_value) FILTER (WHERE rn % 2 = 1) AS odd_sum,
  sum(measurement_value) FILTER (WHERE rn % 2 = 0) AS evn_sum
FROM measurements_with_rn
GROUP BY
  measurement_day
