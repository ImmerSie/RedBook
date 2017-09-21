<%-- 
    Document   : viewEntry
    Created on : 14/09/2017, 8:24:52 PM
    Author     : Max
--%>

<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entry</title>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script>
            $(function(){
               $("$viewDialog").dialog(); 
            });
        </script>
    </head>
    <body>
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
                    <p>Title: <input type="text" value="<%= entry.getTitle() %>" name="entryTitle"></p>
                    <p>Content: <textarea name="entryContent" rows="5"><%= entry.getContent()%></textarea></p>
                    <p>Flag: <input type="text" value="<%= entry.getFlag()%>" name="entryFlag"></p>
                    <p>Date Created: <%= entry.getDateCreated()%></p>
                    <p>Date Modified: <%= entry.getDateModified()%></p>
                    <input type="submit" value="Save Entry" name="Save Entry">
                    <input type="hidden" name="id" value="<%= entry.getEntryID() %>" id="id">
                    <input type="hidden" name="modified" value="modified" id="modified">
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
                <h1>View Entry</h1>

                <p>Title: <%= entry.getTitle()%></p>
                <p>Content: <%= entry.getContent()%></p>
                <p>Flag: <%= entry.getFlag()%></p>
                <p>Date Created: <%= entry.getDateCreated()%></p>
                <p>Date Modified: <%= entry.getDateModified()%></p>  
                <button type="button" onClick="editMode(this, <%= entry.getEntryID() %>)">Edit</button>
            <% } %>
            </br><a href="entries.jsp">Return to Entries</a>
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
