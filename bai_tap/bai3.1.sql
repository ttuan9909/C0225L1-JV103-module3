SELECT * FROM student WHERE StudentName LIKE 'h%';
SELECT * FROM class WHERE MONTH(StartDate) = 12;
SELECT * FROM Subject WHERE credit between 3 AND 5;

SET SQL_SAFE_UPDATES = 0;
UPDATE student SET ClassID = 2 WHERE studentName = 'hung';
SET SQL_SAFE_UPDATES = 1;

SELECT s.StudentName, sub.SubName, m.Mark
FROM Mark m 
JOIN Student s ON m.StudentId = s.studentId
JOIN Subject sub ON m.SubId = sub.SubId
ORDER BY m.Mark DESC, s.StudentName ASC; 