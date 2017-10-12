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
 * @author Max
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
    private ArrayList<Comment> comments = new ArrayList<Comment>();
    
    @XmlElement(name="entryHis")
    private ArrayList<EntryHistory> history = new ArrayList<EntryHistory>();

    public Entry() {
    }

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

    public int getEntryID() {
        return entryID;
    }

    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    
    public int getJournalID() {
        return journalID;
    }

    public void setJournalID(int journalID) {
        this.journalID = journalID;
    }

    public String getContent() {
        return content;
    }
    
    /**
     * Gets the first 100 characters from them content, for summarisation purposes
     * 
     * @return The first 100 characters in the content
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

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }
    
    public String getTitleLowercase(){
        return title.toLowerCase();
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public Date getDateModified() {
        return dateModified;
    }

    public void setDateModified(Date dateModified) {
        this.dateModified = dateModified;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public ArrayList<Comment> getComments() {
        return comments;
    }

    public void setComments(ArrayList<Comment> comments) {
        this.comments = comments;
    }
    
    public void addComment(Comment comment){
        comments.add(comment);
    }

    public ArrayList<EntryHistory> getHistory() {
        return history;
    }
    
    public ArrayList<EntryHistory> getHistoryReverse(){
        ArrayList<EntryHistory> reverseHistory = new ArrayList<EntryHistory>();
        for(int i = getHistory().size() - 1; i >= 0; i--){
            reverseHistory.add(getHistory().get(i));
        }
        return reverseHistory;
    }

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
        oldEntry.setComments(this.comments);
        
        // Sets the new data to the entry object
        history.add(oldEntry);
        this.title = entry.getTitle();
        this.content = entry.getContent();
        this.flag = entry.getFlag();
        this.dateCreated = entry.getDateCreated();
        this.dateModified = new Date();
        this.comments = entry.getComments();
    }
    
    public void replaceEntry(Entry e){
        this.userID = e.getUserID();
        this.entryID = e.getEntryID();
        this.journalID = e.getJournalID();
        this.title = e.getTitle();
        this.content = e.getContent();
        this.flag = e.getFlag();
        this.dateCreated = e.getDateCreated();
        this.dateModified = e.getDateModified();
        this.comments = e.getComments();
        this.history = e.getHistory();
    }
}