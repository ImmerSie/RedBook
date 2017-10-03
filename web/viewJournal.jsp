<%-- 
    Document   : viewJournal
    Created on : 14/09/2017, 8:55:41 PM
    Author     : Max
--%>

<%@page import="models.User"%>
<%@page import="models.Journal"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Journal</title>
    </head>
    <body>
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="TEST" />
        </div>  
        <%
            User user = (User) session.getAttribute("user");
            %>
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="entries.jsp"> Dashboard </a></li>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" class="icon"></li>
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        <h1>View Entry</h1>
        <% 
           String parameter = request.getParameter("id");
           if(parameter != null){
               Journal journal = user.getJournal(Integer.parseInt(parameter));
               session.setAttribute("journal", journal);
           }
           Journal journal = (Journal) session.getAttribute("journal");
        %>
        <p><h3>Title: <%= journal.getTitle()%></h3></p>
        <p><h3>Content: <%= journal.getDescription() %></h3></p>
        <p><h4>Date Created: <%= journal.getDateCreated()%></h4></p>
        <p><h4>Date Modified: <%= journal.getLastModified()%></h4></p>
      </body>
</html>
