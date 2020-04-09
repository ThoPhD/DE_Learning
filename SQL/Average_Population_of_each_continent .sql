-- https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

SELECT
  COUNTRY.Continent,
  FLOOR(AVG(CITY.Population)) AS AVE_POPULATION
FROM
  CITY

INNER JOIN

COUNTRY
ON
  CITY.CountryCode = COUNTRY.Code
GROUP BY
  COUNTRY.Continent
;
