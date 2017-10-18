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
 * Data Application Object representing an entry in entries.xml and
 * the root element in entriesHistory.xml file
 * 
 * @author Sarah
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="entriesHis")
public class Entry implements Serializable{
    @XmlElement
    private int userID;
    @XmlElement
    private int journalID;
    @XmlElement
    private int entryID;
    @XmlElement
    private String title;
    @XmlElement
    private String content;
    @XmlElement
    private String flag;
    @XmlElement
    private Date dateCreated;
    @XmlElement
    private Date dateModified;
    
    @XmlElement(name="comment")
    private Comments comments = new Comments();
    
    @XmlElement(name="entryHis")
    private ArrayList<EntryHistory> history = new ArrayList<EntryHistory>();

   
    public Entry() {
    }

    /**
     * The constructor of the Entry Model
     * 
     * @param userID The Id of the User creating the entry
     * @param journalID the Id of the journal where the entry exists
     * @param entryID The Id of the entry
     * @param title The title of the entry
     * @param content The content of the entry
     * @param flag The flag of the entry (If it is archived or not)
     * @param dateCreated The date the entry was created
     */
    public Entry(int userID, int journalID, int entryID, String title, String content, String flag, Date dateCreated) {
        this.userID = userID;
        this.entryID = entryID;
        this.journalID = journalID;
        this.title = title;
        this.content = content;
        this.flag = flag;
        this.dateCreated = dateCreated;
        this.dateModified = new Date();
    }

    /**
     *
     * @return The Id of the Entry
     */
    public int getEntryID() {
        return entryID;
    }

    /**
     *
     * @param entryID The Id of the Entry
     */
    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }

    /**
     *
     * @return the Id of the User who made the entry
     */
    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param userID the Id of the User who made the entry
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    /**
     *
     * @return the Id of the journal which the entry exists in
     */
    public int getJournalID() {
        return journalID;
    }

    /**
     *
     * @param journalID the Id of the journal which the entry exists in
     */
    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    /**
     *
     * @return The content of the Entry
     */
    public String getContent() {
        return content;
    }
    
    /**
     * Gets the first 100 characters from them content, for summarisation purposes
     * 
     * @return The first 100 characters in the content of the entry
     */
    public String getContentSnippet(){
        if(content.length() > 103){
            String snippet = content.substring(0, 100);
            return snippet + "...";
        }
        else{
            return content;
        }
    }

    /**
     *
     * @param content The content of the entry
     */
    public void setContent(String content) {
        this.content = content;
    }

    /**
     *
     * @return The title of the entry
     */
    public String getTitle() {
        return title;
    }
    
    /**
     *
     * @return The title in lower case format
     */
    public String getTitleLowercase(){
        return title.toLowerCase().trim();
    }

    /**
     *
     * @param title The title of the entry
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     *
     * @return the date Created of this entry
     */
    public Date getDateCreated() {
        return dateCreated;
    }

    /**
     *
     * @return the date modified of this entry
     */
    public Date getDateModified() {
        return dateModified;
    }

    /**
     *
     * @param dateModified the date modified of this entry
     */
    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    }

    /**
     *
     * @return The flag of the entry
     */
    public String getFlag() {
        return flag;
    }

    /**
     *
     * @param flag The flag of the entry
     */
    public void setFlag(String flag) {
        this.flag = flag;
    }

    /**
     *
     * @param dateCreated the date created of this entry
     */
    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    /**
     *
     * @return the comments relating to this entry
     */
    public Comments getComments() {
        return comments;
    }

    /**
     *
     * @param comments the comments relating to this entry
     */
    public void setComments(Comments comments) {
        this.comments = comments;
    }
    
    /**
     *
     * @param comment the comment relating to this entry
     */
    public void addComment(Comment comment){
        comments.add(comment);
    }

    /**
     *
     * @return the entry History of this Entry
     */
    public ArrayList<EntryHistory> getHistory() {
        return history;
    }
    
    /**
     * Returns the whole history of the entries in reverse chronological order
     * 
     * @return the history in reverse order
     */
    public ArrayList<EntryHistory> getHistoryReverse(){
        ArrayList<EntryHistory> reverseHistory = new ArrayList<EntryHistory>();
        for(int i = getHistory().size() - 1; i >= 0; i--){
            reverseHistory.add(getHistory().get(i));
        }
        return reverseHistory;
    }

    /**
     *
     * @param history the history of this entry
     */
    public void setHistory(ArrayList<EntryHistory> history) {
        this.history = history;
    }
    
    /**
     * Adds the old entry data to the entry history, setting the new data to the entry data
     * 
     * @param entry An object representing the new entry data
     */
    public void addToHistory(Entry entry){
        // Creates an id for the entry history object
        int newID = 0;
        if(history.size() > 0){
            int max = 0;
            for(EntryHistory e : this.getHistory()){
                if(e.getEntryHisID() > max){
                    max = e.getEntryHisID();
                }
            }
            newID = max + 1;
        }
        
        // Creates the entry history object with the old entry's data
        EntryHistory oldEntry = new EntryHistory(newID, this.entryID, this.journalID, this.userID, this.title, this.content, this.dateModified);
        oldEntry.setFlag(this.flag);
        
        // Sets the new data to the entry object
        history.add(oldEntry);
        this.title = entry.getTitle();
        this.content = entry.getContent();
        this.flag = entry.getFlag();
        this.dateCreated = entry.getDateCreated();
        this.dateModified = new Date();
        this.comments = entry.getComments();
    }
    
    /**
     *
     * @param entry The entry to replace this entry
     */
    public void replaceEntry(Entry entry){
        this.userID = entry.getUserID();
        this.entryID = entry.getEntryID();
        this.journalID = entry.getJournalID();
        this.title = entry.getTitle();
        this.content = entry.getContent();
        this.flag = entry.getFlag();
        this.dateCreated = entry.getDateCreated();
        this.dateModified = entry.getDateModified();
        this.comments = entry.getComments();
        this.history = entry.getHistory();
    }
}