-- https://datalemur.com/questions/supercloud-customer

WITH cte AS (
SELECT cc.customer_id, count(DISTINCT p.product_category) AS purchased_category_cnt
FROM customer_contracts cc
LEFT JOIN products p
ON cc.product_id = p.product_id
GROUP BY cc.customer_id
)

SELECT customer_id
FROM cte 
WHERE
purchased_category_cnt = (SELECT COUNT(DISTINCT product_category) FROM products)
