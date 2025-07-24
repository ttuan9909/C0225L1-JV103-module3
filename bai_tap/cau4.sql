-- Câu 4
select kh.ma_khach_hang, kh.ho_ten, COUNT(hd.ma_hop_dong) AS so_lan_dat 
from hop_dong hd
left join khach_hang kh on kh.ma_khach_hang = hd.ma_khach_hang
join loai_khach lk on kh.ma_loai_khach = lk.ma_loai_khach
where lk.ten_loai_khach like 'Diamond'
group by kh.ma_khach_hang, kh.ho_ten 
order by so_lan_dat;