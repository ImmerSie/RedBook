/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * Data Application Object, representing a user in the users.xml file
 * and the root element in the journals.xml file
 * 
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="journals")
public class User implements Serializable{
    @XmlElement
    private int userID;
    @XmlElement
    private String name;
    @XmlElement
    private String email;
    @XmlElement
    private String password;
    @XmlElement
    private Date dateCreated;
    
    @XmlElement(name="journal")
    private ArrayList<Journal> journals = new ArrayList<Journal>();
    public User() {
    }

    public User(int userID, String name, String email, String password) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.password = password;
        this.dateCreated = new Date();
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getPassword() {
        return password;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public ArrayList<Journal> getJournals() {
        return journals;
    }
    
    public void addJournal(Journal journal){
        journals.add(journal);
    }
    
    public Journal getJournal(int journalID){
        for(Journal j : journals){
            if(j.getJournalID() == journalID){
                return j;
            }
        }
        return null;
    }
}
