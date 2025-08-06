<!-- WebContent/customer-list.jsp -->
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Danh sách khách hàng</title>
  <style>
    table {
      width: 700px;
      margin: auto;
      border-collapse: collapse;
      box-shadow: 0 0 10px #ccc;
    }
    th, td {
      padding: 10px;
      border: 1px solid #aaa;
      text-align: center;
    }
    th {
      background-color: #f2f2f2;
    }
    img {
      width: 80px;
      height: 60px;
      object-fit: cover;
    }
    h2 {
      text-align: center;
    }
  </style>
</head>
<body>
<h2>Danh sách khách hàng</h2>
<table>
  <tr>
    <th>Tên</th>
    <th>Ngày sinh</th>
    <th>Địa chỉ</th>
    <th>Ảnh</th>
  </tr>
  <c:forEach var="customer" items="${customerList}">
    <tr>
      <td>${customer.name}</td>
      <td>${customer.birthday}</td>
      <td>${customer.address}</td>
      <td><img src="${customer.image}" alt="Ảnh"></td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
