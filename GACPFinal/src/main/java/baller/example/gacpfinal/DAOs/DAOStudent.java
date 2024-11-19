package baller.example.gacpfinal.DAOs;

import baller.example.gacpfinal.beans.AttendanceBean;
import baller.example.gacpfinal.beans.CourseBean;
import baller.example.gacpfinal.beans.UserCourseBean;
import baller.example.gacpfinal.dbutils.Database;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOStudent extends DAOGuest{


    /**Gets all courses a specific user is associated with
     *
     * @param userId
     */

    public List<CourseBean> getAllCoursesForUser(int userId) throws SQLException, ClassNotFoundException {
        Connection databaseConnection = Database.getDatabaseConnection();
        PreparedStatement getAllCourseRows = databaseConnection.prepareStatement("SELECT name,yhp,startdate,enddate FROM usercourselist WHERE id = ?");
        getAllCourseRows.setInt(1,userId);
        ResultSet allCourseRowsResult =  getAllCourseRows.executeQuery();
        ArrayList<CourseBean> courseBeanArrayList = new ArrayList<>();



        while(allCourseRowsResult.next()){
            CourseBean currentCourseBean = new CourseBean();
            /*Here we want to add the attributes described in the courses-table which are as follows
            id INT, name VARCHAR(255), yhp DECIMAL(3,1), description VARCHAR(700), startdate DATE, enddate DATE
             */

            currentCourseBean.setName(allCourseRowsResult.getString(1));
            currentCourseBean.setYhp(allCourseRowsResult.getDouble(2));
            currentCourseBean.setStartDate(allCourseRowsResult.getDate(3));
            currentCourseBean.setEndDate(allCourseRowsResult.getDate(4));

            courseBeanArrayList.add(currentCourseBean);




        }
        databaseConnection.close();
        return courseBeanArrayList;

    }




    public List<AttendanceBean> getAttendanceForStudent(int userId) throws SQLException, ClassNotFoundException {
        Connection databaseConnection = Database.getDatabaseConnection();
        PreparedStatement getAllAttendanceRows = databaseConnection.prepareStatement("SELECT * FROM attendancetablelist WHERE id = ?");
        getAllAttendanceRows.setInt(1,userId);
        ResultSet allAttendanceRowsResult =  getAllAttendanceRows.executeQuery();
        ArrayList<AttendanceBean> attendanceBeanArrayList = new ArrayList<>();
        AttendanceBean attendanceBean;
        while(allAttendanceRowsResult.next()){

             attendanceBean = createAttendanceBean(allAttendanceRowsResult);

            attendanceBeanArrayList.add(attendanceBean);




        }
        databaseConnection.close();
        return attendanceBeanArrayList;

    }

    /**Creates an AttendanceBean from a resultSet row
     *
     * @param attendanceResult
     * @return
     * @throws SQLException
     */
    public AttendanceBean createAttendanceBean(ResultSet attendanceResult) throws SQLException {
        AttendanceBean attendanceBean = new AttendanceBean();

        attendanceBean.setId(attendanceResult.getInt(1));
        attendanceBean.setfName(attendanceResult.getString(2));
        attendanceBean.setlName(attendanceResult.getString(3));
        attendanceBean.setCourseName(attendanceResult.getString(4));
        attendanceBean.setLessonDate(attendanceResult.getDate(5));
        attendanceBean.setAttended(attendanceResult.getBoolean(6));

        return attendanceBean;
    }

    /**Returns the selection of courses for Grit Academy Course Portal
     *
     * @return List <CourseBean> allAvailableCourses<>
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    @Override
    public List<CourseBean> getAllCourses() throws SQLException, ClassNotFoundException {
        return super.getAllCourses();
    }
    /**Creates a coursebean representing a row from a row in a resultset
     *
     * @param courseRowResult
     * @return CourseBean courseBeanFromResultSet
     * @throws SQLException
     */
    @Override
    public CourseBean createCourseBean(ResultSet courseRowResult) throws SQLException {
        return super.createCourseBean(courseRowResult);
    }

    /**Creates a usercoursebean with the required
     *
     * @param usercourseRowResult
     * @return
     * @throws SQLException
     */
    public UserCourseBean createUserCourseBeanStudent(ResultSet usercourseRowResult) throws SQLException {
        UserCourseBean usercourseBean = new UserCourseBean();

        usercourseBean.setCourseName(usercourseRowResult.getString(4));
        usercourseBean.setYhp(usercourseRowResult.getDouble(5));
        usercourseBean.setStartDate(usercourseRowResult.getDate(6));
        usercourseBean.setEndDate(usercourseRowResult.getDate(7));
        return usercourseBean;
    }
}
