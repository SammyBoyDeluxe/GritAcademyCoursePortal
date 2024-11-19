package baller.example.gacpfinal;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "indexServlet", value = "/")
public class IndexServlet extends HttpServlet {
    private String message;

    public void init() {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            request.getSession().getServletContext().getRequestDispatcher("/index.jsp").forward(request,response);
        } catch (Exception e) {
            /*If we encounter an error we want to forward that to the error-page*/
            request.setAttribute("errors","(.getRequestDispatcher(\"/index.jsp\").forward(request,response)) Error-message in IndexServlet line,20 : "+e.getMessage());
            request.setAttribute("previousPage","index.jsp");
            /*Sends the request to the error-page for display*/
            getServletContext().getRequestDispatcher("/errorpage.jsp").forward(request,response);
        }
    }

    public void destroy() {
    }
}