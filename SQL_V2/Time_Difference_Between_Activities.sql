-- Based on the user_activity table, write a query to retrieve the time difference between each user's most recent event 
-- and their second-to-last event, sorted in ascending order by user_identifier.

-- Creare Table user_activity
CREATE TABLE user_activity (
    user_identifier INT,
    event_type VARCHAR(20),
    event_date DATE
);

-- Insert values
INSERT INTO user_activity (user_identifier, event_type, event_date) 
VALUES
(1, 'Login', '2023-05-10'),
(1, 'Logout', '2023-05-12'),
(2, 'Login', '2023-06-01'),
(2, 'Purchase', '2023-06-04'),
(2, 'Logout', '2023-06-10'),
(3, 'Login', '2023-07-15'),
(3, 'Logout', '2023-07-16'),
(4, 'Login', '2023-08-20'),
(4, 'Purchase', '2023-08-25');

WITH cte AS (
	SELECT user_identifier,
		event_date,
		LAG(event_date) OVER(PARTITION BY  user_identifier) AS prev_event_date,
		event_date - LAG(event_date) OVER(PARTITION BY  user_identifier) AS days_elapsed
	FROM user_activity
)
SELECT * 
FROM cte
WHERE prev_event_date IS NOT NULL