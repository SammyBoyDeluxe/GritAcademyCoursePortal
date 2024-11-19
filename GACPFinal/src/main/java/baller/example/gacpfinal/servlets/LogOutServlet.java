package baller.example.gacpfinal.servlets;

import baller.example.gacpfinal.IndexServlet;
import baller.example.gacpfinal.dbutils.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="logOutServlet", urlPatterns = "/logout")
public class LogOutServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*Sets db-credentials to guest and removes session-attributes*/
        Database.logOut(req);
        /*Re-directs the request-response to the index-servlet to redirect the logged out user to the index-page*/
        IndexServlet indexServlet = new IndexServlet();
        indexServlet.doGet(req, resp);

    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
