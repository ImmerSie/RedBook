/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.EntryController;
import java.util.ArrayList;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Journal;
import models.User;
import models.Entry;

/**
 * Allows mass entry modification, and fetching of entries by attribute
 * 
 * @author Sarah
 */
public class HideEntryServlet extends HttpServlet {

        /**
         * Creates a list of entries, ordered by a sorting parameter
         * 
         * @param entryApp The entry application in context
         * @param filter The current filter selected (hidden, visible, etc)
         * @param sort The parameter in which the entry list is sorted by (title, content, date, etc)
         * @return The generated and sorted list of entries
         */
        private ArrayList<Entry> getEntriesBySortFilter(EntryController entryApp, String filter, String sort){
            ArrayList<Entry> entries = null;
            
            // Perform the filtering by flag
            if(filter.equals("hidden")){
                entries = entryApp.getHiddenEntries();
            }
            else if(filter.equals("deleted")){
                entries = entryApp.getDeletedEntries();
            }
            else if(filter.equals("all")){
                entries = entryApp.getAllEntries();
            }
            else{
                entries = entryApp.getVisibleEntries();
            }
            
            // Performs the sorting of the list
            if(sort.equals("byTitle")){
                entries = entryApp.sortByTitle(entries);
            }
            else if(sort.equals("byTitleDesc")){
                entries = entryApp.sortByTitleDesc(entries);
            }
            else if(sort.equals("byDate")){
                entries = entryApp.sortByDate(entries);
            }
            
            return entries;
        }
    
	/**
         * Saves the selected entries, passed from the ajax call
         * 
         * @param req Contains the data making up the selected entries
         * @param res Contains the new version of the entries list
         * @throws java.io.IOException 
         */
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
                
                String json = req.getParameter("json");                

                // Creates an array of entryID's that have had their status modified
                String[] splitjb = json.split("\"");
                int[] entryIDs = new int[(splitjb.length - 1)/2];
                int j = 0;
                for(int i = 1; i < splitjb.length; i = i + 2){
                    entryIDs[j] = Integer.parseInt(splitjb[i]);
                    j++;
                }
                
                // Goes through the list of id's hiding the corresponding entry
                User user = (User) req.getSession().getAttribute("user");
                Journal journal = (Journal) req.getSession().getAttribute("journal");
                EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
                for(int id : entryIDs){
                    entryApp.changeEntryVisibility(id);
                }
                try{
                    entryApp.saveEntries();
                }    
                catch(Exception e){
                    
                }
                
                // Creates the list of newly modified entries from sort/filter parameters
                ArrayList<Entry> entries = null;
                
                String sorting = req.getParameter("sorting");
                String filter = req.getParameter("filter");
                entries = getEntriesBySortFilter(entryApp, filter, sorting);
                
                // Turns list to JSON and adds it to the response data
                String responseJson = new Gson().toJson(entries);
                
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(responseJson);
	}

        /**
         * Retrieves the list of entries, according to sorting and filtering parameters
         * 
         * @param req The sorting and filtering parameters
         * @param res The JSON list of entries created
         * @throws java.io.IOException 
         */
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
		
            // Gets list of entries from filtering/sorting parameters
            EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
            ArrayList<Entry> entries = null;

            String sorting = req.getParameter("sorting");
            String filter = req.getParameter("filter");
            entries = getEntriesBySortFilter(entryApp, filter, sorting);

            // Turns list of entries into JSON and adds it to the response
            String json = new Gson().toJson(entries);

            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(json);
	}
       
}