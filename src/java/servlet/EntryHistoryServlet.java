/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.EntryController;
import controllers.EntryHistoryController;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import models.Entry;
import models.EntryHistory;

/**
 *
 * @author Max
 */
public class EntryHistoryServlet extends HttpServlet{
    
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        String changeTo = req.getParameter("changeTo");
        String entryID = req.getParameter("entryID");
        
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        EntryHistoryController entryHisApp = (EntryHistoryController) req.getSession().getAttribute("entryHisApp");
        Entry entry = entryApp.getEntryByID(Integer.parseInt(entryID));
        
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
            String title = req.getParameter("title");
            String content = req.getParameter("content");
            if(title != null && content != null){
                Entry newEntry = new Entry(entry.getUserID(), entry.getJournalID(), entry.getEntryID(), title, content, entry.getFlag(), entry.getDateCreated());
                entry.addToHistory(newEntry);
                entry = newEntry;
                try {  
                    entryApp.saveEntries();
                    entryHisApp.saveEntryHistory();
                } catch (JAXBException ex) {
                    Logger.getLogger(EntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        
        String json = new Gson().toJson(entry);

        
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

        // Takes parameter and retrieves the relevant Entry object from it.
        String entryID = req.getParameter("entryID");
     
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        Entry entry = entryApp.getEntryByID(Integer.parseInt(entryID));
        
        ArrayList<EntryHistory> entryHisList = entry.getHistoryReverse();

        String json = new Gson().toJson(entryHisList);

        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
        
    }
}
