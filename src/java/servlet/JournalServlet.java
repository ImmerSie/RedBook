/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.EntryController;
import controllers.JournalController;
import controllers.LoginController;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import models.Entry;
import models.Journal;
import models.User;

/**
 * Servlet for managing users journals (CRU)
 * 
 * @author Max
 */
public class JournalServlet extends HttpServlet{
    
    /**
     * Creates or updates a journals metadata
     * 
     * @param req The details of the journals metadata
     * @param res The newly modified/created journal
     * @throws java.io.IOException 
     */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        
        // Gets required fields
        ServletContext sc = req.getServletContext();
        
        JournalController journalApp = (JournalController) req.getSession().getAttribute("journalApp");
        LoginController userApp = (LoginController) sc.getAttribute("userApp");
        String userIDString = req.getParameter("userID");
        int userID = Integer.parseInt(userIDString);
        
        User user = userApp.getUserFromID(userID);
        
        // Instantiates journal application if required
        if(journalApp == null){
            journalApp = new JournalController();
            sc.setAttribute("journalApp", journalApp);
            String journalFilePath = sc.getRealPath("WEB-INF/journals.xml");
            try {
                journalApp.setFilePath(journalFilePath);
                sc.setAttribute("journalApp", journalApp);
            } catch (Exception ex) {
                Logger.getLogger(JournalServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        journalApp.setUser(user);

        // Gets new journal details
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String journalID = req.getParameter("journalID");
        Journal journal = null;
        
        // If journalID doesn't exist, that means it's a new journal
        if(journalID == null){
            journal = journalApp.createJournal(title, description);
        }
        else{
            journal = journalApp.updateJournal(Integer.parseInt(journalID), title, description);
        }
        try {
            journalApp.saveJournals();
        } catch (JAXBException ex) {
            Logger.getLogger(JournalServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        // Returns new journal
        String json = new Gson().toJson(journal);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
    }

    /**
     * Method that could be implemented to retrieve users journals
     * 
     * @param req Contains the userID
     * @param res The collection of journals for that user
     * @throws java.io.IOException 
     */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {

        JournalController journalApp = (JournalController) req.getSession().getAttribute("journalApp");
        
        
        //String json = new Gson().toJson(entry);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        //res.getWriter().write(json);
        //res.sendRedirect(entries.jsp);
        
    }
}
