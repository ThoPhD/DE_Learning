--https://datalemur.com/questions/international-call-percentage

WITH phone_calls_with_country AS (
  SELECT
    pc.caller_id,
    pc.receiver_id,
    pi.country_id AS caller_country_id,
    pi_2.country_id AS receiver_country_id
  FROM  phone_info pi
  INNER JOIN phone_calls pc
  ON pi.caller_id = pc.caller_id
  INNER JOIN phone_info pi_2
  ON pc.receiver_id = pi_2.caller_id
)

SELECT
ROUND(((100.0 * SUM(CASE WHEN caller_country_id	!= receiver_country_id THEN 1 ELSE 0 END)) / COUNT(*)), 1) AS international_calls_pct
FROM phone_calls_with_country
