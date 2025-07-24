-- Câu 10
SELECT 
    hd.ma_hop_dong, 
    hd.ngay_lam_hop_dong, 
    hd.ngay_ket_thuc, 
    hd.tien_dat_coc,
    SUM(hdct.so_luong) AS so_luong_dich_vu_di_kem
FROM hop_dong hd
left JOIN hop_dong_chi_tiet hdct ON hd.ma_hop_dong = hdct.ma_hop_dong
left JOIN dich_vu_di_kem dvdk ON hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
GROUP BY hd.ma_hop_dong, hd.ngay_lam_hop_dong, hd.ngay_ket_thuc;