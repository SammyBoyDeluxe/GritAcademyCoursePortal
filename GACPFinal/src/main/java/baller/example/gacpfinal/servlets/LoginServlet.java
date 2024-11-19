package baller.example.gacpfinal.servlets;



import baller.example.gacpfinal.dbutils.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name="loginServlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        req.getSession().getServletContext().getRequestDispatcher("/userpage.jsp").forward(req, resp);
    }

    /*!When not inputting anything the parameters are null, implement perhaps a child-class for HTTPServlets with a checking for null/blank/empty-method!*/
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        /*When doPost is called on this page we have request-parameters from the login-field, must check for implicit values and blank, they can´t be null since
         since we have no other post-form calling this servlet
         */
        if ( getParameterValidity(req.getParameter("loginUsername")) && getParameterValidity(req.getParameter("loginPassword")) ) {
            String username = req.getParameter("loginUsername");
            String password = req.getParameter("loginPassword");
            try {
                String[] userReturnArguments = new String[4];
                userReturnArguments = Database.setDatabaseCredentials(username, password);
                /*if == guest login failed*/
                if (userReturnArguments[0].equalsIgnoreCase("guest")) {
                    req.getSession().setAttribute("loginError", "Det fanns inga matchande inloggningsuppgifter i databasen, vänligen försök igen");
                    /*We redirect back to the login page if failed*/
                    this.getServletContext().getRequestDispatcher("/login.jsp").forward(req,resp);
                } else {
                   /*Now we know the user login succeeded, hence we want to set the username and userReturnArguments as session attributes and
                    and we want to direct them to the userpage. Username is unique so it can be used as a pk-field (database meaning, identifying the entity)*/
                    req.getSession().setAttribute("username", username);
                    req.getSession().setAttribute("userType", userReturnArguments[0]);
                    req.getSession().setAttribute("userFName", userReturnArguments[1]);
                    req.getSession().setAttribute("userLName", userReturnArguments[2]);
                    req.getSession().setAttribute("userId", userReturnArguments[3]);
                    this.doGet(req, resp);


                }
            } catch (Exception e) {
                /*If we encounter an error we want to forward that to the error-page*/
                req.setAttribute("errors", "(Database.setDatabaseCredentials()) Failure in: LoginServlet, Line: 36 \n Error-message : " + e.getMessage());
                req.setAttribute("previousPage", "login.jsp");
                /*Sends the request to the error-page for display*/
                req.getSession().getServletContext().getRequestDispatcher("/errorpage.jsp").forward(req, resp);
            }

        }  /*If they are blank we want to update the errorvariable and redirect them to the login-page once more and inform them of that */ else {
            req.getSession().setAttribute("loginError", "Ett eller flera fält lämnades tomma, vänligen försök igen");
            req.getSession().getServletContext().getRequestDispatcher("/login.jsp").forward(req,resp);
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }

    /**Returns true if the parameter has a a valid input value
     *
     * @param parameter
     * @return true if a valid input-parameter,false if not
     */
    public boolean getParameterValidity(String parameter) {
        return (parameter != null) && !(parameter.isBlank()) && !(parameter.isEmpty());

    }
}