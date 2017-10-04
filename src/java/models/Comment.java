/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.util.Date;

/**
 * Data Application Object representing a comment on a journal entry.
 * 
 * @author Max
 */
public class Comment {
    private int commentID;
    private Date dateCreated;
    private String content;

    public Comment() {
    }

    public Comment(int commentID, Date dateCreated, String content) {
        this.commentID = commentID;
        this.dateCreated = dateCreated;
        this.content = content;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
    
}
