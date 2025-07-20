-- Create Employees Stag and Dimention tables
DROP table employees_stag;
DROP table employees_dim;

CREATE TABLE employees_stag (
    id INT,
    employee_name VARCHAR(50),
	employee_dept VARCHAR(50),
	salary DECIMAL(10,3)
);

CREATE TABLE employees_dim (
	id INT,
    employee_name VARCHAR(50),
	employee_dept VARCHAR(50),
	salary DECIMAL(10,3),
	is_current BOOLEAN DEFAULT True
);

-- Insert data into Employees Stag
INSERT INTO employees_stag (id, employee_name, employee_dept, salary) VALUES (1, 'Alice', 'IT', 1000),
(2, 'Bob', 'HR', 810),
(3, 'John', 'DE', 1500),
(4, 'Alex', 'FS', 1111);

-- Insert and Update dimention tables
INSERT INTO employees_stag (id, employee_name, employee_dept, salary) VALUES (5, 'Keith', 'Sales', 950);
UPDATE employees_stag SET employee_dept='BA' WHERE id=2;
UPDATE employees_stag SET employee_dept='DS' WHERE id=1;


SELECT * FROM employees_stag;
SELECT * FROM employees_dim;

-- STEP 1
INSERT INTO employees_dim
SELECT es.* FROM employees_stag es
LEFT JOIN employees_dim ed
ON es.id = ed.id
WHERE ed.id IS NULL;

-- STEP 2
UPDATE employees_dim
SET is_current = False
WHERE id IN(
SELECT es.id FROM employees_stag es
LEFT JOIN employees_dim ed
ON es.id = ed.id AND ed.employee_dept = es.employee_dept
WHERE ed.id IS NULL);

-- STEP 3
INSERT INTO employees_dim (id, employee_name, employee_dept, salary, is_current)
SELECT es.id, es.employee_name, es.employee_dept, es.salary, True
FROM employees_stag es
LEFT JOIN employees_dim ed
ON es.id = ed.id
AND ed.employee_dept = es.employee_dept
WHERE ed.id IS NULL
