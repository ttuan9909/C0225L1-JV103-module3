-- Câu 7
select DISTINCT  dv.ma_dich_vu, dv.ten_dich_vu, dv.dien_tich, dv.chi_phi_thue, ldv.ten_loai_dich_vu 
from dich_vu dv
left join loai_dich_vu ldv on dv.ma_loai_dich_vu = ldv.ma_loai_dich_vu
left join hop_dong hd on dv.ma_dich_vu = hd.ma_dich_vu
WHERE YEAR(hd.ngay_lam_hop_dong) = 2020 
AND dv.ma_dich_vu not in (
select hd.ma_dich_vu
from hop_dong hd
where YEAR(hd.ngay_lam_hop_dong) = 2021 
);