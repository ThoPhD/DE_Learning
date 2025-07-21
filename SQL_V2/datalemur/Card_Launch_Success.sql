--https://datalemur.com/questions/card-launch-success

Method 1: Using ROW_NUMBER()
WITH cte AS (
  SELECT issue_month::VARCHAR || '/' || issue_year AS issue_month,
    card_name,
    issued_amount,
    ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY (issue_month::VARCHAR || '/' || issue_year)) AS rn
  FROM monthly_cards_issued
)
SELECT card_name, issued_amount
from cte
WHERE rn = 1
ORDER BY issued_amount DESC

-- Method 2: Using MAKE_DATE() Window function
WITH card_launch AS (
  SELECT
    card_name,
    issued_amount,
    MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
    MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (
      PARTITION BY card_name) AS launch_date
  FROM monthly_cards_issued
)

SELECT
  card_name,
  issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;
