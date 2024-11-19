package baller.example.gacpfinal.DAOs;

import baller.example.gacpfinal.beans.CourseBean;
import baller.example.gacpfinal.dbutils.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOGuest {
    /**Handles interactions with the database using guest-privilege
     *
     */
    public DAOGuest() {
    }

    /**Gets a list of all available courses
     *
     * @return
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public List<CourseBean> getAllCourses() throws SQLException, ClassNotFoundException {
        Connection databaseConnection = Database.getDatabaseConnection();
        PreparedStatement getAllCourseRows = databaseConnection.prepareStatement("SELECT * FROM courses");
        ResultSet allCourseRowsResult =  getAllCourseRows.executeQuery();
        ArrayList<CourseBean> courseBeanArrayList = new ArrayList<>();

        while(allCourseRowsResult.next()){
            /*Here we want to add the attributes described in the courses-table which are as follows
            id INT, name VARCHAR(255), yhp DECIMAL(3,1), description VARCHAR(700), startdate DATE, enddate DATE
             */
            CourseBean currentCourseBean = createCourseBean(allCourseRowsResult);

            courseBeanArrayList.add(currentCourseBean);




        }
        databaseConnection.close();
        return courseBeanArrayList;
    }

    /**Creates a coursebean representing a row from a row in a resultset
     *
     * @param courseRowResult
     * @return CourseBean courseBeanFromResultSet
     * @throws SQLException
     */
    public CourseBean createCourseBean(ResultSet courseRowResult) throws SQLException {
        CourseBean currentCourseBean = new CourseBean();

        currentCourseBean.setId(courseRowResult.getInt(1));
        currentCourseBean.setName(courseRowResult.getString(2));
        currentCourseBean.setYhp(courseRowResult.getDouble(3));
        currentCourseBean.setDescription(courseRowResult.getString(4));
        currentCourseBean.setStartDate(courseRowResult.getDate(5));
        currentCourseBean.setEndDate(courseRowResult.getDate(6));
        return currentCourseBean;
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
