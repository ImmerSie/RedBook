/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import controllers.EntryController;
import java.io.BufferedReader;
import static java.net.Proxy.Type.HTTP;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Journal;
import models.User;

public class HideEntryServlet extends HttpServlet {

	/**
	 * A simple HelloWorld Servlet
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
                ServletContext ctx = getServletContext(); 
                //EntryController entryApp = (EntryController) ctx.getAttribute("entryApp");
                StringBuffer jb = new StringBuffer();
                String line = null;
                try {
                  BufferedReader reader = req.getReader();
                  while ((line = reader.readLine()) != null)
                    jb.append(line);
                } catch (Exception e) { /*report an error*/ }

                String[] splitjb = jb.toString().split("\"");
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
		res.setContentType("text/html");
		res.getWriter().write("Hello World!");
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws java.io.IOException {
		doPost(req, res);
	}
}
