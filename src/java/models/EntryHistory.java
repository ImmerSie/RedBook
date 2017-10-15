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
    @XmlElement
    private String flag;
    
  
    public EntryHistory() {
    }

    /**
     * Constructor of the Entry History
     * 
     * @param entryHisID The ID of the specific Entry History
     * @param entryID The Id of the entry, the entry history is relating to
     * @param journalID The id of the journal the Entry history is relating to
     * @param userID The id of the user the entry history is relating to
     * @param title The title of this entry history
     * @param content The content of this entry history
     * @param dateModified The date this entry history was created (modifying the original entry)
     */
    public EntryHistory(int entryHisID, int entryID, int journalID, int userID, String title, String content, Date dateModified) {
        this.entryHisID = entryHisID;
        this.entryID = entryID;
        this.journalID = journalID;
        this.userID = userID;
        this.title = title;
        this.content = content;
        this.dateModified = dateModified;
    }

    /**
     *
     * @return the id of the entry history
     */
    public int getEntryHisID() {
        return entryHisID;
    }

    /**
     *
     * @param entryHisID the id of the entry history
     */
    public void setEntryHisID(int entryHisID) {
        this.entryHisID = entryHisID;
    }

    /**
     *
     * @return The entry this entry history is relating to
     */
    public int getEntryID() {
        return entryID;
    }

    /**
     *
     * @param entryID  The entry this entry history is relating to
     */
    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }

    /**
     *
     * @return The journal this entry history is relating to
     */
    public int getJournalID() {
        return journalID;
    }

    /**
     *
     * @param journalID The journal ID which this entry history is relating to
     */
    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    /**
     *
     * @return The UserId who created this entry history
     */
    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param userID The UserId who created this entry history
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     *
     * @return The title of the entry History
     */
    public String getTitle() {
        return title;
    }

    /**
     *
     * @param title The title of the entry History
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     *
     * @return The Content of the entry History
     */
    public String getContent() {
        return content;
    }

    /**
     *
     * @param content The Content of the entry History
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     *
     * @return The Date modified of the Entry History
     */
    public Date getDateModified() {
        return dateModified;
    }

    /**
     *
     * @param dateModified The Date modified of the Entry History
     */
    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }
 
    
}
