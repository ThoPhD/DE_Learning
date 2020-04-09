-- https://www.hackerrank.com/challenges/more-than-75-marks/problem
SELECT
  NAME
FROM (
  SELECT
    NAME,
    RIGHT(NAME, 3) AS LAST_NAME
  FROM STUDENTS
  WHERE
    Marks > 75
  ORDER BY
    LAST_NAME,
    ID
) t
