<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gritacademy Course Portal : Index-page</title>
    <link rel="stylesheet" href="stylesheets/listpages.css">
</head>
<body>
<%@include file="header.jspf"%>
<nav class="nav-bar" accesskey="N">
    <a class ="nav-link" href="login.jsp">Logga in</a>
</nav>
<hr>
<%@include file="courseSelectionTable.jspf"%>
<%@include file="footer.jspf"%>
</body>
</html>