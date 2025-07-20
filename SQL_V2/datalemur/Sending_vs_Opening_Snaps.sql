--https://datalemur.com/questions/time-spent-snaps

WITH cte AS(
  SELECT ab.age_bucket, ac.activity_type,
    CASE WHEN ac.activity_type = 'send' THEN SUM(ac.time_spent) ELSE NULL END AS time_spent_sending,
    CASE WHEN ac.activity_type = 'open' THEN SUM(ac.time_spent) ELSE NULL END AS time_spent_opening
    -- SUM(time_spent) AS total_time_spent
  FROM activities ac
  LEFT JOIN age_breakdown ab
  ON ac.user_id = ab.user_id
  WHERE ac.activity_type IN ('open', 'send')
  GROUP BY ab.age_bucket, ac.activity_type
),
cte_2 AS (
  SELECT age_bucket,
    MAX(time_spent_sending) AS time_spent_sending,
    MAX(time_spent_opening) AS time_spent_opening
  FROM cte
  GROUP BY age_bucket
)

SELECT age_bucket,
  ROUND((time_spent_sending * 100.0 / (time_spent_sending + time_spent_opening)), 2) AS send_perc,
  ROUND((time_spent_opening * 100.0 / (time_spent_sending + time_spent_opening)), 2) AS open_perc
FROM cte_2
ORDER BY age_bucket
