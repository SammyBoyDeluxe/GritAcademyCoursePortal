package baller.example.gacpfinal.beans;

import java.io.Serializable;
import java.sql.Date;

public class UserCourseBean implements Serializable {
    private int userId;
    private String userType;
    private String fName;
    private String lName;
    private String courseName;
    private double yhp;
    private Date startDate;
    private Date endDate;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getfName() {
        return fName;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public String getlName() {
        return lName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public double getYhp() {
        return yhp;
    }

    public void setYhp(double yhp) {
        this.yhp = yhp;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
