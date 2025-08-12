--Create table syntax
CREATE TABLE Flights (cust_id INT, flight_id VARCHAR(10), origin VARCHAR(50), destination VARCHAR(50));
-- Write a query to find out the original station and final_destination station for each user

-- Insert data into the table
INSERT INTO Flights (cust_id, flight_id, origin, destination)
VALUES (1, 'SG1234', 'Delhi', 'Hyderabad'),
(1, 'SG3476', 'Kochi', 'Mangalore'), 
(1, '69876', 'Hyderabad', 'Kochi'), 
(2, '68749', 'Mumbai', 'Varanasi'), 
(2, 'SG5723', 'Varanasi', 'Delhi');


WITH destination AS (
	SELECT fl.cust_id,
		fl.origin,
		fl.destination
	FROM Flights fl
	LEFT JOIN Flights fr
	ON fl.cust_id = fr.cust_id
		AND fl.destination = fr.origin
	WHERE fr.destination IS NULL
)
,origin AS(
	SELECT fl.cust_id,
		fl.origin,
		fl.destination,
		fr.destination
	FROM Flights fl
	LEFT JOIN Flights fr
	ON fl.cust_id = fr.cust_id
		AND fl.origin = fr.destination
	WHERE fr.destination IS NULL
)

SELECT DISTINCT
	o.cust_id,
	o.origin,
	d.destination AS final_destination
FROM origin o
INNER JOIN destination d
ON o.cust_id = d.cust_id

-- METHOD 2
SELECT cust_id,
	MAX(origin) AS origin,
	MAX(final_destination) AS final_destination 
FROM (
	SELECT cust_id, 
	CASE WHEN origin NOT IN (SELECT destination FROM flights WHERE cust_id = fl.cust_id) THEN origin END AS origin,
	CASE WHEN destination NOT IN (SELECT origin FROM flights WHERE cust_id = fl.cust_id) THEN destination END AS final_destination
	FROM flights fl
) t
GROUP BY cust_id
