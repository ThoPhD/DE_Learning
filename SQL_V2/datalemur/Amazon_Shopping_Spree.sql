--https://datalemur.com/questions/amazon-shopping-spree

WITH cte AS(
  SELECT user_id,
    transaction_date::date,
    LAG(transaction_date::date) OVER(PARTITION BY user_id ORDER BY transaction_date::date) AS prev_date,
    LEAD(transaction_date::date) OVER(PARTITION BY user_id ORDER BY transaction_date::date) AS next_date
  FROM transactions
)
SELECT DISTINCT user_id
FROM cte
WHERE transaction_date - prev_date = 1
  AND next_date - transaction_date = 1

--Method 2: using selfjoin table
SELECT DISTINCT T1.user_id
FROM transactions AS T1
INNER JOIN transactions AS T2
  ON DATE(T2.transaction_date) = DATE(T1.transaction_date) + 1
INNER JOIN transactions AS T3
  ON DATE(T3.transaction_date) = DATE(T1.transaction_date) + 2
ORDER BY T1.user_id;
