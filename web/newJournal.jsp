<%-- 
    Document   : newJournal
    Created on : 09/09/2017, 10:55:10 PM
    Author     : Andy
--%>

<%@page import="controllers.JournalController"%>
<%@page import="models.User"
        import="models.Journal"
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
        <title>Journal Created</title>
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
        <!-- Setting the file path for the XML file which would contain the data of the user's journals -->
        <%
            if (session.getAttribute("journalApp") == null) {
                String filePath2 = application.getRealPath("WEB-INF/journals.xml");
                %>
                <!-- A JavaBean will allow access to getter/setter methods and serializable objects -->
                <jsp:useBean id="journalApp" class="controllers.JournalController" scope="session">
                    <jsp:setProperty name="journalApp" property="filePath" value="<%=filePath2%>"/>
                </jsp:useBean>
            <% }
            //Once the Journal Form, from the createJournal JSP page, is submitted, RedBook creates a new Journal Object and updates the XML file with the journal data
            JournalController journalApp = (JournalController) session.getAttribute("journalApp");
            User user = (User) session.getAttribute("user");
            journalApp.setUser(user);
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int userID = user.getUserID();
            int journalID = journalApp.getNewJournalID();
            Date dateCreated = new Date();
            Date dateModified = new Date();
            Journal journal = new Journal(userID, journalID, dateCreated, dateModified, title, description);
            user.addJournal(journal);
            journalApp.saveJournals();
        %>
        <p><h3>New journal  <%= title%> created!</h3></p>
        <p><h3>Redirecting you to the journals page... </h3></p>
        <!-- After creating a journal, user is redirected back to the journals JSP page -->
        <%  
            String redirectURL = "journals.jsp";
            response.sendRedirect(redirectURL);
        %>

        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 
    </body>
</html>
