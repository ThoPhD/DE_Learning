-- Create Students sources and Destination table
CREATE TABLE Students_Src (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
	student_dept VARCHAR(50)
);

CREATE TABLE Students_Dest (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
	student_dept VARCHAR(50)
);

-- Insert data into Students
INSERT INTO Students_Src (student_id, student_name, student_dept) VALUES (1, 'Alice', 'BBA'),
(2, 'Bob', 'BCA'),
(3, 'John', 'Btech'),
(4, 'Alex', 'IT');

UPDATE Students_Src SET student_dept='MBA' WHERE student_id=1;
INSERT INTO Students_Src (student_id, student_name, student_dept) VALUES (5, 'Keith', 'Sales');


SELECT * FROM Students_Src;
SELECT * FROM Students_Dest;

-- SCD: Type 1
-- Step 1

INSERT INTO Students_Dest
SELECT ss.* FROM Students_Src ss 
LEFT JOIN Students_Dest sd
ON ss.student_id = sd.student_id
WHERE sd.student_id IS NULL;

-- STEP 2
UPDATE Students_Dest sd
SET student_dept = ss.student_dept
FROM Students_Src ss
WHERE ss.student_id = sd.student_id
  AND sd.student_dept != ss.student_dept;

