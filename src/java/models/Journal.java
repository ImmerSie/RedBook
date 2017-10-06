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
 * Data Application Object representing a journal in journals.xml and
 * the root object in entries.xml file
 * 
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="entries")
public class Journal implements Serializable{
    @XmlElement
    private int userID;
    @XmlElement
    private int journalID;
    @XmlElement
    private Date dateCreated;
    @XmlElement
    private Date dateModified;
    @XmlElement
    private String title;
    @XmlElement
    private String description;
    
    @XmlElement(name="entry")
    private ArrayList<Entry> entries = new ArrayList<Entry>();
    
    public Journal() {
    }

    public Journal(int userID, int journalID, Date dateCreated, Date lastModified, String title, String description) {
        this.userID = userID;
        this.journalID = journalID;
        this.dateCreated = dateCreated;
        this.dateModified = lastModified;
        this.title = title;
        this.description = description;
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

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getLastModified() {
        return dateModified;
    }

    public void setLastModified(Date lastModified) {
        this.dateModified = lastModified;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getJournalID() {
        return journalID;
    }

    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    public ArrayList<Entry> getEntries() {
        return entries;
    }
    
    public Entry getEntry(int entryID){
        for(Entry e : this.getEntries()){
            if(e.getEntryID() == entryID){
                return e;
            }
        }
        return null;
    }

    public void setEntries(ArrayList<Entry> entries) {
        this.entries = entries;
    }
     
    public void addEntry(Entry entry){
        entries.add(entry);
    }
}
