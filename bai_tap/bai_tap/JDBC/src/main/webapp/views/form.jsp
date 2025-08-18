<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${mode eq 'edit' ? 'Sửa' : 'Thêm'} sản phẩm</title>
</head>
<body>
<h2>${mode eq 'edit' ? 'Sửa' : 'Thêm'} sản phẩm</h2>

<c:if test="${not empty error}">
    <div style="color:red">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/products" method="post">
    <input type="hidden" name="action" value="${mode eq 'edit' ? 'edit' : 'create'}"/>
    <c:if test="${mode eq 'edit'}">
        <input type="hidden" name="id" value="${product.id}"/>
    </c:if>

    <p>
        <label>Tên sản phẩm:</label><br/>
        <input name="name" required value="${product ne null ? product.name : param.name}"/>
    </p>
    <p>
        <label>Giá (VND):</label><br/>
        <input name="price" type="number" min="0" step="1" required value="${product ne null ? product.price : param.price}"/>
    </p>
    <p>
        <label>Số lượng:</label><br/>
        <input name="quantity" type="number" min="0" step="1" required value="${product ne null ? product.quantity : param.quantity}"/>
    </p>

    <!-- Dropdown chọn Category -->
    <p>
        <label>Danh mục:</label><br/>
        <select name="categoryId" required>
            <option value="">-- Chọn danh mục --</option>
            <c:forEach var="c" items="${categories}">
                <c:set var="isSelected"
                       value="${
                         (not empty selectedCategoryId and selectedCategoryId == c.id)
                         or (empty selectedCategoryId and param.categoryId == c.id)
                       }"/>
                <option value="${c.id}" ${isSelected ? 'selected' : ''}>${c.name}</option>
            </c:forEach>
        </select>
    </p>

    <p>
        <button type="submit">${mode eq 'edit' ? 'Cập nhật' : 'Tạo mới'}</button>
        <a href="${pageContext.request.contextPath}/products?action=list">Huỷ</a>
    </p>
</form>
</body>
</html>
