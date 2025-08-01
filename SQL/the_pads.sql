--https://www.hackerrank.com/challenges/the-pads/problem?h_r=next-challenge&h_v=zen
SELECT
  CONCAT(NAME,'(',SUBSTR(OCCUPATION,1,1),')') AS N
FROM
  OCCUPATIONS
ORDER BY
  N
;

SELECT
  CONCAT('There are a total of ',COUNT(OCCUPATION),' ',LOWER(OCCUPATION),'s.')
FROM
  OCCUPATIONS
GROUP BY
  OCCUPATION
ORDER BY
  COUNT(OCCUPATION),
  OCCUPATION
;
