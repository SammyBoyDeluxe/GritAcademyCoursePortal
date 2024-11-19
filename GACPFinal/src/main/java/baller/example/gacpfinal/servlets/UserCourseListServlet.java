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

@WebServlet(name="userCourseListServlet", urlPatterns = "/classes")
public class UserCourseListServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getServletContext().getRequestDispatcher("/usercourselist.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*We have one of two post-cases: Either we add a course or we search for a course with its associated students
        Since we have less values to handle with searching we use this as first case*/
        DAOTeacher daoTeacher = new DAOTeacher();
        /*Will throw an error if the course wasn´t added for some reason*/
        int courseId = -2;
        /*First we see if the parameter exists or not, will return null if it doesn´t exist*/
        if(req.getParameter("courses")!=null){
            /*We want to get the studentCourseList, select DISTINCT values*/
            DAOTeacher dao = new DAOTeacher();
            try {
                req.getSession().setAttribute("classResultList", dao.getClass(req.getParameter("courses")));
            } catch (Exception e) {
                /*If we encounter an error we want to forward that to the error-page*/
                req.setAttribute("errors","(DAOTeacher.getClass(String courseName)) in UserCourseListServlet, Line: 37 \n Error-message : "+e.getMessage());
                req.setAttribute("previousPage","usercourselist.jsp");
                /*Sends the request to the error-page for display*/
                this.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(req,resp);
            }


            /*Since all will have starting values when we do the post method with the add-form we check for these*/
        }

        this.doGet(req,resp);
    }

    public void insertUserCourse(int userid, int courseid){


    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
