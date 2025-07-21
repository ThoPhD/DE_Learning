-- https://datalemur.com/questions/sql-swapped-food-delivery

WITH cte AS (
SELECT *, 
  LAG(item) OVER() AS prev_item,
  LEAD(item) OVER() AS next_item,
  MAX(order_id) OVER() AS max_id
FROM orders 
)
SELECT order_id AS corrected_order_id,
  CASE
    WHEN order_id % 2 = 0 THEN prev_item
    WHEN order_id = max_id AND order_id % 2 = 1 THEN item
    ELSE next_item
  END AS item
FROM cte
