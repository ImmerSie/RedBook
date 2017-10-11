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
 */
public class Comment {
    private int commentID;
    private Date dateCreated;
    private String content;

    public Comment() {
    }

    /**
     * Constructor for the Comment
     * 
     * @param commentID The ID of the comment
     * @param dateCreated The date the comment was created
     * @param content The actual content of the comment
     */
    public Comment(int commentID, Date dateCreated, String content) {
        this.commentID = commentID;
        this.dateCreated = dateCreated;
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
    
}
