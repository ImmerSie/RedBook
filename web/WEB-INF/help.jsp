<%-- 
    Document   : help
    Created on : 04/10/2017, 9:25:12 AM
    Author     : SophiePapworth
--%>
<%@page import="models.User"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Help </title>
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
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="entries.jsp"> Entries </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="icon"></li>
                <li><div id="usersName"><%= user.getName() %> </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        
        <h1> Help and Documentation Guide </h1>
        
        <p>
            <a href="journals.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            <a/>        
        </p>  
        
    </body>
</html>
