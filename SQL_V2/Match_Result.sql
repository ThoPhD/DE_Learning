Create Table Match_Result (
Team_1 Varchar(20),
Team_2 Varchar(20),
Result Varchar(20)
);

Insert into Match_Result (Team_1, Team_2, Result) Values('India', 'Australia','India'),
	('India', 'England','England'),
	('SouthAfrica', 'India','India'),
	('Australia', 'England',NULL),
	('England', 'SouthAfrica','SouthAfrica'),
	('Australia', 'India','Australia');

-- Write a Query to calculate the number of matches played, matches won, matches tied and matches lost for each team.

WITH cte AS (
SELECT 
	team_1 AS team, 
	CASE WHEN result = team_1 THEN 1 ELSE 0 END AS Matches_Won,
	CASE WHEN result IS NULL THEN 1 ELSE 0 END AS Matches_Tied,
	CASE WHEN result = team_2 THEN 1 ELSE 0 END AS Matches_Lost
FROM Match_Result
UNION ALL
SELECT 
	team_2 AS team, 
	CASE WHEN result = team_2 THEN 1 ELSE 0 END AS Matches_Won,
	CASE WHEN result IS NULL THEN 1 ELSE 0 END AS Matches_Tied,
	CASE WHEN result = team_1 THEN 1 ELSE 0 END AS Matches_Lost
FROM Match_Result
)

SELECT team, 
	COUNT(1) AS Matched_Played,
	SUM(Matches_Won) AS Matches_Won,
	SUM(Matches_Tied) AS Matches_Tied,
	SUM(Matches_Lost) AS Matches_Lost
FROM cte
GROUP BY team;
