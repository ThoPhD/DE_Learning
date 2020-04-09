-- https://www.hackerrank.com/challenges/african-cities/problem?h_r=next-challenge&h_v=zen

SELECT
  DISTINCT CITY.NAME
FROM
  CITY

INNER JOIN

COUNTRY
ON
  CITY.CountryCode = COUNTRY.Code
  AND COUNTRY.CONTINENT = 'Africa'
;