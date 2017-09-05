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
 *
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="users")
public class Users implements Serializable{
    @XmlElement(name="user")
    private ArrayList<User> userList = new ArrayList<User>();

    public ArrayList<User> getUsers() {
        return userList;
    }

    public void addUser(User user){
        userList.add(user);
    }
    
    public User getUser(String email){
        for(User u : userList){
            if(u.getEmail().equals(email)){
                return u;
            }
        }
        return null;
    }
    
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
