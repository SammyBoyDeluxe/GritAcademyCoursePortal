package baller.example.gacpfinal.servlets;

import baller.example.gacpfinal.DAOs.DAOTeacher;
import baller.example.gacpfinal.beans.CourseBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet(name="courseServlet", urlPatterns = "/courses")
public class CourseServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DAOTeacher daoTeacher = new DAOTeacher();
        int courseId = -2;
        if (daoTeacher.getParameterValidity(req.getParameter("courseNameAddCourse")) && daoTeacher.getParameterValidity(req.getParameter("yhpAddCourse")) && daoTeacher.getParameterValidity(req.getParameter("descriptionAddCourse")) && daoTeacher.getParameterValidity(req.getParameter("startDateAddCourse")) && daoTeacher.getParameterValidity(req.getParameter("endDateAddCourse"))) {

            /*We have checked for non-empty/non-blank values, since we don´t set the parameters to attrbibutes we must not remove them later -> They´ll delete themselves*/
            String courseName = req.getParameter("courseNameAddCourse");
            double yhp = Double.parseDouble(req.getParameter("yhpAddCourse"));
            String description = req.getParameter("descriptionAddCourse");
            Date startDate = Date.valueOf(req.getParameter("startDateAddCourse"));
            Date endDate = Date.valueOf(req.getParameter("endDateAddCourse"));

            CourseBean insertBean = new CourseBean();
            insertBean.setName(courseName);
            insertBean.setYhp(yhp);
            insertBean.setDescription(description);
            insertBean.setStartDate(startDate);
            insertBean.setEndDate(endDate);
            try {
                courseId = daoTeacher.insertCourse(insertBean);
            } catch (Exception e) {
                /*If we encounter an error we want to forward that to the error-page*/
                req.getSession().setAttribute("errors", "(daoteacher.insertInto(CourseBean insertBean)) in UserCourseListServlet, Line: 64 \n Error-message : " + e.getMessage());
                req.getSession().setAttribute("previousPage", "courselist.jsp");
                /*Sends the request to the error-page for display*/
                this.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(req, resp);
            }
            /*Once a course is created it need to be associated with a teacher*/
            try {
                daoTeacher.insertUserCourse(Integer.parseInt(req.getSession().getAttribute("userId").toString()), courseId);
            } catch (Exception e) {
                /*If we encounter an error we want to forward that to the error-page*/
                req.getSession().setAttribute("errors", "(daoteacher.inserUserCourse(int userId, int courseId)) in CourseServlet, Line: 52 \n Error-message : " + e.getMessage());
                req.getSession().setAttribute("previousPage", "courselist.jsp");
                /*Sends the request to the error-page for display*/
                this.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(req, resp);
            }


        } req.getServletContext().getRequestDispatcher("/courselist.jsp").forward(req,resp);
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
