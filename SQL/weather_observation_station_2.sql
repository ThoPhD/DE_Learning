--https://www.hackerrank.com/challenges/weather-observation-station-2/problem?h_r=next-challenge&h_v=zen

SELECT
  ROUND(SUM(LAT_N), 2),
  ROUND(SUM(LONG_W), 2)
FROM
  STATION
;