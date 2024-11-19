package baller.example.gacpfinal.servlets;

import baller.example.gacpfinal.DAOs.DAOTeacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name="attendanceServlet", urlPatterns = "/attendance")
public class AttendanceServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getServletContext().getRequestDispatcher("/attendance.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String courseName = req.getParameter("courses");
        DAOTeacher daoTeacher = new DAOTeacher();
        try {
            req.setAttribute("attendanceResultList",daoTeacher.getAttendanceListForCourse(courseName));
        } catch (Exception e) {
            /*If we encounter an error we want to forward that to the error-page*/
            req.setAttribute("errors" ,"(DAOTeacher.getAttendanceListForCourse()) in AttendanceServlet, line 31 \n Error-message : "+e.getMessage());
            req.setAttribute("previousPage","attendance.jsp");
            /*Sends the request to the error-page for display*/
            req.getServletContext().getRequestDispatcher("/errorpage.jsp").forward(req,resp);

        }
        this.doGet(req,resp);

    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
