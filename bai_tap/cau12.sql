select hd.ma_hop_dong, 
	   nv.ho_ten, 
       kh.ho_ten, 
       kh.so_dien_thoai, 
       dv.ten_dich_vu, 
       sum(hdct.so_luong) as so_luong_dich_vu_di_kem, 
       hd.tien_dat_coc
from hop_dong hd
join khach_hang kh on hd.ma_khach_hang = kh.ma_khach_hang
join nhan_vien nv on hd.ma_nhan_vien = nv.ma_nhan_vien
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
join hop_dong_chi_tiet hdct on hd.ma_hop_dong = hdct.ma_hop_dong
WHERE dv.ma_dich_vu not in (
select hd.ma_dich_vu
from hop_dong hd
where YEAR(hd.ngay_lam_hop_dong) = 2021
AND MONTH(hd.ngay_lam_hop_dong) BETWEEN 1 AND 6)
AND ( YEAR(hd.ngay_lam_hop_dong) = 2020
AND MONTH(hd.ngay_lam_hop_dong) BETWEEN 10 AND 12)
GROUP BY hd.ma_hop_dong, nv.ho_ten, kh.ho_ten, kh.so_dien_thoai, dv.ten_dich_vu, hd.tien_dat_coc;
