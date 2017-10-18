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

    /**
     *
     * @param userID The Id of the user
     * @param name The name of the user
     * @param email The email of the user
     * @param password The password of the user
     */
    public User(int userID, String name, String email, String password) {
        this.userID = userID;
        this.name = name;
        this.email = email;
        this.password = password;
        this.dateCreated = new Date();
    }

    /**
     *
     * @return the User Id of the user
     */
    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param userID the user Id of the user
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     *
     * @return the date the user was created
     */
    public Date getDateCreated() {
        return dateCreated;
    }

    /**
     *
     * @return the email of the user
     */
    public String getEmail() {
        return email;
    }

    /**
     *
     * @return the name of the User
     */
    public String getName() {
        return name;
    }

    /**
     *
     * @return the password of the user
     */
    public String getPassword() {
        return password;
    }

    /**
     *
     * @param dateCreated the date the user was created
     */
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    /**
     *
     * @param email the email of the user
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     *
     * @param name the name of the user
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     *
     * @param password the password of the user
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     *
     * @return All the journals the User has
     */
    public ArrayList<Journal> getJournals() {
        return journals;
    }
    
    /**
     * Adds a journal to the User
     *
     * @param journal the journal to be added
     */
    public void addJournal(Journal journal){
        journals.add(journal);
    }
    
    /**
     * Returns the selected Journal, if the journal is not found, it returns null
     * 
     * @param journalID the Id of the journal to be selected
     * @return the selected Journal, if the journal is not found, it returns null
     */
    public Journal getJournal(int journalID){
        for(Journal j : journals){
            if(j.getJournalID() == journalID){
                return j;
            }
        }
        return null;
    }

    public void setJournals(ArrayList<Journal> journals) {
        this.journals = journals;
    }
    
    
}
