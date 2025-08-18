<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2><c:choose><c:when test="${mode=='edit'}">Edit</c:when><c:otherwise>Create</c:otherwise></c:choose> Category</h2>

<c:if test="${not empty error}">
    <div style="color:red">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/categories" method="post">
    <c:choose>
        <c:when test="${mode=='edit'}">
            <input type="hidden" name="action" value="edit"/>
            <input type="hidden" name="id" value="${category.id}"/>
        </c:when>
        <c:otherwise>
            <input type="hidden" name="action" value="create"/>
        </c:otherwise>
    </c:choose>

    <label>Name:</label>
    <input type="text" name="name" value="${mode=='edit' ? category.name : param.name}" required/>

    <button type="submit">Save</button>
    <a href="${pageContext.request.contextPath}/categories?action=list">Cancel</a>
</form>
