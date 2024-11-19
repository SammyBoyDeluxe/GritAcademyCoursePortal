package baller.example.gacpfinal.DAOs;

import baller.example.gacpfinal.beans.AttendanceBean;
import baller.example.gacpfinal.beans.CourseBean;
import baller.example.gacpfinal.beans.UserBean;
import baller.example.gacpfinal.beans.UserCourseBean;
import baller.example.gacpfinal.dbutils.Database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOTeacher extends DAOStudent{


    /**Gets the class associated with the course name (usertype, fname,lname,coursename,yhp,startdate,enddate)
     *
     * @param courseName
     * @return classArrayList
     */
    public ArrayList<UserCourseBean> getClass(String courseName) throws SQLException, ClassNotFoundException {


        Connection connection = Database.getDatabaseConnection();
        PreparedStatement getClass = connection.prepareStatement("SELECT usertype,fname,lname,name,yhp,startdate,enddate FROM usercourselist WHERE name = ?");
        getClass.setString(1,courseName);
        ResultSet classResult = getClass.executeQuery();

        ArrayList<UserCourseBean> classArrayList = new ArrayList<>();

        while(classResult.next()){
            UserCourseBean current = new UserCourseBean();

            current.setUserType(classResult.getString(1));
            current.setfName(classResult.getString(2));
            current.setlName(classResult.getString(3));
            current.setCourseName(classResult.getString(4));
            current.setYhp(classResult.getDouble(5));
            current.setStartDate(classResult.getDate(6));
            current.setEndDate(classResult.getDate(7));

            classArrayList.add(current);

        }

        return classArrayList;


    }

    /** Gets all students from the students table
     *
     * @return studentList
     */
    public List<UserBean> getAllStudents() throws SQLException, ClassNotFoundException {
        Connection connection = Database.getDatabaseConnection();
        PreparedStatement getAllStudents = connection.prepareStatement("SELECT * FROM students");
        ResultSet allStudentsResult = getAllStudents.executeQuery();
        List<UserBean> allStudentsArrayList = new ArrayList<>();
        while(allStudentsResult.next()){
            UserBean student = createStudentListUserBean(allStudentsResult);
            allStudentsArrayList.add(student);

        }
        return allStudentsArrayList;



    }

    /**Get all current courses in the grit academy courses list
     *
     * @return
     */
    public ArrayList<String> getAllCourseNames() throws SQLException, ClassNotFoundException {
        Connection databaseConnection = Database.getDatabaseConnection();
        PreparedStatement getAllCourseNames = databaseConnection.prepareStatement("SELECT name FROM courses ");
        ResultSet courseNameResults =  getAllCourseNames.executeQuery();
        ArrayList<String> courseNameList = new ArrayList<>();

        while(courseNameResults.next()){


            courseNameList.add(courseNameResults.getString(1));




        }
        databaseConnection.close();
        return courseNameList;

    }

    /**Associates a teacher to a course, creating a class in that course
     *
     * @param userId
     * @param courseId
     */
    public void insertUserCourse(int userId, int courseId) throws SQLException, ClassNotFoundException {
        Connection connection = Database.getDatabaseConnection();
        PreparedStatement insertUserCourse = connection.prepareStatement("INSERT INTO usercourses(userid,courseid) VALUES(?,?)");
        insertUserCourse.setInt(1,userId);
        insertUserCourse.setInt(2,courseId);
        insertUserCourse.executeUpdate();
    }

    @Override
    public List<CourseBean> getAllCoursesForUser(int userId) throws SQLException, ClassNotFoundException {
        return super.getAllCoursesForUser(userId);
    }

    /**Gets the attendance for a certain course
     *
     * @param courseName
     * @return attendanceList
     */
    public List<AttendanceBean> getAttendanceListForCourse(String courseName) throws SQLException, ClassNotFoundException {
        Connection databaseConnection = Database.getDatabaseConnection();
        PreparedStatement getAllAttendanceRows = databaseConnection.prepareStatement("SELECT fname,lname,name,lessondate,attended FROM attendancetablelist WHERE name = ?");
        getAllAttendanceRows.setString(1,courseName);
        ArrayList<AttendanceBean> attendanceList = new ArrayList<>();
        ResultSet attendanceResults = getAllAttendanceRows.executeQuery();
        while(attendanceResults.next()){

            AttendanceBean result = new AttendanceBean();
            result.setfName(attendanceResults.getString(1));
            result.setlName(attendanceResults.getString(2));
            result.setCourseName(attendanceResults.getString(3));
            result.setLessonDate(attendanceResults.getDate(4));
            result.setAttended(attendanceResults.getBoolean(5));
            attendanceList.add(result);
        }
        return attendanceList;

    }

    @Override
    public List<AttendanceBean> getAttendanceForStudent(int userId) throws SQLException, ClassNotFoundException {
        return super.getAttendanceForStudent(userId);
    }

    @Override
    public AttendanceBean createAttendanceBean(ResultSet attendanceResult) throws SQLException {
        return super.createAttendanceBean(attendanceResult);
    }

    @Override
    public List<CourseBean> getAllCourses() throws SQLException, ClassNotFoundException {
        return super.getAllCourses();
    }

    /**Inserts the values held in a coursebean into the courses-table.
     * Returns the id of the inserted course-row on completion.
     * @param  course
     * @return int courseid
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public int insertCourse(CourseBean course) throws SQLException, ClassNotFoundException {
        Connection connection = Database.getDatabaseConnection();
        PreparedStatement insertCourse = connection.prepareStatement("INSERT INTO courses(name,yhp,description,startdate,enddate) VALUES(?,?,?,?,?)");
        insertCourse.setString(1,course.getName());
        insertCourse.setDouble(2,course.getYhp());
        insertCourse.setString(3,course.getDescription());
        insertCourse.setDate(4,course.getStartDate());
        insertCourse.setDate(5, course.getEndDate());
        insertCourse.executeUpdate();

        /*To input rows in the usercoursetable we need a userid for the teacher and courseid for the course - We need to get the courseid */
        PreparedStatement getCourseId = connection.prepareStatement("SELECT id FROM courses WHERE name = ?");
        getCourseId.setString(1,course.getName());
        ResultSet courseId = getCourseId.executeQuery();
        courseId.next();
        return courseId.getInt(1);
    }

    /**Creates a userbean from a resultset
     *
     * @param studentResult
     * @return
     */
    public UserBean createStudentListUserBean(ResultSet studentResult) throws SQLException {
        UserBean returnBean = new UserBean();

        returnBean.setfName(studentResult.getString(2));
        returnBean.setlName(studentResult.getString(3));
        returnBean.setCity(studentResult.getString(4));
        returnBean.setPhone(studentResult.getString(5));

        return returnBean;


    }

    @Override
    public boolean getParameterValidity(String parameter) {
        return super.getParameterValidity(parameter);
    }
}
