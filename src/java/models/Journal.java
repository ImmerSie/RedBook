/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.ArrayList;
import java.util.Date;
/**
 *
 * @author Max
 */
public class Journal {
    private int journalID;
    private Date dateCreated;
    private Date lastModified;
    private String title;
    private String description;
    private ArrayList<Entry> entries = new ArrayList<Entry>();

    public Journal() {
    }

    public Journal(int journalID, Date dateCreated, Date lastModified, String title, String description) {
        this.journalID = journalID;
        this.dateCreated = dateCreated;
        this.lastModified = lastModified;
        this.title = title;
        this.description = description;
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

    public void setEntries(ArrayList<Entry> entries) {
        this.entries = entries;
    }
     
    public void addEntry(Entry entry){
        entries.add(entry);
    }
}
