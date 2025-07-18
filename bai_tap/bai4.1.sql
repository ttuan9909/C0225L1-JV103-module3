SELECT * 
FROM subject
WHERE credit = (SELECT MAX(credit) FROM subject);

SELECT * 
FROM subject s
JOIN mark m on s.SubID = m.SubID
WHERE m.mark = (SELECT MAX(m.mark) FROM mark);

SELECT 
    s.StudentId, 
    s.StudentName,
    s.Address,
    s.Phone,
    s.Status,
    s.ClassId,
    AVG(m.Mark) AS avgMark
FROM student s 
JOIN mark m ON s.StudentId = m.StudentId
GROUP BY 
    s.StudentId, s.StudentName
ORDER BY 
    avgMark DESC;

select * from mark;




