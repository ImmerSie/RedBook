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
public class Entry {
    private int entryID;
    private int journalID;
    private String title;
    private String content;
    private String flag;
    private Date dateCreated;
    private Date dateModified;
    private ArrayList<Comment> comments = new ArrayList<Comment>();
    private ArrayList<Entry> history = new ArrayList<Entry>();

    public Entry() {
    }

    public Entry(int journalID, int entryID, String title, String content, String flag, Date dateCreated) {
        this.entryID = entryID;
        this.journalID = journalID;
        this.title = title;
        this.content = content;
        this.flag = flag;
        this.dateCreated = this.dateCreated;
        this.dateModified = new Date();
    }

    public int getEntryID() {
        return entryID;
    }

    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }

    public int getUserID() {
        return journalID;
    }

    public void setUserID(int userID) {
        this.journalID = userID;
    }
    
    

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
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

    public ArrayList<Entry> getHistory() {
        return history;
    }

    public void setHistory(ArrayList<Entry> history) {
        this.history = history;
    }
    
    public void addToHistory(Entry entry){
        int newID = 0;
        if(history.size() > 0){
            int lastID = history.get(history.size() - 1).getEntryID();
            newID = lastID + 1;
        }
        Entry oldEntry = new Entry(this.journalID, newID, this.title, this.content, this.flag, this.dateCreated);
        oldEntry.setComments(this.comments);
        oldEntry.setHistory(this.history);
        
        history.add(oldEntry);
        this.title = entry.getTitle();
        this.content = entry.getContent();
        this.flag = entry.getFlag();
        this.dateCreated = entry.getDateCreated();
        this.dateModified = new Date();
        this.comments = new ArrayList<Comment>();
    }
}
