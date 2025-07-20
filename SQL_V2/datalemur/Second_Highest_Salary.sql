--https://datalemur.com/questions/sql-second-highest-salary

SELECT MAX(salary) AS second_highest_salary
FROM employee
WHERE salary NOT IN(SELECT MAX(salary) AS second_highest_salary
FROM employee);
