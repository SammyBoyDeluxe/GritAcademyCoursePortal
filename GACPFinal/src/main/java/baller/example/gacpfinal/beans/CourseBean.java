package baller.example.gacpfinal.beans;


import java.io.Serializable;
import java.sql.Date;

/*Implementing the serializable interface makes sure we can convert object instances
into byte-stream format */
public class CourseBean implements Serializable {
    /*A java bean is very much like a POJO except that it has no-arg constructor and instead exposes its
    its attributes via getters/setters only and implements serializable
     */
    private int id;
    private String name;
    private double yhp;
    private String description;
    /*The dates shown below are sql-type Dates, enabling a smoother writing/reading process*/
    private Date startDate;
    private Date endDate;

    /* We insert an empty constructor explicitly to declare via javadocs the use
    and specifics of value-setting for the class
     */

    /**This JavaBean-object represents a course from the Gritacademy courses-portal.
     * One such bean contains the following attributes:
     * int id
     * String name
     * double yhp
     * String description (of course-content)
     * java.sql.Date startDate
     * java.sql.Date endDate
     */
    public CourseBean(){


    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getYhp() {
        return yhp;
    }

    public void setYhp(double yhp) {
        this.yhp = yhp;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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


    /**Represents the primary key id of the course in the courses-relation
     *
     * @return int id
     */
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}

