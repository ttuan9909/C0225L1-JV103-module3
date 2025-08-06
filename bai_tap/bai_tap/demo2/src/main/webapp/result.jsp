<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Double first = (Double) request.getAttribute("first");
  Double second = (Double) request.getAttribute("second");
  String operator = (String) request.getAttribute("operator");
  Double result = (Double) request.getAttribute("result");
  String error = (String) request.getAttribute("error");

  String operatorSymbol = "";
  if ("add".equals(operator)) operatorSymbol = "+";
  else if ("sub".equals(operator)) operatorSymbol = "-";
  else if ("mul".equals(operator)) operatorSymbol = "×";
  else if ("div".equals(operator)) operatorSymbol = "÷";
%>

<html>
<head>
  <title>Result</title>
</head>
<body>
<h2>Result:</h2>
<% if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } else { %>
<p><%= first %> <%= operatorSymbol %> <%= second %> = <b><%= result %></b></p>
<% } %>
<a href="input.jsp">Back</a>
</body>
</html>
