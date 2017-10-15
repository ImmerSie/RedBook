<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Sarah
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="controllers.EntryController"%>
<%@page import="controllers.JournalController"%>
<%@page import="controllers.LoginController"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entries</title>
        <!-- JQuery Tooltips Code Implementation -->
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="entries.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script>
            $( function() {
                $( document ).tooltip();
            } );
        </script>
    </head>
    <body>
        <!-- Setting the file path for the XML file which would contain the data of the journal entries -->
        <%  
            if(session.getAttribute("entryApp") == null){
                String filePath = application.getRealPath("WEB-INF/entries.xml"); %>
                
                <!-- A JavaBean will allow access to getter/setter methods and serializable objects -->
                <jsp:useBean id="entryApp" class="controllers.EntryController" scope="session">
                    <jsp:setProperty name="entryApp" property="filePath" value="<%=filePath%>"/>
                </jsp:useBean>
        <% }
            EntryController entryApp = (EntryController) session.getAttribute("entryApp");
        
            LoginController userApp = (LoginController) application.getAttribute("userApp");
            JournalController journalApp = (JournalController) session.getAttribute("journalApp");
            User user = (User) session.getAttribute("user");
            if(journalApp == null){
                String journalFilePath = application.getRealPath("WEB-INF/journals.xml");
                journalApp = new JournalController();
                journalApp.setFilePath(journalFilePath);
                session.setAttribute("journalApp", journalApp);
            }

            journalApp.setUser(user);
            String parameter = request.getParameter("id");

            //If the parameter is not null, then the JSP page loads the journal of that id parameter
            if(parameter != null){
                Journal journal = user.getJournal(Integer.parseInt(parameter));
                ArrayList<Entry> e = entryApp.getEntriesForJournal(journal.getUserID(), journal.getJournalID());
                journal.setEntries(e);
                session.setAttribute("journal", journal);
                entryApp.setJournal(journal);
            }
            Journal journal = (Journal) session.getAttribute("journal");
        %>

        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="entries.jsp"> Entries </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 

        <!-- Top navigation bar -->
        <nav role="main">
            <div id= "topNav">
                <ul>
                    <li><a href="logout.jsp"> Logout </a></li>
                    <li><img src="userIcon.png" id="userIcon"></li>
                    <li><div id="usersName"> <%= user.getName()%> </div></li>
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </ul>
            </div>
        </nav>        
        <div class="journalDetails">
            <!-- Retrieving Journal properties -->
            <h1 id="journalDetTitle"><%= journal.getTitle()%></h1>
            <h3 id="journalDetDesc"><%= journal.getDescription()%></h3>
            <input type="hidden" id="journalID" value="<%= journal.getJournalID() %>">
            <input type="hidden" id="userID" value="<%= journal.getUserID()%>">
            <h4>
                <!-- Code for date formatting, to put in an easier to understand format -->
                <%
                    SimpleDateFormat ft1 = new SimpleDateFormat("dd/MM/yyyy - E - hh:mm aa");
                %>
                <p>Created: <%=ft1.format(journal.getDateCreated())%></p>
                <p>Last Modified: <%=ft1.format(journal.getLastModified())%></p>
                <p>
                    <!-- Journal details editing function  -->
                    <button class="editJournalBtn" onClick="editJournal()"> Edit Description </button>
                </p>
            </h4> 
        </div>
        <div id="editJournal" class="modal"></div>  

        <div id="entriesMenu">
            <table>
                <tr>
                    <td></td>
                    <td></td>
                    <td> Show: </td>
                    <td> Sort: </td>
                    <td> Search: </td>
                </tr>
                <tr>
                    <!-- Icon button for adding an entry to the current journal -->
                    <td><a class="addEntry" href="createEntry.jsp" title="Add a new entry to this journal"> + </a></td>
                    <!-- Hide entry button based on selected entries via the checkbox at the beginning of the entry row -->
                    <td><button type="button" onClick="hideEntries()"> Hide </button></td>
                    <td>
                        <!-- Filter which entries are displayed based on the status of the entries -->
                        <select id="filter" onChange="filterEntries()">
                            <option value="visible">Visible Entries</option>
                            <option value="hidden">Hidden Entries</option>
                            <option value="deleted">Deleted Entries</option>
                            <option value="all">All Entries</option>
                        </select>
                    </td>
                    <td>
                        <!-- Sorting entries based on different criteria -->
                        <select id="sorting" onChange="sortEntries()">
                            <option value="byDate">By Date</option>
                            <option value="byDateDesc">By Date Desc</option>
                            <option value="byTitle">By Title</option>
                            <option value="byTitleDesc">By Title Desc</option>
                        </select>
                    </td>
                    <td>
                        <!-- Searching function for entries based on specification -->
                        <select id="searchBy" onChange="searchBy()">
                            <option value="searchNone">Search by...</option>
                            <option value="searchTitle">Title</option>
                            <option value="searchContent">Content</option>
                            <option value="date">Date</option>
                            <option value="month">Month</option>
                            <option value="year">Year</option>
                            <option value="searchBetween">Between</option>
                        </select>
                    </td>
                    <td id="searchInput"></td>
                </tr>
            </table>
        </div>     
        <div id="ajaxEntries"></div>
        <div id="searchResultEntries"></div>

        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>        

    </body>
</html>

<!-- 
JavaScript code for viewing a journal entry by clicking on an entry row
Also retrieving the resulting entries from searching and filtering
-->
<script type="text/javascript">
    getEntries();

    function entryClick(elmnt, entryID) {
        elmnt.style.color = 'red';
        var currentURL = window.location.href;
        if (currentURL.indexOf('entries') > 0) {
            currentURL = currentURL.substring(0, currentURL.indexOf('entries'));
            currentURL = currentURL + "viewEntry.jsp";
        }
        window.location = currentURL + "?id=" + entryID;
    }

    function sortEntries() {
        getEntries();
    }

    function filterEntries() {
        getEntries();
    }
</script>


<!-- 
JavaScript code for viewing the journal description and title editing modal
-->
<script>
// Get the modal
var modal = document.getElementById('editJournal');

// Get the button that opens the modal
var btn = document.getElementById("editJournalBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function () {
    modal.style.display = "block";
}

</script>
