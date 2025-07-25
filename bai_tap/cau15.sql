select nv.ma_nhan_vien,
	   nv.ho_ten,
       td.ten_trinh_do,
       bp.ten_bo_phan,
       nv.so_dien_thoai,
       nv.dia_chi
from nhan_vien nv
join trinh_do td on nv.ma_trinh_do = td.ma_trinh_do
join bo_phan bp on nv.ma_bo_phan = bp.ma_bo_phan
left join hop_dong hd on nv.ma_nhan_vien = hd.ma_nhan_vien
where year(hd.ngay_lam_hop_dong) between 2020 and 2021
group by  nv.ma_nhan_vien,
  nv.ho_ten,
  td.ten_trinh_do,
  bp.ten_bo_phan,
  nv.so_dien_thoai,
  nv.dia_chi
having  count(hd.ma_hop_dong) <= 3;