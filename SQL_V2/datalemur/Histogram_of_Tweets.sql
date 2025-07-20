--https://datalemur.com/questions/sql-histogram-tweets

WITH cte AS(
  SELECT user_id,
    COUNT(tweet_id) AS total_tweet
  FROM tweets
  WHERE EXTRACT(YEAR FROM tweet_date) = 2022
  GROUP BY user_id
)
SELECT
  total_tweet AS tweet_bucket,
  COUNT(user_id) AS users_num
FROM cte 
GROUP BY total_tweet
