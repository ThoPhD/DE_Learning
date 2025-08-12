create table MatchingPair(Id varchar(5), PersonType varchar(5));

insert into MatchingPair values
('A1', 'Adult'),
('C1', 'Child'),
('A2', 'Adult'),
('C2', 'Child'),
('A3', 'Adult'),
('C3', 'Child'),
('A4', 'Adult');

WITH cts AS (
    SELECT
        ROW_NUMBER() OVER() AS rnk,
        id AS Adult
    FROM
        MatchingPair
    WHERE
        persontype = 'Adult'
),
cts1 AS (
    SELECT
        ROW_NUMBER() OVER() AS rnk,
        id AS Child
    FROM
        MatchingPair
    WHERE
        persontype = 'Child'
)
SELECT
    c.Adult,
    c1.Child
FROM
    cts AS c
    FULL OUTER JOIN cts1 AS c1 ON c.rnk = c1.rnk;
