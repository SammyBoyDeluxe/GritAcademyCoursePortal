<%@ page import="baller.example.gacpfinal.DAOs.DAOStudent" %>
<%@ page import="baller.example.gacpfinal.beans.CourseBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="baller.example.gacpfinal.DAOs.DAOTeacher" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Juna45
  Date: 2024-07-22
  Time: 20:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kurser</title>
</head>
<body>
<%@include file="header.jspf"%>
<%if((request.getSession().getAttribute("userType") == null)){
    /*You need to be logged in to have access to anything else but the login and index page*/
    request.getSession().setAttribute("loginError", "Du måste vara inloggad  för att se denna sidan, vänligen logga in:");
    request.getServletContext().getRequestDispatcher("/login.jsp").forward(request,response);}%>
<nav class="nav-bar" accesskey="N">
    <a class ="nav-link" href="userpage.jsp">Hem</a>
    <%  /*Only the teacher should have access to the userCourseList*/
        if(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("teacher")){
     %>
    <a class ="nav-link" href="${pageContext.request.contextPath}/usercourselist.jsp">Student och klasslista</a>
    <%}%>
    <a class ="nav-link"  href="${pageContext.request.contextPath}/attendance.jsp">Närvarolista</a>
    <a class ="nav-link" href="${pageContext.request.contextPath}/logout">Logga ut</a>

</nav>
<hr>

<%  /*We want a student to be able to see all courses they participate in*/
    if(request.getSession().getAttribute("userType").equals("Student")){


%>
<table>
    <tr>
        <th> Kursnamn </th>
        <th> Förnamn </th>
        <th> Efternamn </th>
        <th> YHP </th>
    </tr><%  /*Students should be shown their own attendance, teachers should be able to get attendancelist by coursename*/
    if (request.getSession().getAttribute("userType").equals("Student")){
        DAOStudent daoCourseBean = new DAOStudent();
        ArrayList<CourseBean> courseBeanArrayList = null;
        try {
            courseBeanArrayList = (ArrayList<CourseBean>) daoCourseBean.getAllCoursesForUser( Integer.parseInt((String) request.getSession().getAttribute("userId")));
        } catch (Exception e) {
            /*If we encounter an error we want to forward that to the error-page*/
            request.setAttribute("errors","(DAOStudent.getAllCoursesForStudent(int userid)) Error-message in courselist.jsp line:33 : "+e.getMessage());
            request.setAttribute("previousPage","courselist.jsp");
            /*Sends the request to the error-page for display*/
            session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);
        }
        CourseBean[] courseBeanArray = new CourseBean[courseBeanArrayList.size()];
        courseBeanArray =  courseBeanArrayList.toArray(courseBeanArray);

        for(int i= 0 ; i<courseBeanArrayList.size() ; i++) { %>
    <tr>

        <td><%=courseBeanArray[i].getName()%></td>
        <td><%=courseBeanArray[i].getStartDate()%></td>
        <td><%=courseBeanArray[i].getEndDate()%></td>
        <td><%=courseBeanArray[i].getYhp()%></td>
        <td><%=courseBeanArray[i].getDescription()%></td>

    </tr>
    <%}%>


</table>



<%}} else if(request.getSession().getAttribute("userType").equals("Teacher")){
    DAOTeacher daoTeacher = new DAOTeacher();
    ArrayList<CourseBean> teacherCourses = new ArrayList<>();
    try {
         teacherCourses = (ArrayList<CourseBean>) daoTeacher.getAllCoursesForUser(Integer.parseInt((String) request.getSession().getAttribute("userId")));
    } catch (Exception e) {
        /*If we encounter an error we want to forward that to the error-page*/
        request.getSession().setAttribute("errors", "(daoteacher.getAllCoursesForUser(int userId)) in courselist.jsp, Line: 80 \n Error-message : " + e.getMessage());
        request.getSession().setAttribute("previousPage", "courselist.jsp");
        /*Sends the request to the error-page for display*/
        request.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request, response);
    }%>
    <table>
        <hr>
        <h3>Mina kurser:</h3>
        <hr>
        <tr>
            <th>Kursnamn</th>
            <th>YHP</th>
            <th>Start-datum</th>
            <th>Slut-datum</th>
        </tr>
    <%

    for(int i = 0 ; i < teacherCourses.size() ; i++){


   %>
        <tr>
            <td><%=teacherCourses.get(i).getName()%> </td>
            <td><%=teacherCourses.get(i).getYhp()%> </td>
            <td><%=teacherCourses.get(i).getStartDate()%> </td>
            <td><%=teacherCourses.get(i).getEndDate()%> </td>



        </tr>
   <%     }
    %>
    </table>
        <form class ="input-form" method="post" action="${pageContext.request.contextPath}/courses">
            <fieldset>
                <legend>Lägg till kurs:</legend>
                <label class="input-label" for="course-name-add-input">Kursnamn:</label>
                <input name="courseNameAddCourse" type="text" id="course-name-add-input">

                <label class="input-label" for="yhp-add-input">YHP:</label>
                <input name="yhpAddCourse" type="number" min="5" max="30" step="0.5"  id="yhp-add-input">

                <label class="input-label" for="description-add-input">Beskrivning:</label>
                <textarea name="descriptionAddCourse" id="description-add-input" style="width: 10vw; height: 10vh;" cols="20" rows="20"></textarea>

                <label class="input-label" for="startdate-add-input">Start-datum:</label>
                <input name="startDateAddCourse" type="date" id="startdate-add-input">

                <label class="input-label" for="enddate-add-input">Slut-datum:</label>
                <input name="endDateAddCourse" type="date" id="enddate-add-input">

                <button type="submit">Lägg till</button>

            </fieldset>

        </form>


        <%}else {            /*You need to be logged in to have access to anything else but the login and index page*/
                           request.getSession().setAttribute("loginError", "Du måste vara inloggad för att se denna sidan, vänligen logga in:");
                           request.getServletContext().getRequestDispatcher("login.jsp").forward(request,response);

    }%>



<%@include file="footer.jspf"%>
</body>
</html>
