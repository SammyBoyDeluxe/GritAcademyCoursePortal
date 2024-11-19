<%@ page import="baller.example.gacpfinal.DAOs.DAOStudent" %>
<%@ page import="baller.example.gacpfinal.beans.AttendanceBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="baller.example.gacpfinal.DAOs.DAOTeacher" %>
<%@ page import="java.util.List" %>
<%@ page import="baller.example.gacpfinal.beans.CourseBean" %><%--
  Created by IntelliJ IDEA.
  User: Juna45
  Date: 2024-07-22
  Time: 19:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Närvaro</title>
</head>
<body>
<%@include file="header.jspf"%>
<%if((request.getSession().getAttribute("userType") == null)){
    /*You need to be logged in to have access to anything else but the login and index page*/
    request.getSession().setAttribute("loginError", "Du måste vara inloggad för att se denna sidan, vänligen logga in:");
    request.getServletContext().getRequestDispatcher("/login.jsp").forward(request,response);}%>
<nav class="nav-bar" accesskey="N">
    <a class ="nav-link" href="userpage.jsp">Hem</a>
    <%if(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("teacher")){ %>
    <a class ="nav-link"  href="${pageContext.request.contextPath}/usercourselist.jsp">Student & klasslistor</a>
    <%}%>
    <a class ="nav-link"  href="${pageContext.request.contextPath}/courselist.jsp">Mina kurser</a>
    <a class ="nav-link" href="${pageContext.request.contextPath}/logout">Logga ut</a>

</nav>
<hr>

<%  /*Students should be shown their own attendance, teachers should be able to get attendancelist by coursename*/
    if (request.getSession().getAttribute("userType").equals("Student")){
    DAOStudent daoAttendanceBean = new DAOStudent();
    ArrayList<AttendanceBean> attendanceBeanArrayList = null;
    try {
    attendanceBeanArrayList = (ArrayList<AttendanceBean>) daoAttendanceBean.getAttendanceForStudent( Integer.parseInt((String) request.getSession().getAttribute("userId")));
    } catch (Exception e) {
    /*If we encounter an error we want to forward that to the error-page*/
    request.setAttribute("errors","(DAOStudent.getAttendanceForStudent(int userid)) Error-message in attendance.jsp line:29 : "+e.getMessage());
    request.setAttribute("previousPage","attendance.jsp");
    /*Sends the request to the error-page for display*/
    session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);
    }
    AttendanceBean[] attendanceBeanArray = new AttendanceBean[attendanceBeanArrayList.size()];
    attendanceBeanArray =  attendanceBeanArrayList.toArray(attendanceBeanArray);
%>
<table>
    <tr>
        <th> Kursnamn </th>
        <th> Förnamn </th>
        <th> Efternamn </th>
        <th> Lektionsdatum </th>
        <th> Närvaro </th>
    </tr>
    <%
    for(int i= 0 ; i<attendanceBeanArrayList.size() ; i++) { %>
<tr>

    <td><%=attendanceBeanArray[i].getCourseName()%></td>
    <td><%=attendanceBeanArray[i].getfName()%></td>
    <td><%=attendanceBeanArray[i].getlName()%></td>
    <td><%=attendanceBeanArray[i].getLessonDate()%></td>
    <td><%=attendanceBeanArray[i].isAttended()%></td>

</tr>
<%}%>


</table>


<%} else if(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("teacher")){
    /*We want to add the courseNamelist for the drop-down menu, capacity zero serves as a detection-case for not being initialized*/
    List<CourseBean> courseNames = new ArrayList<>(0);
    DAOTeacher daoTeacher = new DAOTeacher();
    try {
        courseNames = daoTeacher.getAllCoursesForUser(Integer.parseInt(request.getSession().getAttribute("userId").toString()));
    } catch (Exception e) {
        /*If we encounter an error we want to forward that to the error-page*/
        request.setAttribute("errors","(DAOTeacher.getCourseNamesForUser(int userid)) Failure in: attendance.jsp, Line: 64 \n Error-message : "+e.getMessage());
        request.setAttribute("previousPage","usercourselist.jsp");
        /*Sends the request to the error-page for display*/
        session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);
    }
%>
<div class="search-and-add-bar">
        <% if(!(courseNames.isEmpty())){ %>
    <form class ="course-input-form" method="post" action="${pageContext.request.contextPath}/attendance">
        <fieldset>
            <legend>Välj i kurslistan för att få en närvarolista över kursens deltagare</legend>
            <label for="courses" >Välj Kurs:</label>
            <select id="courses" name="courses" size="<%=courseNames.size()%>">
                <%
                    for(int i = 0 ; i < courseNames.size(); i++) {
                %>
                <option value="<%=courseNames.get(i).getName()%>"><%=courseNames.get(i).getName()%></option>
                <%}%>
            </select>

            <button type="submit">Sök</button>


        </fieldset>
    </form>
        <%}%>
         <%  /*If a course has been selected we want to show the attendancetable of that course*/
            if(request.getAttribute("attendanceResultList") != null){ %>
            <table>
            <tr>
                <th>Förnamn</th>
                <th>Efternamn</th>
                <th>Kursnamn</th>
                <th>Lektionsdatum</th>
                <th>Närvarande</th>

            </tr>
             <%
               ArrayList<AttendanceBean> attendanceList = (ArrayList<AttendanceBean>) request.getAttribute("attendanceResultList");
               for(int i = 0 ; i < attendanceList.size() ; i++){
          %>  <tr>


                <td><%=attendanceList.get(i).getfName()%></td>
                <td><%=attendanceList.get(i).getlName()%></td>
                <td><%=attendanceList.get(i).getCourseName()%></td>
                <td><%=attendanceList.get(i).getLessonDate()%></td>
                <td><%=attendanceList.get(i).isAttended()%></td>

        </tr>
                <%}%>


            </table>

<%} /*We clear the attribute*/ request.removeAttribute("attendanceResultList"); }else {
    /*You need to be logged in to have access to anything else but the login and index page*/
    request.getSession().setAttribute("loginError", "Du måste vara inloggad för att se denna sidan, vänligen logga in:");
    request.getServletContext().getRequestDispatcher("login.jsp").forward(request,response);

}
 %>
<%@include file="footer.jspf"%>
</body>
</html>