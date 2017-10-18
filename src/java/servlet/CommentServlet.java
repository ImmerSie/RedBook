/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.CommentController;
import controllers.EntryController;
import controllers.JournalController;
import controllers.LoginController;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import models.Comment;
import models.Comments;
import models.Entry;
import models.Journal;
import models.User;

/**
 * Servlet that handles the comments for an entry
 * 
 * @author Max
 */
public class CommentServlet extends HttpServlet{
    
    /**
     * Method that creates a new comment for an entry object
     * 
     * @param req The details of the new comment
     * @param res Returns the new comment
     * @throws java.io.IOException 
     */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        
        // Gets required fields
        ServletContext sc = req.getServletContext();
        
        CommentController commentApp = (CommentController) req.getSession().getAttribute("commentApp");
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        
        // Instantiates comment application if it doesn't already exist
        if(commentApp == null){
            commentApp = new CommentController();
            sc.setAttribute("commentApp", commentApp);
            String commentFilePath = sc.getRealPath("WEB-INF/comments.xml");
            try {
                commentApp.setFilePath(commentFilePath);
                sc.setAttribute("commentApp", commentApp);
            } catch (Exception ex) {
                Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        // Gets the entry from the entryID
        String entryIDString = req.getParameter("entryID");
        int entryID = Integer.parseInt(entryIDString);
        String content = req.getParameter("content");
        
        Entry entry = entryApp.getEntryByID(entryID);
        Comments entryComments = commentApp.getCommentsByEntry(entry.getUserID(), entry.getJournalID(), entryID);
        
        // Creates the new comment object and saves it
        int commentID = commentApp.getNewCommentID(entryComments.getComments());
        Comment newComment = new Comment(entry.getUserID(), entry.getJournalID(), entryID, commentID, content);
        
        commentApp.addComment(newComment);
        
        try {
            commentApp.saveUsers();
        } catch (JAXBException ex) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        entryComments.add(newComment);
        
        // Returns all the comments for the entry
        String json = new Gson().toJson(entryComments);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
    }

    /**
     * Method that turns gets all the comments for an entry
     * 
     * @param req Contains the entryID, used to retrieve the relevant entry object
     * @param res The collection of comments for an entry
     * @throws java.io.IOException 
     */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {

        // Gets necessary fields
        ServletContext sc = req.getServletContext();
        
        CommentController commentApp = (CommentController) req.getSession().getAttribute("commentApp");
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        
        // Instantiates comment app if it hasn't already been made
        if(commentApp == null){
            commentApp = new CommentController();
            sc.setAttribute("commentApp", commentApp);
            String commentFilePath = sc.getRealPath("WEB-INF/comments.xml");
            try {
                commentApp.setFilePath(commentFilePath);
                sc.setAttribute("commentApp", commentApp);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // Gets entry from entryID
        String entryIDString = req.getParameter("entryID");
        int entryID = Integer.parseInt(entryIDString);
        String content = req.getParameter("content");
        
        Entry entry = entryApp.getEntryByID(entryID);
        
        // Gets and returns all comments for that entry
        Comments entryComments = commentApp.getCommentsByEntry(entry.getUserID(), entry.getJournalID(), entryID);
        
        String json = new Gson().toJson(entryComments.getComments());
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
        
    }
}
