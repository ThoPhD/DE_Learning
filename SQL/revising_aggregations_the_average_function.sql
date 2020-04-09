--https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem?h_r=next-challenge&h_v=zen
SELECT
  AVG(population)
FROM
  CITY
WHERE
  District = "California"
;