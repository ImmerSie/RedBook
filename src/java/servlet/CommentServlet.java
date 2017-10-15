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
 *
 * @author Max
 */
public class CommentServlet extends HttpServlet{
    
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        
        ServletContext sc = req.getServletContext();
        
        CommentController commentApp = (CommentController) req.getSession().getAttribute("commentApp");
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        
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
        
        /*String userIDString = req.getParameter("userID");
        int userID = Integer.parseInt(userIDString);
        String journalIDString = req.getParameter("journalID");
        int journalID = Integer.parseInt(journalIDString);*/
        String entryIDString = req.getParameter("entryID");
        int entryID = Integer.parseInt(entryIDString);
        String content = req.getParameter("content");
        
        Entry entry = entryApp.getEntryByID(entryID);
        
        Comments entryComments = commentApp.getCommentsByEntry(entry.getUserID(), entry.getJournalID(), entryID);
        
        int commentID = commentApp.getNewCommentID(entryComments.getComments());
        
        Comment newComment = new Comment(entry.getUserID(), entry.getJournalID(), entryID, commentID, content);
        
        commentApp.addComment(newComment);
        
        try {
            commentApp.saveUsers();
        } catch (JAXBException ex) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        entryComments.add(newComment);
        
        String json = new Gson().toJson(entryComments);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
    }

    /**
     * Method that turns an entry into a download
     * 
     * <p> Method takes an entry identifier, retrieves the relevant entry, then calls the method to
     * generate the csv as a string. This string is then output to the client browser as a downloaded
     * attachment. </p>
     * 
     * @param req Contains the entryID, used to retrieve the relevant entry object
     * @param res Tells the browser that an attachment is being returned
     * @throws java.io.IOException 
     */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {

        ServletContext sc = req.getServletContext();
        
        CommentController commentApp = (CommentController) req.getSession().getAttribute("commentApp");
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        
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

        /*String userIDString = req.getParameter("userID");
        int userID = Integer.parseInt(userIDString);
        String journalIDString = req.getParameter("journalID");
        int journalID = Integer.parseInt(journalIDString);*/
        String entryIDString = req.getParameter("entryID");
        int entryID = Integer.parseInt(entryIDString);
        String content = req.getParameter("content");
        
        Entry entry = entryApp.getEntryByID(entryID);
        
        Comments entryComments = commentApp.getCommentsByEntry(entry.getUserID(), entry.getJournalID(), entryID);
        

        String json = new Gson().toJson(entryComments.getComments());
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
        
    }
}
