-- Write a query to find movie_titles where the highest rating was given by more than one user.

CREATE TABLE MovieRatings (
    rating_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    movie_title VARCHAR(100),
    rating INT
);

INSERT INTO MovieRatings (rating_id, user_name, movie_title, rating) VALUES
(1, 'Alice',   'Inception',     5),
(2, 'Bob',     'Inception',     4),
(3, 'Charlie', 'Inception',     5),
(4, 'Alice',   'Titanic',       3),
(5, 'Bob',     'Titanic',       3),
(6, 'Charlie', 'Titanic',       3),
(7, 'Alice',   'Interstellar',  4),
(8, 'Bob',     'Interstellar',  5),
(9, 'Charlie', 'Interstellar',  5);

-- Expected Output:

-- movie_title
-- -------------
-- Inception
-- Interstellar

WITH cte AS(
SELECT *
FROM MovieRatings
WHERE rating = (SELECT MAX(rating) FROM MovieRatings)
)
SELECT movie_title FROM cte
GROUP BY movie_title
HAVING COUNT(rating_id) > 1;