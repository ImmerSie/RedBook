<%-- 
    Document   : newEntry
    Created on : 13/09/2017, 8:11:16 PM
    Author     : Max
--%>

<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"
        import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Entry</title>
    </head>
    <body>
        <%
            EntryController entryApp = (EntryController) session.getAttribute("entryApp");
            User user = (User) session.getAttribute("user");
            Journal journal = (Journal) session.getAttribute("journal");
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            int userID = user.getUserID();
            int journalID = journal.getJournalID();
            int entryID = entryApp.getNewEntryID();
            Date dateCreated = new Date();
            Date dateModified = new Date();
            Entry entry = new Entry(userID, journalID, entryID, title, content, "visible", dateModified);
            journal.addEntry(entry);
            entryApp.saveEntries();

            %><p>New entry  <%= title %> successfully created.</p>
             <p>Click <a href="entries.jsp">here</a> to return to the journals page.</p>
    </body>
</html>
