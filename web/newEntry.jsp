<%-- 
    Document   : newEntry
    Created on : 13/09/2017, 8:11:16 PM
    Author     : Sarah
--%>

<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"
        import="java.util.Date"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Entry</title>
        <!-- If a user is not logged in while trying to access this page, they are redirected to the login JSP page -->
        <%
            if(session.getAttribute("user")== null){
            response.sendRedirect("login.jsp");}
        %>
    </head>
    <body>  
        <a href="index.html">
            <img src="WhtLogo.png" class="logoutLogo" alt="Logo">
        </a>
        <%
            //Once the Journal Entry Form, from the createEntry JSP page is submitted, RedBook creates a new Entry Object
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
        %>
        <p><h3>New entry  <%= title%> successfully created.</h3></p>
        <p><h3>Click <a href="entries.jsp">here</a> to return to the journals page.</h3></p>

        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>
    </body>
</html>
