<%-- 
    Document   : viewEntry
    Created on : 14/09/2017, 8:24:52 PM
    Author     : Max
--%>

<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.User"%>
<%@page import="models.Journal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script>
            $(function(){
               $("$viewDialog").dialog(); 
            });
        </script>
    </head>
    <body>
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

        
        <div id="viewDialog" title="Entry">
            <%  String filePath = application.getRealPath("WEB-INF/entriesHistory.xml");
            %>
            <jsp:useBean id="entryHisApp" class="controllers.EntryHistoryController" scope="session">
                <jsp:setProperty name="entryHisApp" property="filePath" value="<%=filePath%>"/>
            </jsp:useBean>
            <% 
                EntryController entryApp = (EntryController) session.getAttribute("entryApp");
                Journal journal = (Journal) session.getAttribute("journal");
                String parameter = request.getParameter("id");
                if(parameter != null){
                    Entry entry = journal.getEntry(Integer.parseInt(parameter));
                    session.setAttribute("entry", entry);
                }
                Entry entry = (Entry) session.getAttribute("entry");
                entryHisApp.setEntry(entry);
            if(request.getParameter("mode") != null)
            { %>
                <h1>Edit Entry</h1>
                <form action="viewEntry.jsp" method="POST">
                <div class="table">
                    <table>
                    <tr>
                    <tr>
                        <td id="date"> Date Created: <%= entry.getDateCreated()%> </td>
                        <td id="date"> Date Modified: <%= entry.getDateModified()%> </td>
                        <td id="date"> Flag: <input type="text" value="<%= entry.getFlag()%>" name="entryFlag"></td>
                        <td id="X"><a href="entries.jsp"> X </a></td>
                    <tr></tr>
                        <td id="entryTitle"> Entry Title: </td>
                        <tr></tr>
                        <td><input type="text" value="<%= entry.getTitle() %>" name="entryTitle"></td>
                    <tr></tr>
                        <td><textarea name="entryContent" rows="5" id="content"><%= entry.getContent()%></textarea></td>
                    <tr></tr>
                    <td>
                        <input id="saveBtn" type="submit" value="Save Entry" name="Save Entry">
                    </td>
                    <td>
                        <input type="hidden" name="id" value="<%= entry.getEntryID() %>" id="id">
                    </td>
                    <td>
                        <input type="hidden" name="modified" value="modified" id="modified">
                    </td>
                    </tr>
                    </table>
                </div>
                </form>
            <% }
            else
            { 
                if(request.getParameter("modified") != null){
                    String title = request.getParameter("entryTitle");
                    String content = request.getParameter("entryContent");
                    String flag = request.getParameter("entryFlag");

                    Entry newEntry = new Entry(entry.getUserID(), entry.getJournalID(), entry.getEntryID(), title, content, flag, entry.getDateCreated());
                    entry.addToHistory(newEntry);
                    entryApp.saveEntries();  
                    entryHisApp.saveEntryHistory();
                } %>
                

                <div class="table">
                    <table>
                        <tr>
                        <td id="date">Date Created: <%= entry.getDateCreated()%></td>
                        <td id="date">Date Modified: <%= entry.getDateModified()%></td> 
                        <td id="date">Flag: <%= entry.getFlag()%></td>

                        <td>
                            <button type="button" onClick="editMode(this, <%= entry.getEntryID() %>)">Edit</button>
                        </td>
                        <tr></tr>
                        <td id="entryTitle" colspan="5"> <%= entry.getTitle()%></td>
                        <tr></tr>
                        <td id="content" colspan="5"><%= entry.getContent()%></td>

                    <% } %>
                    </tr>
                    </table>
                </div>
        </div>
            
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 
            
    </body>
</html>

<script type="text/javascript">
    function editMode(elmnt, entryID){
       elmnt.style.color = 'red';
       var currentURL = window.location.href;
       window.location = currentURL + "&mode=edit";
   }
</script>
