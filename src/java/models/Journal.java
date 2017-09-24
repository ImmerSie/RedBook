/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.ArrayList;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
/**
 *
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="entries")
public class Journal {
    @XmlElement
    private int journalID;
    @XmlElement
    private int userID;
    @XmlElement
    private Date dateCreated;
    @XmlElement
    private Date lastModified;
    @XmlElement
    private String title;
    @XmlElement
    private String description;
    
    @XmlElement(name="entry")
    //private ArrayList<Entry> entries = new ArrayList<Entry>();
    private ArrayList<Entry> entries = new ArrayList<Entry>();
    
    public Journal() {
    }

    public Journal(int userID, int journalID, Date dateCreated, Date lastModified, String title, String description) {
        this.userID = userID;
        this.journalID = journalID;
        this.dateCreated = dateCreated;
        this.lastModified = lastModified;
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
        return lastModified;
    }

    public void setLastModified(Date lastModified) {
        this.lastModified = lastModified;
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
