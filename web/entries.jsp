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
               //Journal journal = journalApp.getJournalFromID(Integer.parseInt(parameter));
               Journal journal = user.getJournal(Integer.parseInt(parameter));
               ArrayList<Entry> e = entryApp.getEntriesForJournal(journal.getUserID(), journal.getJournalID());
               journal.setEntries(e);
               session.setAttribute("journal", journal);
               entryApp.setJournal(journal);
           }
           //Journal journal = (Journal) session.getAttribute("journal");
           //Journal journal = user.getJournal(parameter)entryApp.getJournal();
           //session.setAttribute("journal", journal);
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
        <button type="button" onClick="makeRequest()">Hide</button>
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
            }
            ArrayList<Entry> entries = null;
            
            String mode = request.getParameter("mode");
            if(mode == null || mode.equals("visible")){
                entries = entryApp.getNonHiddenEntries().getEntries();
            }
            else if(mode.equals("hidden")){
                entries = entryApp.getHiddenEntries().getEntries();
            }
            else{
                entries = entryApp.getAllEntries().getEntries();
            }
            
            String sort = request.getParameter("sort");
            if(sort != null && sort.equals("title")){
                entries = entryApp.sortByTitle(entries);
            }
            else if(sort != null && sort.equals("titleDesc")){
                entries = entryApp.sortByTitleDesc(entries);
            }
            %>

            if(entryApp.getNonHiddenEntries().getEntries().size() > 0)
            { %>
                <div id="entriesMenu"
                    <table>
                        <tr>
                            <td>
                                <button type="button" id="seeHiddenBtn" onClick="viewHidden()"> See Hidden </button>
                            </td>
                            <td>
                                <a class="addEntry" href="createEntry.jsp"> + </a>
                            </td>
                        <td>
                            <button type="button" onClick="viewHidden()"> See Hidden </button>
                        </td>
                        <td>
                            <button type="button" onClick="hideEntries()"> Hide </button>
                        </td>
                        <td>
                            <select id="mode" onChange="changeMode()">
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
            <% if(entries.size() > 0)
            { 
                for(Entry e : entries){ %> 
                    <div style="overflow-x:auto;">
                    <div class="entryList">    
                    <table>
                        <td>
                            <input type="checkbox" class="entryCheck" name="<%= e.getEntryID()%>" value="<%= e.getEntryID() %>">
                        </td>
                        <td onClick="entryClick(this, <%=e.getEntryID()%>)"><%= e.getTitle() %></td>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td onClick="entryClick(this, <%=e.getEntryID()%>)"> <%= e.getDateModified()%> </td>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
                        <td onClick="entryClick(this, <%=e.getEntryID()%>)"><%= e.getFlag() %></td>
                         <td></td><td></td><td>
                        <td>    
                            <button type="button" class="hideBtn" onClick="hide()">Hide</button>
                        </td>
                        <td><input type="hidden" value="<%= e.getEntryID()%>" name="entryID" id="entryID"></td>
                    </tr>
                        </table>
                    </div>
                </div>
                <% } 
            }
            else{
            %><p><h3>You have no entries.</h3></p>
                <p><h3> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p><%
            }
            %>

        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>        
    
    </body>
</html>

<script type="text/javascript">
    function entryClick(elmnt, entryID){
       elmnt.style.color = 'red';
       var currentURL = window.location.href;
        if(currentURL.indexOf('entries') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('entries'));
            currentURL = currentURL + "viewEntry.jsp";
        }
       window.location = currentURL + "?id=" + entryID;
   }
   
    function changeMode(){
        var dropDown = document.getElementById("mode");
        if(dropDown.value == "hidden"){
            var currentURL = window.location.href;
            if(currentURL.indexOf('mode') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('mode') - 1);
            }
            
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&mode=hidden";
            }
            else{
                window.location = currentURL + "?mode=hidden";
            }
        }
        else if(dropDown.value == "all"){
            var currentURL = window.location.href;
            if(currentURL.indexOf('mode') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('mode') - 1);
            }
            
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&mode=all";
            }
            else{
                window.location = currentURL + "?mode=all";
            }
        }
        else{
            var currentURL = window.location.href;
            if(currentURL.indexOf('mode') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('mode') - 1);
            }
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&mode=visible";
            }
            else{
                window.location = currentURL + "?mode=visible";
            }
        }
    }
    
    function sortEntries(){
        var dropDown = document.getElementById("sorting");
        if(dropDown.value == "byTitle"){
            var currentURL = window.location.href;
            if(currentURL.indexOf('sort') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('sort') - 1);
            }
            
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&sort=title";
            }
            else{
                window.location = currentURL + "?sort=title";
            }
        }
        else if(dropDown.value == "byTitleDesc"){
            var currentURL = window.location.href;
            if(currentURL.indexOf('sort') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('sort') - 1);
            }
            
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&sort=titleDescv";
            }
            else{
                window.location = currentURL + "?sort=titleDesc";
            }
        }
        else{
            var currentURL = window.location.href;
            if(currentURL.indexOf('sort') > 0){
                currentURL = currentURL.substring(0, currentURL.indexOf('sort') - 1);
            }
            
            if(currentURL.indexOf('?') > 0){
                window.location = currentURL + "&sort=date";
            }
            else{
                window.location = currentURL + "?sort=date";
            }
        }
    }
    
    var url = window.location.href;
    if(url.indexOf("title") > 0){
        document.getElementById("sorting").selectedIndex =  1;

    }
    else if(url.indexOf("titleDesc") > 0){
         document.getElementById("sorting").selectedIndex =  2;

    }
    else if(url.indexOf("date") > 0){
         document.getElementById("sorting").selectedIndex =  0;
    }
    
    if(url.indexOf("visible") > 0){
        document.getElementById("mode").selectedIndex =  0;
    }
    else if(url.indexOf("hidden") > 0){
        document.getElementById("mode").selectedIndex =  1;
    }
    else if(url.indexOf("all") > 0){
        document.getElementById("mode").selectedIndex =  2;
    }
    
</script>
