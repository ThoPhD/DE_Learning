-- https://www.hackerrank.com/challenges/asian-population/problem

SELECT
  SUM(CITY.population)
FROM
  CITY

INNER JOIN

COUNTRY
ON
  CITY.CountryCode = COUNTRY.Code
  AND COUNTRY.CONTINENT = 'Asia'
;