<%-- 
    Document   : viewEntry
    Created on : 14/09/2017, 8:24:52 PM
    Author     : Max
--%>

<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Entry</title>
    </head>
    <body>
        <h1>View Entry</h1>
        <% Journal journal = (Journal) session.getAttribute("journal");
           String parameter = request.getParameter("id");
           if(parameter != null){
               Entry entry = journal.getEntry(Integer.parseInt(parameter));
               session.setAttribute("entry", entry);
           }
           Entry entry = (Entry) session.getAttribute("entry");
        %>
        <p>Title: <%= entry.getTitle()%></p>
        <p>Content: <%= entry.getContent()%></p>
        <p>Flag: <%= entry.getFlag()%></p>
        <p>Date Created: <%= entry.getDateCreated()%></p>
        <p>Date Modified: <%= entry.getDateModified()%></p>
  
        </br><a href="entries.jsp">Return to Entries</a>
    </body>
</html>
