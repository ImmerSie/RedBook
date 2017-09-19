<%-- 
    Document   : createJournal
    Created on : 09/09/2017, 10:56:23 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Journal</title>
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
        
        <h1></h1>  
        
        <p>
            <a href="entries.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            <a/>        
        </p>
        
        <form action="newJournal.jsp" method="post">
            <div id="journalAddTable">    
                <table>
                    <tr>
                        <td> Journal Name: </td>
                        <td><input type="text" name="title"></td>
                    </tr>
                    <tr></tr>
                    <tr></tr>
                    <tr></tr>
                    <tr>
                        <td> Brief Description: </td>
                        <td><input type="text" name="description"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="Create"></td>
                    </tr>
                </table>
            </div>    
        </form>
    </body>
</html>
