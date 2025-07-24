-- Câu 11
select dvdk.ma_dich_vu_di_kem,
	   dvdk.ten_dich_vu_di_kem
from hop_dong_chi_tiet hdct
join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
join hop_dong hd on hdct.ma_hop_dong = hd.ma_hop_dong
join khach_hang kh on hd.ma_khach_hang = kh.ma_khach_hang
join loai_khach lk on kh.ma_loai_khach = lk.ma_loai_khach
WHERE lk.ten_loai_khach LIKE 'diamond'
  AND (kh.dia_chi LIKE '%Vinh' OR kh.dia_chi LIKE '%Quảng Ngãi');