package baller.example.gacpfinal.dbutils;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.util.Enumeration;
import java.util.Objects;
import java.util.Vector;

import static java.sql.JDBCType.INTEGER;
import static java.sql.JDBCType.VARCHAR;

public class Database {
    /*The only thing we have to change is the user and then decide what package to refer them to. We could get the associated
    "user" and db-password from a table of users where we also select the usertype
     */

    private static final String url = "jdbc:mysql://localhost:3306/gritacademycoursesportaldb2.0";
    private static String user = "guest";
    private static String dbPassword = "";




    /**Establishes a connection with the MariaDb database, returns a connection object representing the connection
     * to the database. From this we can create statements and execute queries using those statements, getting a
     * result-set back
     * @returns Connection connection
     * @throws SQLException e
     */
    public static Connection getDatabaseConnection() throws SQLException, ClassNotFoundException {

        /*We don´t want it to close after completing the try so we don´t use try-with*/
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(url, user, dbPassword);


        } finally {

        }


    }

    /** Sets the user and password-variables for the Database depending on if the user-credentials exist in the database or not.
     * -> Is called on login
     * @param username
     * @param password
     * returns: StringArray = {usertype,userFName,userLName,userid} usertype =Student or Teacher if successful login, guest otherwise
     */
    public static String[] setDatabaseCredentials(String username, String password) throws SQLException, ClassNotFoundException {
        String[] userReturnArguments = new String[4];
        try(Connection connection = Database.getDatabaseConnection(); CallableStatement verifyUser = connection.prepareCall("CALL verify_user(?,?,?,?,?,?,?)")){
            /*Try-with for resource management, will set user = guest, password ='' if user-credentials not found and teacher/student credentials otherwise
            Will also return one out parameter that  is the first name of the user and one that is the last name for displaying on their user-page
             */
            verifyUser.setString(1, username);
            verifyUser.setString(2, password);
            verifyUser.registerOutParameter(3, VARCHAR);
            verifyUser.registerOutParameter(4, VARCHAR);
            verifyUser.registerOutParameter(5, VARCHAR);
            verifyUser.registerOutParameter(6, VARCHAR);
            verifyUser.registerOutParameter(7,INTEGER);
            verifyUser.execute();
            /*We set both user, for db-credentials and usertype to the usertype outparameter-value*/
            userReturnArguments[0] = user = verifyUser.getString(3);
            dbPassword =  verifyUser.getString(4);
            userReturnArguments[1] = verifyUser.getString(5);
            userReturnArguments[2] = verifyUser.getString(6);
            userReturnArguments[3] = String.valueOf(verifyUser.getInt(7));





        }
        return userReturnArguments;
    }

    /**Sets db-credentials to guest user values and removes session-attributes
     *
     * @param httpRequest
     */
    public static void logOut(HttpServletRequest httpRequest){
        /*Resetting the database user to guest*/
        user = "guest";
        dbPassword = "";
        /*Removes login attributes from the session*/
        Enumeration<String> allAttributeNames = httpRequest.getSession().getAttributeNames();
        /*for(startcond ; willRunAgaincondition ; operation to perform if one loop done -> Order: Sets startcond in first iteration before
        loop starts, performs iteration if runCondition is fulfilled, checks if runCondition is still fulfilled */

        for( ; allAttributeNames.hasMoreElements(); httpRequest.getSession().removeAttribute(allAttributeNames.nextElement()) );



    }

}
