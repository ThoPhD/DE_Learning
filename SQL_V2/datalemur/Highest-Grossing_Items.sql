--https://datalemur.com/questions/sql-highest-grossing

WITH max_spend_by_product_and_category AS (
  SELECT category,	product, SUM(spend) AS spend
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category,	product
),
product_spend_with_rank AS (
  SELECT category,	product, spend,
    dense_rank() OVER(PARTITION BY category ORDER BY spend DESC) AS ds_rnk
  FROM max_spend_by_product_and_category
)

SELECT category,	product, spend AS total_spend
FROM product_spend_with_rank
WHERE ds_rnk < 3
