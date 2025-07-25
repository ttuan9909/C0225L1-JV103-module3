DELETE FROM nhan_vien
WHERE ma_nhan_vien NOT IN (
    SELECT DISTINCT ma_nhan_vien
    FROM hop_dong
    WHERE YEAR(ngay_lam_hop_dong) BETWEEN 2019 AND 2021
);