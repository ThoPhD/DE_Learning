-- Write a query to find out the company who have at least 2 users speaks both EL and German

CREATE TABLE Company_user (
 Company_Id VARCHAR(512),
 User_Id INT,
 Language VARCHAR(512)
);
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '1', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '1', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '2', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '3', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '3', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('1', '4', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '5', 'German');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '5', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '6', 'Spanish');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '6', 'English');
INSERT INTO Company_user (Company_Id, User_Id, Language) VALUES ('2', '7', 'English');

WITH cte AS(
	SELECT company_id, user_id
	FROM Company_user
	WHERE language IN ('English', 'German')
	GROUP BY company_id, User_Id
	HAVING COUNT(DISTINCT language) >= 2
)
SELECT  company_id
FROM cte
GROUP BY company_id
HAVING COUNT(DISTINCT user_id) >= 2
