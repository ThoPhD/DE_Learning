--https://datalemur.com/questions/histogram-users-purchases

WITH cte AS(
SELECT product_id,
  user_id,
  transaction_date,
  ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date::DATE DESC) AS rn,
  COUNT(product_id) OVER(PARTITION BY user_id, transaction_date::DATE ORDER BY transaction_date::DATE DESC) AS purchase_count
FROM user_transactions
)
SELECT
  transaction_date,
  user_id,
  purchase_count
FROM cte
WHERE rn = 1
ORDER BY transaction_date
