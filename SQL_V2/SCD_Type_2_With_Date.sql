-- Create Employees Stag and Dimention tables
DROP table employees_stag;
DROP table employees_dim;

CREATE TABLE employees_stag (
    id INT,
    employee_name VARCHAR(50),
	employee_dept VARCHAR(50),
	salary DECIMAL(10,3),
	Change_Date date NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employees_dim (
	id INT,
    employee_name VARCHAR(50),
	employee_dept VARCHAR(50),
	salary DECIMAL(10,3),
	is_current BOOLEAN DEFAULT True,
	Start_Date date NOT NULL DEFAULT CURRENT_TIMESTAMP,
    End_Date date NOT NULL DEFAULT '12/31/9999'
);

-- Insert data into Employees Stag
INSERT INTO employees_stag (id, employee_name, employee_dept, salary, Change_Date) 
VALUES (1, 'Alice', 'IT', 1000, CURRENT_TIMESTAMP - INTERVAL '99 days'),
(2, 'Bob', 'HR', 810, CURRENT_TIMESTAMP - INTERVAL '99 days'),
(3, 'John', 'DE', 1500, CURRENT_TIMESTAMP - INTERVAL '99 days'),
(4, 'Alex', 'FS', 1111, CURRENT_TIMESTAMP - INTERVAL '99 days');

-- Insert and Update dimention tables
INSERT INTO employees_stag (id, employee_name, employee_dept, salary, Change_Date) VALUES (5, 'Keith', 'Sales', 950, CURRENT_TIMESTAMP - INTERVAL '60 days');
UPDATE employees_stag SET employee_dept='BA' WHERE id=2;
UPDATE employees_stag SET employee_dept='DS' WHERE id=1;


SELECT * FROM employees_stag;
SELECT * FROM employees_dim;

-- Method 2
WITH sc AS (
	SELECT *
    FROM employees_stag es
    WHERE NOT EXISTS (SELECT 1
	FROM employees_dim ed
	WHERE ed.id = es.id AND
        ed.employee_name = es.employee_name AND
        ed.employee_dept = es.employee_dept AND
		ed.salary = es.salary
    )),
	 
    u AS (
		UPDATE employees_dim c
		SET is_current = False,
			end_date = CURRENT_TIMESTAMP
     	FROM sc
      	WHERE sc.id = c.id AND
            c.is_current = True
     )
	 
INSERT INTO employees_dim (id, employee_name, employee_dept, salary, is_current, Start_Date, End_Date) 
SELECT id, employee_name, employee_dept, salary, True, Change_Date, '9999-12-31'::date
FROM sc;
