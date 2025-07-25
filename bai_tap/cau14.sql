select hd.ma_hop_dong, 
	   ldv.ten_loai_dich_vu, 
       dvdk.ten_dich_vu_di_kem,
       count(dvdk.ma_dich_vu_di_kem) as so_lan_su_dung
from hop_dong_chi_tiet hdct
join hop_dong hd on hdct.ma_hop_dong = hd.ma_hop_dong
join dich_vu dv on hd.ma_dich_vu = dv.ma_dich_vu
join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
join dich_vu_di_kem dvdk on hdct.ma_dich_vu_di_kem = dvdk.ma_dich_vu_di_kem
group by hd.ma_hop_dong, 
	   ldv.ten_loai_dich_vu, 
       dvdk.ten_dich_vu_di_kem
HAVING COUNT(dvdk.ma_dich_vu_di_kem) = 1;