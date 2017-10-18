/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.EntryController;
import controllers.EntryHistoryController;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import models.Entry;
import models.EntryHistory;

/**
 * Performs update on an entry, and retrieving an entry's history
 * 
 * @author Max
 */
public class EntryHistoryServlet extends HttpServlet{
    
    /**
     * Updates an entry (generating an new entry history object)
     * 
     * @param req The new entry details
     * @param res The updated entry
     * @throws java.io.IOException 
     */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        
        // Gets necessary fields
        String changeTo = req.getParameter("changeTo");
        String entryID = req.getParameter("entryID");
        
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        EntryHistoryController entryHisApp = (EntryHistoryController) req.getSession().getAttribute("entryHisApp");
        Entry entry = entryApp.getEntryByID(Integer.parseInt(entryID));
        
        // Handles changes to entry visibility, else updates entry
        if(changeTo != null){
            if(changeTo.equals("hidden")){
                entryApp.hideEntry(entry);
            }
            else if(changeTo.equals("deleted")){
                entryApp.deleteEntry(entry);
            }
            else{
                entryApp.visibleEntry(entry);
            }
            try {
                entryApp.saveEntries();
            } catch (JAXBException ex) {
                Logger.getLogger(EntryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        else{
            // Updates entry title/content
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            if(title != null && content != null){
                // Creates new history object
                Entry newEntry = new Entry(entry.getUserID(), entry.getJournalID(), entry.getEntryID(), title, content, entry.getFlag(), entry.getDateCreated());
                entry.addToHistory(newEntry);
                entry = newEntry;
                entryApp.getJournal().setLastModified(new Date());
                try {  
                    entryApp.saveEntries();
                    entryHisApp.saveEntryHistory();
                } catch (JAXBException ex) {
                    Logger.getLogger(EntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
                
        // Returns updated entry object
        String json = new Gson().toJson(entry);
        
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
    }

    /**
     * Method that gets all relevant history for a given entry
     * 
     * @param req Contains the entryID, used to retrieve the relevant history objects
     * @param res A collection of all the history objects
     * @throws java.io.IOException 
     */
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {

        // Takes parameter and retrieves the relevant Entry object from it.
        String entryID = req.getParameter("entryID");
     
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        Entry entry = entryApp.getEntryByID(Integer.parseInt(entryID));
        
        // Gets list of relevant entry history objects, and returns it
        ArrayList<EntryHistory> entryHisList = entry.getHistoryReverse();

        String json = new Gson().toJson(entryHisList);

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
        
    }
}
