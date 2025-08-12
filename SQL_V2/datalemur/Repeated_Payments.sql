-- https://datalemur.com/questions/repeated-payments

WITH cte AS (
  SELECT * ,
  EXTRACT(EPOCH FROM (
    transaction_timestamp -
    LAG(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp)
  )) / 60 AS diff_transaction_as_minutes
FROM transactions
)

SELECT 
  COUNT(*) AS payment_count
FROM cte 
WHERE diff_transaction_as_minutes <= 10
