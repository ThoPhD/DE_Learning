
-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

-- Insert data into Students
INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'John'),
(4, 'Alex');


-- Create Examinations table
CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50)
);

-- Insert data into Examinations
INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(3, 'Math'),
(3, 'Programming'),
(3, 'Physics'),
(2, 'Math'),
(1, 'Math'),
(4, 'Math');

-- Q: Write a Query to find the number of times each studen each example.
-- Ruturn the result table ordered by student_id and subject_name
SELECT s.student_id, s.student_name, e.subject_name, COUNT(1) AS number_of_exam
FROM Students s
INNER JOIN Examinations e
ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name, e.subject_name
ORDER BY s.student_name, e.subject_name


-- Drop tables
DROP table Students;
DROP table Examinations;
