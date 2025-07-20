--https://datalemur.com/questions/sql-top-three-salaries

WITH employee_with_row_number AS (
  SELECT department_id, name, salary,
    DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS ds_rnk
  FROM employee
)
SELECT dpt.department_name, emp.name, emp.salary
FROM employee_with_row_number emp
LEFT JOIN department dpt
ON emp.department_id = dpt.department_id
WHERE ds_rnk <= 3
ORDER BY department_name, salary DESC, name
