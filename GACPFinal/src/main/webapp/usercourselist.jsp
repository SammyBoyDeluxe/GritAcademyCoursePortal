<%@ page import="baller.example.gacpfinal.DAOs.DAOTeacher" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="baller.example.gacpfinal.beans.CourseBean" %>
<%@ page import="baller.example.gacpfinal.beans.UserCourseBean" %>
<%@ page import="baller.example.gacpfinal.beans.UserBean" %><%--
  Created by IntelliJ IDEA.
  User: Juna45
  Date: 2024-07-28
  Time: 14:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Klasser</title>
</head>
<%@include file="header.jspf"%>
<nav class="nav-bar" accesskey="N">
    <a class ="nav-link" href="userpage.jsp">Hem</a>
    <a class ="nav-link"  href="${pageContext.request.contextPath}/attendance.jsp">Närvaro</a>
    <a class ="nav-link"  href="${pageContext.request.contextPath}/courselist.jsp">Mina kurser</a>
    <a class ="nav-link" href="${pageContext.request.contextPath}/logout">Logga ut</a>

</nav>

<hr>
<main accesskey="m">
    <%if(!(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("teacher"))||(request.getSession().getAttribute("userType") == null)){
        /*If logged in as student you get re-directed to the directory you have access to*/
        if(request.getSession().getAttribute("userType").toString().equalsIgnoreCase("student")) request.getServletContext().getRequestDispatcher("/userpage.jsp").forward(request,response);
        /*You need to be logged in to have access to anything else but the login and index page*/
        request.getSession().setAttribute("loginError", "Du måste vara inloggad med lärarberhöighet för att se denna sidan, vänligen logga in:");
        request.getServletContext().getRequestDispatcher("/login.jsp").forward(request,response);}%>
    <%  /*We want to add the courseNamelist for the drop-down menu, capacity zero serves as a detection-case for not being initialized*/
        List<String> courseNames = new ArrayList<>(0);
        DAOTeacher daoTeacher = new DAOTeacher();
        try {
            courseNames = daoTeacher.getAllCourseNames();
        } catch (Exception e) {
            /*If we encounter an error we want to forward that to the error-page*/
            request.setAttribute("errors","(DAOTeacher.getAllCourseNames()) Failure in: usercourselist.jsp, Line: 28 \n Error-message : "+e.getMessage());
            request.setAttribute("previousPage","usercourselist.jsp");
            /*Sends the request to the error-page for display*/
            session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);
        }
        /*Now we have a valid courseNameList*/
    %>
    <%/*if studentCourseResultList == null we want to show the normal coursepage, otherwise student and courses -> After completing
     */
        if(request.getSession().getAttribute("classResultList") == null){%>


    <!--Table contains the following elements: <tr>(table-row), <th>(table-head), <td>tabledatacell (1*headers per <tr>) -->
    <table>
        <h4>Studenter</h4>
        <tr>
            <th> Förnamn </th>
            <th> Efternamn </th>
            <th> Residensplats </th>
            <th> Telefonnummer </th>

        </tr>
        <%
            List<UserBean> userBeanArrayList = null;
            try {
                userBeanArrayList =  daoTeacher.getAllStudents();
            } catch (Exception e) {
                /*If we encounter an error we want to forward that to the error-page*/
                request.setAttribute("errors" ,"(DAOCourseBean.selectAll()) Error-message : "+e.getMessage());
                request.setAttribute("previousPage","courselist.jsp");
                /*Sends the request to the error-page for display*/
                session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);

            }

            /*If size equals zero we have not gotten any courses and we shouldn´t run the loop*/
            for(int i= 0 ; (i<userBeanArrayList.size()) ; i++) { %>
        <tr>

            <td><%=userBeanArrayList.get(i).getfName()%></td>
            <td><%=userBeanArrayList.get(i).getlName()%></td>
            <td><%=userBeanArrayList.get(i).getCity()%></td>
            <td><%=userBeanArrayList.get(i).getPhone()%></td>

        </tr>
        <%}%>


    </table>

    <div class="search-and-add-bar">
        <% if(!(courseNames.isEmpty())){ %>
        <form class ="course-input-form" method="post" action="${pageContext.request.contextPath}/classes">
            <fieldset>
                <legend>Välj i kurslistan för att få en klasslista över kursens deltagare</legend>
                <label for="courses" >Välj Kurs:</label>
                <select id="courses" name="courses" size="<%=courseNames.size()%>">
                    <%
                        for(int i = 0 ; i < courseNames.size(); i++) {
                    %>
                    <option value="<%=courseNames.get(i)%>"><%=courseNames.get(i)%></option>
                    <%}%>
                </select>

                <button type="submit">Sök</button>
                <!--Empty pTags to contain our error message when one or more exists -->

            </fieldset>
        </form>
        <%}%>

    </div>
    <%} else{%>
    <%  /*Now we know that we a studentCourseResultList, let´s display it*/
        DAOTeacher daoStudentCourseBean = new DAOTeacher();
        ArrayList<UserCourseBean> studentCourseResultList = new ArrayList<>(0);
        try {
            studentCourseResultList = (ArrayList<UserCourseBean>) request.getSession().getAttribute("classResultList");
            /*When we press back we want to load the original page-code-block, thus we must remove the attribute.
         The parameters only persist with the request so they do not need to be removed*/
            request.getSession().removeAttribute("classResultList");
        } catch (Exception e) {
            /*If we encounter an error we want to forward that to the error-page*/
            request.setAttribute("errors","(DAOCourseBean.selectAll()) Error-message : "+e.getMessage());
            request.setAttribute("previousPage","courselist.jsp");
            /*Sends the request to the error-page for display*/
            session.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);

        }
        UserCourseBean[] studentCourseBeanArray = null;
        if (studentCourseResultList != null) {
            studentCourseBeanArray = new UserCourseBean[studentCourseResultList.size()];
        }
        studentCourseBeanArray =  studentCourseResultList.toArray(studentCourseBeanArray);
        String courseName = "";
        String teacherFirstName = "";
        String teacherLastName = "";
        boolean teacherFound = false;
        /*We want to show what teacher teaches the course and what the course-name is, this can all be extracted from the teacher´s usercoursebean*/
        for(int i= 0 ; (i<studentCourseResultList.size()) && (studentCourseResultList.size()>0) && !(teacherFound) ; i++) {
            if(studentCourseBeanArray[i].getUserType().equalsIgnoreCase("teacher")){
                courseName = studentCourseBeanArray[i].getCourseName();
                teacherFirstName = studentCourseBeanArray[i].getfName();
                teacherLastName = studentCourseBeanArray[i].getlName();
                teacherFound = true;

            }
        }
    %>
    <!--Table contains the following elements: <tr>(table-row), <th>(table-head), <td>tabledatacell (1*headers per <tr>) -->
    <hr>
    <h4>Kursnamn: <%=courseName%> </h4>
    <h5>Lärare: <%=teacherFirstName%> <%=teacherLastName%></h5>
    <hr>
    <table>
        <tr>

            <th> Förnamn </th>
            <th> Efternamn </th>


        </tr>

        <%  /*If size equals zero we have not gotten any courses and we shouldn´t run the loop*/
           for(int i= 0 ; (i<studentCourseResultList.size()) && (studentCourseResultList.size()>0) ; i++) { %>



        <tr>


            <td><%=studentCourseBeanArray[i].getfName()%></td>
            <td><%=studentCourseBeanArray[i].getlName()%></td>


        </tr>

        <%}%>


    </table>
    <button><a href="${pageContext.request.contextPath}/classes">Tillbaka</a></button>
    <%}%>
</main>

<%@include file="footer.jspf"%>
<body>




</body>
</html>
