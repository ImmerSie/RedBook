<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Max
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="controllers.EntryController"%>
<%@page import="controllers.JournalController"%>
<%@page import="controllers.LoginController"%>
<%@page import="models.Entries"%>
<%@page import="java.util.Date"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entries</title>
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script type="text/javascript" language="javascript" src="entries.js"></script>
        <%
            if(((HttpServletRequest) request).getSession().getAttribute("user") == null){
            ((HttpServletResponse) response).sendRedirect("login.jsp");
        }%>
    </head>
    <body>
        <%  if(session.getAttribute("entryApp") == null){
            String filePath = application.getRealPath("WEB-INF/entries.xml"); %>
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
           if(parameter != null){
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
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="index.html"> Logout </a></li>
                <li><img src="userIcon.png" id="icon"></li>
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <a href="index.html">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        
        <h1><%= journal.getTitle()%></h1>
        <h3><%= journal.getDescription()%></h3>
        <h4>
            <p>Created: <%= journal.getDateCreated()%>   Last Modified: <%= journal.getLastModified() %></p>
        </h4>       
        <%
            if(request.getParameter("title") != null){
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
            } %>
                <div id="entriesMenu">
                    <table>
                        <tr>
                            <td>
                                <a class="addEntry" href="createEntry.jsp"> + </a>
                            </td>
                            <td>
                                <button type="button" onClick="hideEntries()"> Hide </button>
                            </td>
                            <td>
                                <select id="filter" onChange="filterEntries()">
                                    <option value="visible">Visible Entries</option>
                                    <option value="hidden">Hidden Entries</option>
                                    <option value="all">All Entries</option>
                                </select>
                            </td>
                            <td>
                                <select id="sorting" onChange="sortEntries()">
                                    <option value="byDate">By Date</option>
                                    <option value="byTitle">By Title</option>
                                    <option value="byTitleDesc">By Title Desc</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>     
            <div id="ajaxEntries"></div>

        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>        
    
    </body>
</html>

<script type="text/javascript">
    getEntries();
    
    function entryClick(elmnt, entryID){
       elmnt.style.color = 'red';
       var currentURL = window.location.href;
        if(currentURL.indexOf('entries') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('entries'));
            currentURL = currentURL + "viewEntry.jsp";
        }
       window.location = currentURL + "?id=" + entryID;
   }
      
    function sortEntries(){
        getEntries();
    }
    
    function filterEntries(){
        getEntries();
    }   
</script>
