--https://datalemur.com/questions/user-retention

WITH cte AS(
  SELECT
    user_id,
    count(DISTINCT EXTRACT(MONTH FROM event_date)) AS month_count
  FROM user_actions
  WHERE EXTRACT(YEAR FROM event_date) = 2022
    AND (EXTRACT(MONTH FROM event_date) IN (6, 7)
    )
  GROUP BY user_id
)

SELECT 7 AS month,
  COUNT(*) AS monthly_active_users
FROM cte
WHERE month_count > 1


WITH user_month_activity AS (
  SELECT DISTINCT
    user_id,
    EXTRACT(YEAR FROM event_date) AS yr,
    EXTRACT(MONTH FROM event_date) AS mo
  FROM user_actions
  WHERE event_type IN ('sign-in', 'like', 'comment')
),

paired_activity AS (
  SELECT
    curr.user_id,
    curr.yr,
    curr.mo
  FROM user_month_activity curr
  JOIN user_month_activity prev
    ON curr.user_id = prev.user_id
    AND (
         (curr.yr = prev.yr AND curr.mo = prev.mo + 1)
      OR (curr.yr = prev.yr + 1 AND prev.mo = 12 AND curr.mo = 1)
    )
)

SELECT
  mo AS month,
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM paired_activity
GROUP BY mo
ORDER BY mo;
