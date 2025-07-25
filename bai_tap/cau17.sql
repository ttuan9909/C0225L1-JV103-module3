UPDATE khach_hang kh
JOIN (
  SELECT kh.ma_khach_hang
  FROM khach_hang kh
  JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
  JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
  JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
  JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
  JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
  WHERE 
    YEAR(hd.ngay_lam_hop_dong) = 2021
    AND lk.ten_loai_khach = 'Platinium'
  GROUP BY kh.ma_khach_hang
  HAVING SUM(
    dv.chi_phi_thue * DATEDIFF(hd.ngay_ket_thuc, hd.ngay_lam_hop_dong)
    + dvdk.gia * hdct.so_luong
  ) > 10000000
) AS ds_khach_hang ON kh.ma_khach_hang = ds_khach_hang.ma_khach_hang
SET kh.ma_loai_khach = (
  SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Diamond' LIMIT 1
);

select ma_khach_hang, ho_ten 
from khach_hang
where ma_loai_khach = 1;

-- UPDATE khach_hang
-- SET ma_loai_khach = (
--     SELECT ma_loai_khach FROM loai_khach WHERE ten_loai_khach = 'Diamond'
-- )
-- WHERE ma_khach_hang IN (
--   SELECT kh.ma_khach_hang
--   FROM khach_hang kh
--   JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
--   JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
--   JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
--   JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
--   JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
--   WHERE 
--     YEAR(hd.ngay_lam_hop_dong) = 2021
--     AND lk.ten_loai_khach = 'Platinium'
--   GROUP BY 
--     kh.ma_khach_hang
--   HAVING 
--     SUM(
--       dv.chi_phi_thue * DATEDIFF(hd.ngay_ket_thuc, hd.ngay_lam_hop_dong) 
--       + dvdk.gia * hdct.so_luong
--     ) > 10000000
-- );
