/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import com.google.gson.Gson;
import controllers.EntryController;
import java.io.BufferedReader;
import static java.net.Proxy.Type.HTTP;
import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Journal;
import models.User;
import models.Entry;

public class HideEntryServlet extends HttpServlet {

        private ArrayList<Entry> getEntriesBySortFilter(EntryController entryApp, String filter, String sort){
            ArrayList<Entry> entries = null;
            if(filter.equals("hidden")){
                entries = entryApp.getHiddenEntries();
            }
            else if(filter.equals("all")){
                entries = entryApp.getAllEntries();
            }
            else{
                entries = entryApp.getNonHiddenEntries();
            }
            
            if(sort.equals("byTitle")){
                entries = entryApp.sortByTitle(entries);
            }
            else if(sort.equals("byTitleDesc")){
                entries = entryApp.sortByTitleDesc(entries);
            }
            
            return entries;
        }
    
	/**
	 * A simple HelloWorld Servlet
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
                //ServletContext ctx = getServletContext(); 
                //EntryController entryApp = (EntryController) ctx.getAttribute("entryApp");
                
                String json = req.getParameter("json");                

                String[] splitjb = json.split("\"");
                int[] entryIDs = new int[(splitjb.length - 1)/2];
                int j = 0;
                for(int i = 1; i < splitjb.length; i = i + 2){
                    entryIDs[j] = Integer.parseInt(splitjb[i]);
                    j++;
                }
                User user = (User) req.getSession().getAttribute("user");
                Journal journal = (Journal) req.getSession().getAttribute("journal");
                EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
                for(int id : entryIDs){
                    entryApp.hideEntry(id);
                }
                try{
                    entryApp.saveEntries();
                }    
                catch(Exception e){
                    
                }
                ArrayList<Entry> entries = null;
                
                String sorting = req.getParameter("sorting");
                String filter = req.getParameter("filter");
                entries = getEntriesBySortFilter(entryApp, filter, sorting);
                
                String responseJson = new Gson().toJson(entries);
                
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(responseJson);
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
		
                EntryController entryApp = (EntryController) req.getSession().getAttribute("entryApp");
                ArrayList<Entry> entries = null;
                
                String sorting = req.getParameter("sorting");
                String filter = req.getParameter("filter");
                entries = getEntriesBySortFilter(entryApp, filter, sorting);
                
                String json = new Gson().toJson(entries);
                
                res.setContentType("application/json");
                res.setCharacterEncoding("UTF-8");
                res.getWriter().write(json);
	}
       
}
