<%-- 
    Document   : viewEntry
    Created on : 14/09/2017, 8:24:52 PM
    Author     : Ramu
--%>

<%@page import="models.EntryHistory"%>
<%@page import="models.User"%>
<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.User"%>
<%@page import="models.Journal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entry</title>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="viewEntry.js"></script>
        <!-- Code for date formatting, to put in an easier to understand format -->
        <%
            SimpleDateFormat ft1 = new SimpleDateFormat("dd/MM/yyyy - E - hh:mm aa");
        %>
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
        <script type="text/javascript" src="//simonwaldherr.github.io/micromarkdown.js/dist/micromarkdown.min.js"></script>
        <script>
            $( function() {
                $( document ).tooltip();
            } );
        </script>
    </head>
    <body>
        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="journals.jsp"> Journals </a></li>
                <li class="current"><a href="entries.jsp"> Entries </a></li>
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
                    <li><div id="usersName"> <%= user.getName()%>  </div></li>
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </ul>
            </div>
        </nav>
        <h1></h1>  
        <p>
            <a href="entries.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            </a>        
        </p>
        <div id="viewDialog">
            <!-- Setting the file path for the XML file which would contain the data of journal entry's histories -->
            <%  
                String filePath = application.getRealPath("WEB-INF/entriesHistory.xml");
            %>
            <!-- A JavaBean will allow access to getter/setter methods and serializable objects -->
            <jsp:useBean id="entryHisApp" class="controllers.EntryHistoryController" scope="session">
                <jsp:setProperty name="entryHisApp" property="filePath" value="<%=filePath%>"/>
            </jsp:useBean>
            <%
                EntryController entryApp = (EntryController) session.getAttribute("entryApp");
                Journal journal = (Journal) session.getAttribute("journal");
                String parameter = request.getParameter("id");
                Entry entry = null; //By default on this page, an entry is set to null until an entry is found based on an id number
                if (parameter != null) {
                    entry = journal.getEntry(Integer.parseInt(parameter));
                }
                entryHisApp.setEntry(entry);
            %>

                                        <%-- 
                                VIEW ENTRY
                            --%>
            <div class="table" id="viewEntryTable">
                
                <table id="viewEntryData">
                    
                     <input type="hidden" id="entryID" name="entryID" value="<%=entry.getEntryID()%>">
                </table>
           
                
                                        <%-- 
                                ENTRY HISTORY
                            --%>

                <table id="viewHistoryTable"></table>
                <table id="historyEntryDiv"></table>
                <div id="commentDiv">
                    <h2>Comments</h2>
                </div>  
            </div>
            <div id="entryHistoryList"></div>             
        </div>

        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 

    </body>
</html>

<!-- 
JavaScript code for changing the viewEntry JSP page into the editing mode
Also hiding the journal entry history when user is done
-->
<script type="text/javascript">
    function editMode(elmnt, entryID) {
        elmnt.style.color = 'red';
        var currentURL = window.location.href;
        window.location = currentURL + "&mode=edit";
    }
<<<<<<< HEAD
       
=======
>>>>>>> origin/EntryInit
    $('#entryHistoryList').hide();
    $('#viewHistoryTable').hide();
    
    getEntry();
    getComments();
</script>
