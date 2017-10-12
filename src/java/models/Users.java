/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.ArrayList;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Data Application Object, representing a collection of users.
 * 
 * <p>This object maps to the root element in the users.xml file. </p>
 * 
 * @author Sarah
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="users")
public class Users implements Serializable{
    @XmlElement(name="user")
    private ArrayList<User> userList = new ArrayList<User>();

    /**
     *
     * @return
     */
    public ArrayList<User> getUsers() {
        return userList;
    }

    /**
     * Adds a user to the object list
     * 
     * @param user The user object to be added
     */
    public void addUser(User user){
        userList.add(user);
    }
    
    /**
     * Gets a user based on their email
     * 
     * @param email The email address that can uniquely identify a user
     * @return The user uniquely identified by the email
     */
    public User getUser(String email){
        for(User u : userList){
            if(u.getEmail().equals(email)){
                return u;
            }
        }
        return null;
    }
    
    /**
     * Gets the user object identified by the input email and password
     * 
     * @param email The email input by the user
     * @param password The password input by the user
     * @return The user associated with that email
     */
    public User login(String email, String password){
        User user = this.getUser(email);
        if(user != null && user.getPassword().equals(password)){
            return user;
        }
        else{
            return null;
        }
    }
}
