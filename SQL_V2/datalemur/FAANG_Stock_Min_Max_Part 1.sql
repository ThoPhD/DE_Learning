-- https://datalemur.com/questions/sql-bloomberg-stock-min-max-1

WITH cte AS (
  SELECT 
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS month,
    open,
    ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY open DESC) AS rn_desc,
    ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY open) AS rn_asc
  FROM stock_prices
)

SELECT ticker,
  MAX(CASE WHEN rn_desc = 1 THEN month END) AS highest_mth,
  MAX(CASE WHEN rn_desc = 1 THEN open END) AS highest_open,
  MAX(CASE WHEN rn_asc = 1 THEN month END) AS lowest_mth,
  MAX(CASE WHEN rn_asc = 1 THEN open END) AS lowest_open
FROM cte 
GROUP BY ticker
