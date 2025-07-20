CREATE TABLE Orders_2 (
	id INT GENERATED ALWAYS AS IDENTITY,
    created_at timestamp NOT NULL DEFAULT NOW(),
    OrderAmount DECIMAL(10, 2) NOT NULL,
    order_id VARCHAR(20) NOT NULL
);


INSERT INTO Orders_2 (created_at, OrderAmount, order_id)
VALUES 
('2025-04-01 10:23:00', 259.99, 'ORD1001'),
('2025-04-02 11:45:00', 149.50, 'ORD1002'),
('2025-04-03 12:12:00', 89.99, 'ORD1003'),
('2025-05-01 13:05:00', 130.00, 'ORD1004'),
('2025-01-01 14:33:00', 299.49, 'ORD1005'),
('2025-02-02 09:10:00', 200.00, 'ORD1006'),
('2025-03-02 09:45:00', 99.00, 'ORD1007'),
('2025-04-02 10:20:00', 79.75, 'ORD1008'),
('2025-04-02 10:30:00', 310.10, 'ORD1009'),
('2025-04-02 11:00:00', 215.99, 'ORD1010'),
('2025-05-03 08:15:00', 50.00, 'ORD1011'),
('2025-03-03 09:25:00', 399.99, 'ORD1012'),
('2025-06-03 10:10:00', 120.00, 'ORD1013'),
('2025-06-03 10:40:00', 190.25, 'ORD1014'),
('2025-06-03 11:30:00', 175.00, 'ORD1015'),
('2025-06-04 07:55:00', 210.00, 'ORD1016'),
('2025-06-04 08:45:00', 225.00, 'ORD1017'),
('2025-01-04 09:15:00', 165.00, 'ORD1018'),
('2025-01-04 10:00:00', 199.99, 'ORD1019'),
('2025-01-04 11:45:00', 349.49, 'ORD1020'),
('2025-01-05 08:05:00', 275.00, 'ORD1021'),
('2025-05-05 09:10:00', 330.99, 'ORD1022'),
('2025-05-05 10:10:00', 149.00, 'ORD1023'),
('2025-05-05 11:30:00', 259.00, 'ORD1024'),
('2025-05-05 12:40:00', 199.00, 'ORD1025'),
('2025-05-06 07:30:00', 89.99, 'ORD1026'),
('2025-05-06 08:10:00', 120.00, 'ORD1027'),
('2025-04-06 08:45:00', 135.75, 'ORD1028'),
('2025-04-06 09:25:00', 315.99, 'ORD1029'),
('2025-04-06 10:05:00', 450.00, 'ORD1030'),
('2025-04-07 06:30:00', 320.99, 'ORD1031'),
('2025-04-07 07:20:00', 219.49, 'ORD1032'),
('2025-04-07 08:15:00', 110.00, 'ORD1033');


WITH cte AS (
	SELECT 
    TO_CHAR(created_at, 'YYYY-MM') AS month,
    SUM(OrderAmount) AS month_order_amount
  FROM Orders_2
  GROUP BY TO_CHAR(created_at, 'YYYY-MM')
),

new_cte AS (
SELECT
	month,
	month_order_amount,
	LAG(month_order_amount, 1) OVER (ORDER BY month) previous_month_order_amount
FROM cte
)

SELECT month,
	ROUND(((month_order_amount - previous_month_order_amount) / previous_month_order_amount * 100), 3) AS revenue_percentage
FROM new_cte

