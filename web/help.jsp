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
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Help </title>
        <!-- If a user is not logged in while trying to access this page, they are redirected to the login JSP page -->
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
                <li><a href="journals.jsp"> Journals </a></li>
                <li class="current"><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <!-- Top navigation bar -->
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="userIcon"></li>
                <li><div id="usersName"><%= user.getName() %> </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        
        <!-- Page document descriptive heading -->
        <p id="helpHeader"> Help and Documentation Guide </p>
        
        <p>
            <a href="journals.jsp" id="alignmentBtn">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            </a>        
        </p>
        
        <div id="helpMenu">
            <table>
                <tr>
                    <td>
                        <%--
                    Section Selection Here (Dropdown)
                        1. User Management
                        2. Journal Managment
                        3. Journal Entry Managament
                        --%>
                    </td>
                    <td>
                        <%--
                    Search Function Here
                        --%>
                    </td>
                </tr>
            </table>
        </div>
        
        <!-- Table used to store and provide useful information to users about how to use RedBook -->
        <div class="helpTable">
            <table>
                <tr>
                    <td id="helpH1"> 1. User Management </td>
                </tr>
                <tr>
                    <td id="helpH2"> 1.1 How do I create an account? </td>
                </tr>
                <tr>
                    <td id="helpBody"> Click this <a href ="createUser.jsp"> link </a> to create an account. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 1.2 How do I logout? </td>
                </tr>
                <tr>
                    <td id="helpBody"> Click the red ‘Logout’ button that is found in the top right hand corner of every page. </td>
                </tr>
                
                
                <tr>
                    <td id="helpH1"> 2. Journal Management </td>
                </tr>
                <tr>
                    <td id="helpH2"> 2.1 How do I create a new journal? </td>
                </tr>
                <tr>
                    <td id="helpBody"> In the side navigation bar click ‘Journals’ to navigate to your current list of journals, then click the white ‘+’ icon to create a new journal. </td>
                </tr>
                
                
                
                <tr>
                    <td id="helpH1"> 3. Journal Entry Management </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.1 How do I create a journal entry? </td>
                </tr>
                <tr>
                    <td id="helpBody"> If you’ve already created a journal you can; click the ‘Click <a href="createEntry.jsp"> Here </a>’ link on the page where your entries would normally reside, or click the white ‘+’ icon found in the grey menu bar. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.2 How do I hide a journal entry? </td>
                </tr>
                <tr>
                    <td id="helpBody"> To hide a journal entry, click the ‘Hide’ button on the entry you want to hide when viewing your list of entries. If you want to hide multiple entries just select the checkbox on the entry and click ‘Hide’ in the menu bar at the top of the entry list. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.3 How do I see all my hidden journal entries? </td>
                </tr>
                <tr>
                    <td id="helpBody"> To view your hidden entries, within your selected journal you can select the ‘Visible Entries’ drop down and change the setting to ‘Hidden Entries’. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.4 How do I see all my journal entries? </td>
                </tr>
                <tr>
                    <td id="helpBody"> To view your hidden entries, within your selected journal you can select the ‘Visible Entries’ drop down and change the setting to ‘All Entries’. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.5 How do I search for a journal entry? </td>
                </tr>
                <tr>
                    <td id="helpBody"> Within your specified journal, click the ‘Search By’ dropdown found in the menu bar above all the entries and select how you wish to search for your entry. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.6 How do I sort my journal entries? </td>
                </tr>
                <tr>
                    <td id="helpBody"> Automatically the journal entries will be sorted by date. You may change this to ‘By Title’ or ‘By Title Desc[ription]’ through clicking the ‘By Date’ dropdown found in the menu bar above all the entries and select how you wish to sort your entries. </td>
                </tr>
                <tr>
                    <td id="helpH2"> 3.7 How do I edit my entry? </td>
                </tr>
                <tr>
                    <td id="helpBody"> To edit your specified entry, open the entry from the list of entries in your journal and click the ‘Edit’ button found in the top right hand corner of the page. Then click in the title or content boxes and edit away. </td>
                </tr>
                
                <tr>
                    <td id="helpEmail"> Can't find what you're after? Email support at support@redbook.com.au </td>
                </tr>
            </table>            
        </div>
    </body>
</html>
