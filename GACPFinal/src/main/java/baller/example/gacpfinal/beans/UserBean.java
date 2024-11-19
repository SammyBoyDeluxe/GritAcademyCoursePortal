package baller.example.gacpfinal.beans;

import java.io.Serializable;

public class UserBean implements Serializable {
    private int id;
    private String fName;
    private String lName;
    private String city;
    private String phone;
    private String usertype;

    /**This class represents a row in the userlist, students or teachers-view
     * Attributes: (id INT PK, fname VARCHAR(200), lnameVARCHAR(200), city(VARCHAR(200)), phone(VARCHAR(10))(Unique identifier-> Secondary pk), usertype (ENUM:Student/Teacher)),
     *
     */
    public UserBean() {
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }
}
