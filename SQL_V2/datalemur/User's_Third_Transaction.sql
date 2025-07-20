--https://datalemur.com/questions/sql-third-transaction

SELECT * FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rn
FROM transactions) tmp
WHERE rn = 3;


SELECT user_id, spend, transaction_date
FROM (
  SELECT *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rn
  FROM transactions
) tmp
WHERE rn = 3;
