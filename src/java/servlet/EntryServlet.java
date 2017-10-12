/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controllers.EntryController;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import controllers.EntryHistoryController;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletOutputStream;
import javax.xml.bind.JAXBException;
import models.Entry;


/**
 * Allows the user to get a .csv file containing the data for an entry
 * 
 * @author Sarah
 */
public class EntryServlet extends HttpServlet {

    /**
     * Method that turns an entry into a comma-separated set of values
     * 
     * @param entry the entry which the data will be retrieved from
     * @return a string of comma-separated values, containing the entry data
     */
    private String generateCSV(Entry entry) {
        StringBuilder sb = new StringBuilder();
        
        // Creates the columns labels
        sb.append("id");
        sb.append(',');
        sb.append("title");
        sb.append(',');
        sb.append("content");
        sb.append(',');
        sb.append("date created");
        sb.append(',');
        sb.append("date modified");
        sb.append(',');
        sb.append("status");
        sb.append('\n');

        // Removes any newline characters from the content
        String content = entry.getContent();
        content = content.replaceAll("\n", "");
        
        // Turns the actual data in the entry into .csv
        sb.append(entry.getEntryID());
        sb.append(',');
        sb.append(entry.getTitle());
        sb.append(',');
        sb.append(content);
        sb.append(',');
        sb.append(entry.getDateCreated());
        sb.append(',');
        sb.append(entry.getDateModified());
        sb.append(',');
        sb.append(entry.getFlag());
        sb.append('\n');

        return sb.toString();
    }

    /**
     * Updates the entry object
     * 
     * @param req Contains the necessary data to get the entry (entryID)
     * @param res Contains the entry data, in JSON format
     * @throws java.io.IOException 
     */
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws java.io.IOException {
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String dateModified = req.getParameter("dateModified");
        
        Entry entry = entryApp.createEntry(title, content, new Date());
        try {
            entryApp.saveEntries();
        } catch (JAXBException ex) {
            Logger.getLogger(EntryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        String json = new Gson().toJson(entry);
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");
        res.getWriter().write(json);
        //res.sendRedirect(entries.jsp);
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
        String noDownload = req.getParameter("noDownload");
     
        EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
        Entry entry = entryApp.getEntryByID(Integer.parseInt(entryID));

        if(noDownload == null){
            // Method call to generate CSV
            String file = generateCSV(entry);

            //Tells the client browser that a download is being returned.
            res.setContentType("application/octet-stream");
            res.setHeader("Content-Disposition", "attachment; filename=" + entry.getTitle() + ".csv");

            // Takes generated CSV string, and turns it into the download stream
            StringBuffer sb = new StringBuffer(file);
            InputStream in = new ByteArrayInputStream(sb.toString().getBytes("UTF-8"));
            ServletOutputStream out = res.getOutputStream();

            // Copy binary contect to output stream
            byte[] outputByte = new byte[4096];
            while (in.read(outputByte, 0, 4096) != -1) {
                out.write(outputByte, 0, 4096);
            }

            // Cleans up and closes streams
            in.close();
            out.flush();
            out.close();
        }
        else{
            String json = new Gson().toJson(entry);

            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(json);
        }
        
    }
}
