-- Write a SQL query to split a full name column into first name and last name. Assume the names are separated by a single space.

-- Query to create Table Persons
CREATE TABLE persons (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100)
);

-- Insert data
INSERT INTO persons (full_name) VALUES
('John Doe'),
('Emma Watson'),
('Emily Rose Pattrick'),
('Robert Downey'),
('Chris Evans'),
('Scarlett Johansson');

SELECT full_name,
	split_part(full_name,' ', 1) AS first_name,
	split_part(full_name,' ', -1) AS last_name
FROM persons;
