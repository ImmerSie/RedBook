<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Max
--%>

<%@page import="models.Entries"%>
<%@page import="java.util.Date"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entries</title>
    </head>
    <body>
        <%  String filePath = application.getRealPath("WEB-INF/entries.xml");
            String filePath2 = application.getRealPath("WEB-INF/journals.xml");
            String filePath3 = application.getRealPath("Web-INF/users.xml");
        %>
        <jsp:useBean id="entryApp" class="controllers.EntryController" scope="application">
            <jsp:setProperty name="entryApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <jsp:useBean id="journalApp" class="controllers.JournalController" scope="application">
            <jsp:setProperty name="journalApp" property="filePath" value="<%=filePath2%>"/>
        </jsp:useBean>
        <jsp:useBean id="userApp" class="controllers.LoginController" scope="application">
            <jsp:setProperty name="userApp" property="filePath" value="<%=filePath3%>"/>
        </jsp:useBean>
        <% User user = (User) session.getAttribute("user");
           journalApp.setUser(user);
           String parameter = request.getParameter("id");
           if(parameter != null){
               Journal journal = journalApp.getJournalFromID(Integer.parseInt(parameter));
               session.setAttribute("journal", journal);
               Entries journalEntries = entryApp.getEntriesForJournal(journal.getUserID(), journal.getJournalID());
               journal.setEntries(journalEntries);
           }
           Journal journal = (Journal) session.getAttribute("journal");
        %>
        
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
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <a href="index.html">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        
            <h1><%= journal.getTitle()%></h1>
            <h1><%= journal.getDescription()%></h1>
        <div id="entriesTable">    
            <table>
        <p>Created: <%= journal.getDateCreated()%>   Modified: <%= journal.getLastModified() %></p>
        <button type="button" onClick="hide()">Hide</button>
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
                entryApp.updateXML(journal.getEntries(), filePath);
            }
            if(journal.getEntries().getEntries().size() > 0)
            { %>

                    <% for(Entry e : journal.getEntries().getEntries()){ %>
                    <tr onClick="entryClick(this, <%=e.getEntryID()%>)">
                        <td><%= e.getTitle() %></td>
                        <td><%= e.getContentSnippet()%></td>
                        <td><%= e.getFlag() %></td>
                        <td><input type="hidden" value="<%= e.getEntryID()%>" name="entryID" id="entryID"></td>
                    </tr>
                    <% } %>
            
            <% }
            else{
                %><p>You have no entries</p><%
            }
            %>
                </table>
            </div>
    
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>        
    
    </body>
</html>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript">
    function entryClick(elmnt, entryID){
       elmnt.style.color = 'red';
       window.location = "../RedBook/viewEntry.jsp?id="+entryID;
   }
   function hide(){
       var currentURL = window.location.href;
        if(currentURL.indexOf('viewEntry') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('viewEntry'));
            currentURL + "hideEntry.jsp";
        }
       $.get(currentURL);
       //var eApp = "";
        //eApp.hideEntry();
   }
</script>
