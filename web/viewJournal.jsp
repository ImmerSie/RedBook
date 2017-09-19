<%-- 
    Document   : viewJournal
    Created on : 14/09/2017, 8:55:41 PM
    Author     : Max
--%>

<%@page import="models.User"%>
<%@page import="models.Journal"%>
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
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="entries.jsp"> Dashboard </a></li>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="index.html"> Logout </a></li>
                <li><img src="userIcon.png" class="icon"></li>
                <li><div id="usersName"> insert users name here </div></li>
                <a href="index.html">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        <h1>View Entry</h1>
        <% User user = (User) session.getAttribute("user");
           String parameter = request.getParameter("id");
           if(parameter != null){
               Journal journal = user.getJournal(Integer.parseInt(parameter));
               session.setAttribute("journal", journal);
           }
           Journal journal = (Journal) session.getAttribute("journal");
        %>
        <p>Title: <%= journal.getTitle()%></p>
        <p>Content: <%= journal.getDescription() %>></p>
        <p>Date Created: <%= journal.getDateCreated()%></p>
        <p>Date Modified: <%= journal.getLastModified()%></p>
  
        </br><a href="entries.jsp">Return to Entries</a>
    </body>
</html>
