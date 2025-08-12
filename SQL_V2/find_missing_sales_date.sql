-- Write a query to find the missing sls_dt in sls_tbl table.
-- Each sales date is 1 week apart with the others.

CREATE TABLE sls_tbl (pid INT, sls_dt DATE, sls_amt INT );

-- Insert data into the table
INSERT INTO sls_tbl (pid, sls_dt, sls_amt)
VALUES (201, '2024-07-11', 140),
(201, '2024-07-18', 160), 
(201, '2024-07-25', 150), 
(201, '2024-08-01', 180), 
(201, '2024-08-15', 170), 
(201, '2024-08-29', 130);

WITH full_sls_dt AS (
	SELECT generate_series((SELECT MIN(sls_dt) FROM sls_tbl), (SELECT MAX(sls_dt) FROM sls_tbl), '1 week'::interval)::date AS sls_dt
)

SELECT f.sls_dt
FROM full_sls_dt f
LEFT JOIN sls_tbl s
ON f.sls_dt = s.sls_dt
WHERE s.sls_dt IS NULL
