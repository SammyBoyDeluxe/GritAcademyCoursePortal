<%--
  Created by IntelliJ IDEA.
  User: Juna45
  Date: 2024-07-06
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log-in</title>
</head>
<body>
<%@include file="header.jspf"%>
<nav class="nav-bar" accesskey="N">
    <a class ="nav-link" href="index.jsp">Kursutbud</a>
</nav>
<hr>
<main>
    <form class ="student-input-form" method="post" action="${pageContext.request.contextPath}/login">
        <fieldset>
        <legend>Logga in med Grit-konto</legend>
         <p> ${loginError}</p>
        <label class="student-first-name-label" for="username-input">Användarnamn: </label>
        <input name="loginUsername" type="text"  id="username-input">

        <label class="student-last-name-label" for="password-input">Lösenord:</label>
        <input name="loginPassword" type="password" id="password-input">

        <button type="submit">Logga in</button>
    </fieldset>


    </form>
</main>
<%@include file="footer.jspf"%>
</body>
</html>
