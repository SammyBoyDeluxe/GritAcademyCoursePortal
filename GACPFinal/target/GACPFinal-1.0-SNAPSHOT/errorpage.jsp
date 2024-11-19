<%--
  Created by IntelliJ IDEA.
  User: Juna45
  Date: 2024-07-02
  Time: 22:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
</head>
<body>
<%@include file="header.jspf"%>
<main>
    <div class="background-div"  >
        <!--<img src="imagefolder/Grit-Academy-logo.png" id="logo-image" alt="Detta är en bild på grit academys logga"></img>
        -->
        <div class="main-divs" id="button-container">
            <h2>Errors: </h2>
            <br>
            <p>${errors}</p>
            <!--Here we have three buttons, inside which we can find hypertext links to all our respective sub-pages -->
            <button class="button" id="previous-page-button"><a href="${pageContext.request.contextPath}/${previousPage}">Tillbaka</a></button>






        </div>
    </div>
</main>
<%@include file="footer.jspf"%>

</body>
</html>
