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
        <input name="name" id="name" onblur="checkValidate()" required value="${product ne null ? product.name : param.name}"/>
        <span class="error" id="nameError" style="color:red"></span>
    </p>
    <p>
        <label>Giá (VND):</label><br/>
        <input name="price"  id="price" onblur="checkValidate()" type="number" min="0" step="1" required value="${product ne null ? product.price : param.price}"/>
        <span class="error" id="priceError" style="color:red"></span>
    </p>
    <p>
        <label>Số lượng:</label><br/>
        <input name="quantity"  id="quantity" onblur="checkValidate()" type="number" min="0" step="1" required value="${product ne null ? product.quantity : param.quantity}"/>
        <span class="error" id="quantityError" style="color:red"></span>
    </p>

    <!-- Dropdown chọn Category -->
    <p>
        <label>Danh mục:</label><br/>
        <select id="categoryId" name="categoryId" onblur="checkValidate()" required>
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
        <span class="error" id="categoryError" style="color:red"></span>
    </p>

    <p>
        <button id="submitBtn" type="submit" disabled>${mode eq 'edit' ? 'Cập nhật' : 'Tạo mới'}</button>
        <a href="${pageContext.request.contextPath}/products?action=list">Huỷ</a>
    </p>
</form>
<script>
    function checkValidate() {
        let isCheck = true;

        // clear lỗi trước
        document.querySelectorAll(".error").forEach(e => e.textContent = "");

        const name = document.getElementById("name");
        const price = document.getElementById("price");
        const quantity = document.getElementById("quantity");
        const category = document.getElementById("categoryId");

        if (!name.value.trim()) {
            document.getElementById("nameError").textContent = "Vui lòng nhập tên sản phẩm";
            isCheck = false;
        }

        if (!price.value.trim()) {
            document.getElementById("priceError").textContent = "Vui lòng nhập giá sản phẩm";
            isCheck = false;
        }

        if (!quantity.value.trim()) {
            document.getElementById("quantityError").textContent = "Vui lòng nhập số lượng";
            isCheck = false;
        }

        if (!category.value.trim()) {
            document.getElementById("categoryError").textContent = "Vui lòng chọn danh mục";
            isCheck = false;
        }

        // bật / tắt nút submit
        document.getElementById("submitBtn").disabled = !isCheck;
        return isCheck;
    }
</script>
</body>
</html>
