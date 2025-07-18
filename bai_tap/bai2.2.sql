create database quan_ly_ban_hang;

use quan_ly_ban_hang;

create table customer(
cID int primary key auto_increment,
cName varchar(50),
cAge int
);

create table orderProduct(
oID int primary key auto_increment,
oDate date,
pTotalPrice int,
cID int,
foreign key(cID) references customer(cID)
);

create table product(
pID int primary key auto_increment,
pName varchar(50),
pPrice int
);

create table orderDetail(
oID int,
pID int,
odQTY int,
primary key (oID,pID),
foreign key(oID) references orderProduct(oID),
foreign key(pID) references product(pID)
);