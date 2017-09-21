<%-- 
    Document   : newJournal
    Created on : 09/09/2017, 10:55:10 PM
    Author     : Max
--%>

<%@page import="controllers.JournalController"%>
<%@page import="models.User"
        import="models.Journal"
        import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Journal Created</title>
    </head>
    <body>
        <%
            if(session.getAttribute("journalApp") == null){
                String filePath2 = application.getRealPath("WEB-INF/journals.xml"); %>
                <jsp:useBean id="journalApp" class="controllers.JournalController" scope="session">
                    <jsp:setProperty name="journalApp" property="filePath" value="<%=filePath2%>"/>
                </jsp:useBean>
            <% }
            
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

            %><p>New journal  <%= title %> created!</p>
             <p>Click <a href="journals.jsp">here</a> to return to the journals page.</p>
    </body>
</html>
