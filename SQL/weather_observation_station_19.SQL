--https://www.hackerrank.com/challenges/weather-observation-station-19/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

SELECT
  ROUND (
    SQRT (
      POWER(MAX(LAT_N)  - MIN(LAT_N), 2) + POWER(MAX(LONG_W) - MIN(LONG_W), 2)
    ), 4
  )
FROM
  STATION
;
