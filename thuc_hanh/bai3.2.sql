Use quan_ly_ban_hang;

insert into Customer(cID, cName, cAge)
values(1, 'Minh Quan', 10);
insert into Customer(cID, cName, cAge)
values(2, 'Ngoc Oanh', 20);
insert into Customer(cID, cName, cAge)
values(3, 'Hong Ha', 50);

insert into Orderproduct(oID, cID, oDate, pTotalPrice)
values(1, 1, '2006-03-21', null);
insert into Orderproduct(oID, cID, oDate, pTotalPrice)
values(2, 2, '2006-03-23', null);
insert into Orderproduct(oID, cID, oDate, pTotalPrice)
values(3, 1, '2006-03-16', null);

insert into product(pID, pName, pPrice)
values(1, 'May giat', 3);
insert into product(pID, pName, pPrice)
values(2, 'Tu Lanh', 5);
insert into product(pID, pName, pPrice)
values(3, 'Dieu Hoa', 7);
insert into product(pID, pName, pPrice)
values(4, 'Quat', 1);
insert into product(pID, pName, pPrice)
values(5, 'Bep Dien', 2);

insert into orderdetail(oID, pid, odqty)
values(1, 1, 3);
insert into orderdetail(oID, pid, odqty)
values(1, 3, 7);
insert into orderdetail(oID, pid, odqty)
values(1, 4, 2);
insert into orderdetail(oID, pid, odqty)
values(2, 1, 1);
insert into orderdetail(oID, pid, odqty)
values(3, 1, 8);
insert into orderdetail(oID, pid, odqty)
values(2, 5, 4);
insert into orderdetail(oID, pid, odqty)
values(2, 3, 3);

select * from customer;
select * from orderdetail;
select * from orderproduct;
select * from product;

select oid, odate, ptotalprice from Orderproduct;