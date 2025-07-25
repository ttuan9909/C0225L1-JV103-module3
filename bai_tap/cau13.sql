SELECT 
  dvdk.ma_dich_vu_di_kem,
  dvdk.ten_dich_vu_di_kem,
  SUM(hdct.so_luong) AS tong_so_luong_dich_vu_di_kem
FROM dich_vu_di_kem dvdk
JOIN hop_dong_chi_tiet hdct ON dvdk.ma_dich_vu_di_kem = hdct.ma_dich_vu_di_kem
GROUP BY dvdk.ma_dich_vu_di_kem, dvdk.ten_dich_vu_di_kem
HAVING SUM(hdct.so_luong) = (
  SELECT MAX(tong)
  FROM (
    SELECT SUM(hdct2.so_luong) AS tong
    FROM dich_vu_di_kem dvdk2
    JOIN hop_dong_chi_tiet hdct2 
      ON dvdk2.ma_dich_vu_di_kem = hdct2.ma_dich_vu_di_kem
    GROUP BY dvdk2.ma_dich_vu_di_kem
  ) AS sub
);

