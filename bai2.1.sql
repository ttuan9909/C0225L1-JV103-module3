create database quan_li_vat_tu;

use quan_li_vat_tu;

create table phieu_xuat(
soPX int primary key,
ngay_xuat date
);

create table vat_tu(
maVTU int primary key,
TenVTU varchar(50)
);

create table chi_tiet_phieu_xuat(
DGXuat int,
SLXuat int,
soPX int,
maVTU int,
primary key (soPX,maVTU),
foreign key(soPX) references phieu_xuat(soPX),
foreign key(maVTU) references vat_tu(maVTU)
);

create table phieu_nhap(
soPN int primary key,
ngay_nhap date
);

create table chi_tiet_phieu_nhap(
DGNhap int,
SLNhap int,
soPN int,
maVTU int,
primary key (soPN,maVTU),
foreign key(soPN) references phieu_nhap(soPN),
foreign key(maVTU) references vat_tu(maVTU)
);

create table nha_cung_cap (
maNCC int primary key ,
tenNCC varchar(50),
dia_chi varchar(50)
);

create table so_dien_thoai (
id int primary key auto_increment,
so_dien_thoai varchar(50),
maNCC int,
foreign key(maNCC) references nha_cung_cap(maNCC)
);

create table don_dat_hang(
soDH int primary key,
ngayDH date,
maNCC int,
foreign key(maNCC) references nha_cung_cap(maNCC)
);

create table chi_tiet_don_dat_hang(
maVTU int,
soDH int,
primary key (maVTU,soDH),
foreign key(maVTU) references vat_tu(maVTU),
foreign key(soDH) references don_dat_hang(soDH)
);