-- https://datalemur.com/questions/signup-confirmation-rate

-- Method 1
SELECT 
  ROUND(COUNT(texts.email_id)::DECIMAL / COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
  ON emails.email_id = texts.email_id
  AND texts.signup_action = 'Confirmed';  


-- Method 2

WITH cte AS (
SELECT e.email_id AS email_id,
  e.signup_date,
  t.email_id AS active_email,
  t.signup_action
FROM emails e
LEFT JOIN texts t
ON e.email_id = t.email_id
AND t.signup_action = 'Confirmed'
)
SELECT ROUND((COUNT(active_email)::DECIMAL / COUNT(email_id)), 2) AS confirm_rate
FROM cte
