--https://www.hackerrank.com/challenges/earnings-of-employees/problem

SELECT
  MONTHS * SALARY AS EARNINGS,
  COUNT(1) AS CNT
FROM
  Employee
GROUP BY
  EARNINGS
ORDER BY
  EARNINGS DESC
LIMIT 1

--Working Platform:- DB2, MySQL, Oracle, MS SQL Server
--
--SELECT MAX(SALARY*MONTHS), COUNT(*)
--FROM EMPLOYEE
--WHERE (SALARY*MONTHS) = (SELECT MAX(SALARY*MONTHS)
--                         FROM EMPLOYEE);