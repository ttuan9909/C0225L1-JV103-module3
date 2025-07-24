-- Câu 9
SELECT 
    MONTH(ngay_lam_hop_dong) AS thang,
    COUNT(DISTINCT ma_khach_hang) AS so_khach_hang
FROM hop_dong
WHERE YEAR(ngay_lam_hop_dong) = 2021
GROUP BY MONTH(ngay_lam_hop_dong)
ORDER BY thang;