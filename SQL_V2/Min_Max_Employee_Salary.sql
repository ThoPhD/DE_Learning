CREATE TABLE emps_tbl (emp_name VARCHAR(50), dept_id INT, salary INT);

INSERT INTO emps_tbl VALUES ('Siva', 1, 30000), ('Ravi', 2, 40000), ('Prasad', 1, 50000), ('Sai', 2, 20000), ('Anna', 2, 10000);


WITH employee_with_min_salary AS(
	SELECT
	    emp_name,
	    dept_id,
	    salary,
	    FIRST_VALUE(emp_name) OVER (PARTITION BY dept_id ORDER BY salary) AS min_empname,
		LAST_VALUE(emp_name) OVER (PARTITION BY dept_id ORDER BY salary) AS max_empname
	FROM emps_tbl
), 
cte AS (
	SELECT dept_id, 
		emp_name,
		CASE WHEN emp_name = min_empname AND emp_name = max_empname THEN min_empname ELSE NULL END AS min_sal_empname,
		CASE WHEN emp_name = max_empname AND emp_name != min_empname THEN max_empname ELSE NULL END AS max_sal_empname
	FROM employee_with_min_salary
)

SELECT dept_id,
	MAX(min_sal_empname) AS min_sal_empname,
	MAX(max_sal_empname) AS max_sal_empname
FROM cte
GROUP BY dept_id


