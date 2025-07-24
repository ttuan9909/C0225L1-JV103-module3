-- Câu 8
SELECT *
FROM khach_hang
WHERE ho_ten IN (
    SELECT ho_ten
    FROM khach_hang
    GROUP BY ho_ten
    HAVING COUNT(*) = 1
);