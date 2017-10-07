<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Max
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
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entries</title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="entries.js"></script>
    </head>
    <body>
        <%  if (session.getAttribute("entryApp") == null) {
                String filePath = application.getRealPath("WEB-INF/entries.xml");
        %>
        <jsp:useBean id="entryApp" class="controllers.EntryController" scope="session">
            <jsp:setProperty name="entryApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <% }
            EntryController entryApp = (EntryController) session.getAttribute("entryApp");

            LoginController userApp = (LoginController) application.getAttribute("userApp");
            JournalController journalApp = (JournalController) session.getAttribute("journalApp");
            User user = (User) session.getAttribute("user");
            journalApp.setUser(user);
            String parameter = request.getParameter("id");
            if (parameter != null) {
                Journal journal = user.getJournal(Integer.parseInt(parameter));
                ArrayList<Entry> e = entryApp.getEntriesForJournal(journal.getUserID(), journal.getJournalID());
                journal.setEntries(e);
                session.setAttribute("journal", journal);
                entryApp.setJournal(journal);
            }
            Journal journal = (Journal) session.getAttribute("journal");
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
                    <li><div id="usersName"> <%= user.getName()%> </div></li>
                    <a href="journals.jsp">
                        <img src="RedLogo.png" class="logo" alt="Logo">
                    </a>
                </ul>
            </div>
        </nav>

        <h1><%= journal.getTitle()%></h1>
        <h3><%= journal.getDescription()%></h3>
        <h4>
            <%
                SimpleDateFormat ft1 = new SimpleDateFormat("dd/MM/yyyy - E - hh:mm aa");
            %>
            <p>Created: <%=ft1.format(journal.getDateCreated())%></p>
            <p>Last Modified: <%=ft1.format(journal.getLastModified())%></p>
        </h4>       
        <%
            if (request.getParameter("title") != null) {
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                int userID = user.getUserID();
                int journalID = journal.getJournalID();
                int entryID = entryApp.getNewEntryID();
                Date dateCreated = new Date();
                Date dateModified = new Date();
                Entry entry = new Entry(userID, journalID, entryID, title, content, "visible", dateModified);
                journal.addEntry(entry);
                entryApp.saveEntries();
            }
        %>
        <div id="entriesMenu">
            <table>
                <tr>
                    <td><a class="addEntry" href="createEntry.jsp"> + </a></td>
                    <td><button type="button" onClick="hideEntries()"> Hide </button></td>
                    <td>
                        <select id="filter" onChange="filterEntries()">
                            <option value="visible">Visible Entries</option>
                            <option value="hidden">Hidden Entries</option>
                            <option value="deleted">Deleted Entries</option>
                            <option value="all">All Entries</option>
                        </select>
                    </td>
                    <td>
                        <select id="sorting" onChange="sortEntries()">
                            <option value="byDate">By Date</option>
                            <option value="byDateDesc">By Date Desc</option>
                            <option value="byTitle">By Title</option>
                            <option value="byTitleDesc">By Title Desc</option>
                        </select>
                    </td>
                    <td>
                        <select id="searchBy" onChange="searchBy()">
                            <option value="searchNone">Search by...</option>
                            <option value="searchTitle">Title</option>
                            <option value="searchContent">Content</option>
                            <option value="date">Date</option>
                            <!--<option value="searchMonth">Month</option>
                            <option value="searchYear">Year</option>-->
                            <option value="searchBetween">Between</option>
                        </select>
                    </td>
                    <td id="searchInput"></td>
                </tr>
            </table>
        </div>     
        <div id="ajaxEntries"></div>
        <div id="searchResultEntries"></div>

        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>        

    </body>
</html>

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
