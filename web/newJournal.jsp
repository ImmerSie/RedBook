<%-- 
    Document   : newJournal
    Created on : 09/09/2017, 10:55:10 PM
    Author     : Max
--%>

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
            String filePath = application.getRealPath("WEB-INF/journals.xml");
        %>
        <jsp:useBean id="journals" class="controllers.JournalController" scope="application">
            <jsp:setProperty name="journals" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <%
            User user = (User) session.getAttribute("user");
            journals.setUser(user);
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int userID = user.getUserID();
            int journalID = journals.getNewJournalID();
            Date dateCreated = new Date();
            Date dateModified = new Date();
            Journal journal = new Journal(userID, journalID, dateCreated, dateModified, title, description);
            user.addJournal(journal);
            journals.saveJournals();

            %><p>New journal  <%= title %> created!</p>
             <p>Click <a href="journals.jsp">here</a> to return to the journals page.</p>
    </body>
</html>
