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

/**
 * A slimmed version of the Entry DAO, representing the data needed to be persisted
 * to maintain an accurate record of an entry's history of modification.
 * 
 * @author Sarah
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class EntryHistory {
    @XmlElement
    private int entryHisID;
    @XmlElement
    private int entryID;
    @XmlElement
    private int journalID;
    @XmlElement
    private int userID;
    @XmlElement
    private String title;
    @XmlElement
    private String content;
    @XmlElement
    private Date dateModified;

    @XmlElement(name="comment")
    private ArrayList<Comment> comments = new ArrayList<Comment>();
    
    public EntryHistory() {
    }

    public EntryHistory(int entryHisID, int entryID, int journalID, int userID, String title, String content, Date dateModified) {
        this.entryHisID = entryHisID;
        this.entryID = entryID;
        this.journalID = journalID;
        this.userID = userID;
        this.title = title;
        this.content = content;
        this.dateModified = dateModified;
    }

    public int getEntryHisID() {
        return entryHisID;
    }

    public void setEntryHisID(int entryHisID) {
        this.entryHisID = entryHisID;
    }

    public int getEntryID() {
        return entryID;
    }

    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }

    public int getJournalID() {
        return journalID;
    }

    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDateModified() {
        return dateModified;
    }

    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    }

    public ArrayList<Comment> getComments() {
        return comments;
    }

    public void setComments(ArrayList<Comment> comments) {
        this.comments = comments;
    }
    
}
