--https://www.hackerrank.com/challenges/what-type-of-triangle/problem
SELECT
  CASE
    WHEN (A + B <= C) OR (A + C <= B) OR (B + C <= A) THEN 'Not A Triangle'
    WHEN A = B AND A = C THEN 'Equilateral'
    WHEN (A = B AND A != C) OR (A = C AND A != B) OR (A != B AND B = C) THEN 'Isosceles'
    ELSE 'Scalene'
  END AS R
FROM
  TRIANGLES
