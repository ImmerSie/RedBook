/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

/**
 * Data Application Object representing a comment on a journal entry.
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
public class Comment {
    @XmlElement
    private int userID;
    @XmlElement
    private int journalID;
    @XmlElement
    private int entryID;
    @XmlElement
    private int commentID;
    @XmlElement
    private String content;
    @XmlElement
    private Date dateCreated;

    public Comment() {
    }

    /**
     * Constructor for the Comment
     * 
     * @param userID The ID of the user
     * @param journalID The ID of the journal
     * @param entryID The ID of the entry
     * @param commentID The ID of the comment
     * @param content The actual content of the comment
     */
    public Comment(int userID, int journalID, int entryID, int commentID, String content) {
        this.userID = userID;
        this.journalID = journalID;
        this.entryID = entryID;
        this.commentID = commentID;
        this.dateCreated = new Date();
        this.content = content;
    }

    /**
     *
     * @return The comment ID of this comment
     */
    public int getCommentID() {
        return commentID;
    }

    /**
     *
     * @param commentID The id of this comment
     */
    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    /**
     *
     * @return The date created of the comment
     */
    public Date getDateCreated() {
        return dateCreated;
    }

    /**
     *
     * @return The content of this comment
     */
    public String getContent() {
        return content;
    }

    /**
     *
     * @param content The content of this comment
     */
    public void setContent(String content) {
        this.content = content;
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

    public int getEntryID() {
        return entryID;
    }

    public void setEntryID(int entryID) {
        this.entryID = entryID;
    }
    
    
    
}
