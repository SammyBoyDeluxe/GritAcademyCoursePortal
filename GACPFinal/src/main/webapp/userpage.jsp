<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Grit academy Course Portal</title>
    <!--A link links an external resource to the HTML via URL and explains its relation, that is
    how the program is supposed to interpret the file, in this case as a stylesheet
    -->
    <link rel="stylesheet"  href="stylesheets/index.css">
</head>
<body>
<%@include file="header.jspf"%>
<main>
    <div class="background-div"  >
        <div>
            <h3>Välkommen ${userFName} ${userLName} (${userType})</h3>
        </div>
        <div class="main-divs" id="button-container">
            <%/*In the login-servlet we get redirected here, we save the attributes username, usertype, userFName, userLName, userId
            So now we can choose what we should be able to do depending on the usertype; A student should be able to see their courses and their attendance.
            A teacher should be able to see a list of all students as well, this will be presented as classes: From usercourselist in data*/
                if(request.getSession().getAttribute("userType").equals("Student")){

            %>
            <!--Here we have three buttons, inside which we can find hypertext links to all our respective sub-pages -->
            <button class="button" id="courses-page-button"><a href="${pageContext.request.contextPath}/courselist.jsp">Mina kurser</a></button>
            <button class="button" id="attendance-page-button"><a href="attendance.jsp">Närvaro</a></button>
            <button class="button" id="log-out-button"><a class ="nav-link" href="${pageContext.request.contextPath}/logout">Logga ut</a></button>

            <%}else if(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("teacher")){%>
            <button class="button" id="courses-page-button"><a href="${pageContext.request.contextPath}/courselist.jsp">Kurslista</a></button>
            <button class="button" id="attendance-page-button"><a href="${pageContext.request.contextPath}/attendance.jsp">Närvarolista</a></button>
            <button class="button" id="student-page-button"><a href="${pageContext.request.contextPath}/usercourselist.jsp">Studentlista</a></button>
            <button class="button" id="log-out-button"><a class ="nav-link" href="${pageContext.request.contextPath}/logout">Logga ut</a></button>
            <%}else if((request.getSession().getAttribute("userType") == null)){
            /*You need to be logged in to have access to anything else but the login and index page*/
            request.getSession().setAttribute("loginError", "Du måste vara inloggad med lärarberhöighet för att se denna sidan, vänligen logga in:");
            request.getServletContext().getRequestDispatcher("/login.jsp").forward(request,response);}%>






        </div>
    </div>
</main>
</body>
</html>