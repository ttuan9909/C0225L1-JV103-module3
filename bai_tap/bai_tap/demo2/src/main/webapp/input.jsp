<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simple Calculator</title>
</head>
<body>
<h2>Simple Calculator</h2>
<form action="calculate" method="post">
    First operand: <input type="text" name="first" required><br><br>
    Operator:
    <select name="operator">
        <option value="add">+</option>
        <option value="sub">-</option>
        <option value="mul">*</option>
        <option value="div">/</option>
    </select><br><br>
    Second operand: <input type="text" name="second" required><br><br>
    <input type="submit" value="Calculate">
</form>
</body>
</html>
