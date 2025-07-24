-- Câu 5
SELECT 
    kh.ma_khach_hang, 
    kh.ho_ten, 
    lk.ten_loai_khach, 
    hd.ma_hop_dong, 
    dv.ten_dich_vu, 
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc, 
    dv.chi_phi_thue + IFNULL(SUM(hdct.so_luong * dvdk.gia), 0) AS tong_tien
FROM khach_hang kh
JOIN loai_khach lk ON kh.ma_loai_khach = lk.ma_loai_khach
LEFT JOIN hop_dong hd ON kh.ma_khach_hang = hd.ma_khach_hang
LEFT JOIN dich_vu dv ON hd.ma_dich_vu = dv.ma_dich_vu
LEFT JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
LEFT JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY 
    kh.ma_khach_hang, 
    kh.ho_ten, 
    lk.ten_loai_khach, 
    hd.ma_hop_dong, 
    dv.ten_dich_vu, 
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc, 
    dv.chi_phi_thue
ORDER BY ma_khach_hang;
