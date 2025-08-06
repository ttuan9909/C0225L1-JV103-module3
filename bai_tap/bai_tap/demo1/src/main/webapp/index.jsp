<!-- WebContent/index.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>Product Discount Calculator</title>
</head>
<body>
<h2>Product Discount Calculator</h2>
<form action="display" method="post">
    <label>Product Description:</label><br>
    <input type="text" name="description" required><br><br>

    <label>List Price ($):</label><br>
    <input type="number" step="0.01" name="price" required><br><br>

    <label>Discount Percent (%):</label><br>
    <input type="number" step="0.01" name="percent" required><br><br>

    <input type="submit" value="Calculate Discount">
</form>
</body>
</html>
