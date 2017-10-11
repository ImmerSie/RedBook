<%-- 
    Document   : viewJournal
    Created on : 14/09/2017, 8:55:41 PM
    Author     : Ramu
--%>

<%@page import="models.User"%>
<%@page import="models.Journal"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Journal</title>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
    </head>
    <body>
        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="TEST" />
        </div>  
        <%
            User user = (User) session.getAttribute("user");
        %>
        
        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="entries.jsp"> Dashboard </a></li>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <!-- Top navigation bar -->
        <nav role="main">
            <div id= "topNav">
                <ul>
                    <li><a href="logout.jsp"> Logout </a></li>
                    <li><img src="userIcon.png" id="userIcon" alt="User Icon"></li>
                    <li><div id="usersName"> <%= user.getName()%> </div></li>
                     <img src="RedLogo.png" class="logo" alt="Logo">
                </ul>
            </div>
        </nav>
        <!-- NOTE: This JSP page is no longer in use. Please see entries.jsp for further operation. -->
        <h1>View Entry</h1>
        <%
            String parameter = request.getParameter("id");
            if (parameter != null) {
                Journal journal = user.getJournal(Integer.parseInt(parameter));
                session.setAttribute("journal", journal);
            }
            Journal journal = (Journal) session.getAttribute("journal");
        %>
        <p><h3>Title: <%= journal.getTitle()%></h3></p>
    <p><h3>Content: <%= journal.getDescription()%></h3></p>
<p><h4>Date Created: <%= journal.getDateCreated()%></h4></p>
<p><h4>Date Modified: <%= journal.getLastModified()%></h4></p>
</body>
</html>
