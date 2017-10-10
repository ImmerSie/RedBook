<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
<%@ taglib uri='http://ur6lad.co.ua/markdown-taglib' prefix ='md' %> 
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entry</title>
        <%User user = (User) session.getAttribute("user");%>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="viewEntry.js"></script>
        <%
            SimpleDateFormat ft1 = new SimpleDateFormat("dd/MM/yyyy - E - hh:mm aa");
        %>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
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
        <nav role="side">
            <ul>
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
                <a/>        
        </p>


        <div id="viewDialog">
            <%  String filePath = application.getRealPath("WEB-INF/entriesHistory.xml");
            %>
            <jsp:useBean id="entryHisApp" class="controllers.EntryHistoryController" scope="session">
                <jsp:setProperty name="entryHisApp" property="filePath" value="<%=filePath%>"/>
            </jsp:useBean>
            <%
                EntryController entryApp = (EntryController) session.getAttribute("entryApp");
                Journal journal = (Journal) session.getAttribute("journal");
                String parameter = request.getParameter("id");
                Entry entry = null;
                if (parameter != null) {
                    entry = journal.getEntry(Integer.parseInt(parameter));
                }
                entryHisApp.setEntry(entry);
                if (request.getParameter("mode") != null) {%>

            <%-- 
    EDIT ENTRY
            --%>
            <form action="viewEntry.jsp" method="POST">
                <div>
                    <table class="table">
                        <tr>
                            <td id="date"> Date Created: <%= ft1.format(entry.getDateCreated())%> </td>
                            <td id="date"> Date Modified: <%= ft1.format(entry.getDateModified())%> </td>
                            <td id="exitSymbol"><a href="entries.jsp"> X </a></td>
                        <tr></tr>
                        <td colspan="5"><h2> Entry Title: </h2></td>
                        <tr></tr>
                        <td  colspan="5"><input type="text" value="<%= entry.getTitle()%>" name="entryTitle"></td>
                        <tr></tr>
                        <td  colspan="5"><textarea name="entryContent" rows="6" id="entryContent"><%= entry.getContent()%></textarea></td>
                        <tr></tr>
                        <td colspan="5"><input id="saveBtn" type="submit" value="Save Entry" name="Save Entry"></td>
                        <tr></tr>
                        <td>
                            <input type="hidden" name="id" value="<%= entry.getEntryID()%>" id="id">
                        </td>
                        <tr></tr>
                        <td>
                            <input type="hidden" name="modified" value="modified" id="modified">
                        </td>
                        </tr>
                    </table>
                </div>
            </form>
            <% } else {
                if (request.getParameter("modified") != null) {
                    String title = request.getParameter("entryTitle");
                    String content = request.getParameter("entryContent");
                    String flag = request.getParameter("entryFlag");

                    Entry newEntry = new Entry(entry.getUserID(), entry.getJournalID(), entry.getEntryID(), title, content, flag, entry.getDateCreated());
                    entry.addToHistory(newEntry);
                    entryApp.saveEntries();
                    entryHisApp.saveEntryHistory();
                }%>

            <%-- 
    VIEW ENTRY
            --%>
            <div class="table" id="viewEntryTable">
                <table id="viewEntryData">
                    <tr>
                        <td id="viewDateCreated" value="<%= entry.getDateCreated()%>">Date Created: <%= ft1.format(entry.getDateCreated())%></td>
                        <td id="viewDateModified" value="<%= entry.getDateModified()%>">Date Modified: <%= ft1.format(entry.getDateModified())%></td> 
                        <td>
                            <button type="button" onClick="editMode(this, <%= entry.getEntryID()%>)" title="Make changes to this journal entry">Edit</button>
                        </td>
                        <td>
                            <button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()" title="Display the editing history of this journal entry">Show History</button>
                        </td>
                        <td>
                            <form action="${pageContext.request.contextPath}/entryServlet.do" method="GET">
                                <input type="hidden" id="entryID" name="entryID" value="<%=entry.getEntryID()%>">
                                <input type="submit" class="button" value="Download" title="Download a copy of this journal entry">
                            </form>
                        </td>
                        <td id="exitSymbol"><a href="entries.jsp" title="Return to the list of journal entries"> X </a></td>
                    <tr></tr>
                    <td id="viewEntryTitle" colspan="5"> <%= entry.getTitle()%></td>
                    <tr></tr>
                    <td id="viewEntryContent" colspan="5"> <md:render text="<%= entry.getContent()%>"> </md:render> </td>
                        <td>
                            <input type="hidden" name="id" value="<%= entry.getEntryID()%>" id="id">
                    </td>
                    </tr>
                </table>
                <%-- 
        ENTRY HISTORY
                --%>

                <table id="viewHistoryTable"></table>
                <table id="historyEntryDiv"></table>

            </div>
            <div id="entryHistoryList">
                <div id="historyListHeader"> Entry History </div>
                <table>
                    <tr onClick="setViewHistoryTable()">
                        <td id="viewEntryTitle"> <%= entry.getDateModified()%> </td>
                    </tr>
                </table>
                <% for (EntryHistory eh : entry.getHistoryReverse()) {%>
                <table>
                    <tr id="<%= eh.getEntryHisID()%>" onClick="getEntryHistory(this)">
                        <td ><%= eh.getDateModified()%></td>
                    <input type="hidden" value="<%= eh.getTitle()%>">
                    <input type="hidden" value="<%= eh.getContent()%>">
                    <input type="hidden" value="<%= eh.getDateModified()%>">
                    </tr>
                </table>
                <% } %>
            </div>             
            <% }%>
        </div>

        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 

    </body>
</html>

<script type="text/javascript">
    function editMode(elmnt, entryID) {
        elmnt.style.color = 'red';
        var currentURL = window.location.href;
        window.location = currentURL + "&mode=edit";
    }

    $('#entryHistoryList').hide();
    $('#viewHistoryTable').hide();
</script>
