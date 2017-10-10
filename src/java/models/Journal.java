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
 * Data Application Object representing a journal in journals.xml and the root
 * object in entries.xml file
 *
 * @author Max
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "entries")
public class Journal {

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

    @XmlElement(name = "entry")
    private ArrayList<Entry> entries = new ArrayList<Entry>();

    public Journal() {
    }

    /**
     * Constructor for the Journal Object
     * 
     * @param userID - The UserID of the person who made this journal
     * @param journalID - The JorunalID of this journal
     * @param dateCreated - The date the journal was created
     * @param lastModified - The last modified date of the journal
     * @param title - The title of the Journal
     * @param description - The description of the Journal
     */
    public Journal(int userID, int journalID, Date dateCreated, Date lastModified, String title, String description) {
        this.userID = userID;
        this.journalID = journalID;
        this.dateCreated = dateCreated;
        this.dateModified = lastModified;
        this.title = title;
        this.description = description;
    }

    /**
     *
     * @return the User ID of this journal
     */
    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param userID the User ID of this journal
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     *
     * @return The date the journal was created
     */
    public Date getDateCreated() {
        return dateCreated;
    }

    /**
     *
     * @param dateCreated The date the journal was created
     */
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    /**
     *
     * @return The description of the Journal
     */
    public String getDescription() {
        return description;
    }

    /**
     *
     * @param description The description of the Journal
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     *
     * @return the last modified date of the journal
     */
    public Date getLastModified() {
        return dateModified;
    }

    /**
     *
     * @param lastModified the last modified date of the journal
     */
    public void setLastModified(Date lastModified) {
        this.dateModified = lastModified;
    }

    /**
     *
     * @return The title of the journal
     */
    public String getTitle() {
        return title;
    }

    /**
     *
     * @param title The title of the journal
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     *
     * @return The ID of this journal
     */
    public int getJournalID() {
        return journalID;
    }

    /**
     *
     * @param journalID The ID of this journal
     */
    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    /**
     *
     * @return All the entries in this journal
     */
    public ArrayList<Entry> getEntries() {
        return entries;
    }

    /**
     * Returns a specific entry of this journal
     *
     * @param entryID The id of the entry which is to be returned
     * @return The chosen entry, returns null if no entries found with that id
     */
    public Entry getEntry(int entryID) {
        for (Entry entry : this.getEntries()) {
            if (entry.getEntryID() == entryID) {
                return entry;
            }
        }
        return null;
    }

    /**
     *
     * @param entries the entries of this entry
     */
    public void setEntries(ArrayList<Entry> entries) {
        this.entries = entries;
    }

    /**
     * Adds an Entry to this Journal
     * 
     * @param entry the entry to be added
     */
    public void addEntry(Entry entry) {
        entries.add(entry);
    }
}
