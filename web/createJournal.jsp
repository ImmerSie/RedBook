<%-- 
    Document   : createJournal
    Created on : 09/09/2017, 10:56:23 PM
    Author     : Sarah
--%>

<%@page import="models.User"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="stylesheets/template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script src="scripts/createJournal.js" type="text/javascript"></script>
        <title>Create Journal</title>
        <!-- If a user is not logged in while trying to access this page, they are redirected to the login JSP page -->
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <!-- JQuery Tooltips Code Implementation -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $( function() {
                $( document ).tooltip();
            } );
        </script>
    </head>
    <body>
        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="assets/DBackground.png" class="stretch" alt="TEST" />
        </div>  
        <%
            User user = (User) session.getAttribute("user");
        %>
        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="journals.jsp"> Journals </a></li>
                <li class="current"><a href="createJournal.jsp">Add Journal</a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <!-- Top navigation bar -->
        <nav role="main">
            <div id= "topNav">
                <ul>
                    <li><a href="logout.jsp"> Logout </a></li>
                    <li><img src="assets/userIcon.png" id="userIcon" alt="User Icon"></li>
                    <li><div id="usersName"><%= user.getName()%> </div></li>
                    <img src="assets/RedLogo.png" class="logo" alt="Logo">
                </ul>
            </div>
        </nav>

        <h1 class="head1"></h1>  

        <p>
            <a href="journals.jsp" id="alignmentBtn" title="Go Back">
                <img src="assets/backArrow.png" class="backButton" alt="Go Back">
            </a>        
        </p>
        
        <!-- Journal Creation Form -->
        <!--<form action="newJournal.jsp" method="post">-->
            <div id="journalAddTable">    
                <table>
                    <tr>
                        <!-- Name of the new journal field -->
                        <td> Journal Name: </td>
                        <td><input type="text" name="title" id="createJournalTitle" placeholder="Name..." required
                                   oninvalid="setCustomValidity('Title cannot be blank. Please input a title for this journal.')"
                                   oninput="setCustomValidity('')" title="Give this journal a name"></td>
                    </tr>
                    <tr>
                        <!-- Description for the new journal field -->
                        <td> Brief Description: </td>
                        <!--<td><input type="hidden" id="createJournalUserID" value="userID"</td>
                        <td><button value="Create" onclick="createJournal()">Create</button></td>-->
                        <td><input type="text" name="description" id="createJournalDesc" placeholder="Description..." required
                                   title="Give this journal a description"></td>
                    </tr>
                    <tr>
                        <!-- Submit button to create a new Journal -->
                        <td><input type="hidden" id="createJournalUserID" value="<%= user.getUserID() %>"/></td>
                        <td><button type="submit" value="Create" onclick="createJournal()"
                                    title="Create a journal after you have filled out the above fields">Create</button></td>
                    </tr>
                </table>
            </div>    
        <!--</form>-->
    </body>
</html>
