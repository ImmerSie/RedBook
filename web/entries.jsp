<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Max
--%>

<%@page import="models.Entry"%>
<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entries</title>
    </head>
    <body>
        <% User user = (User) session.getAttribute("user");
           String parameter = request.getParameter("id");
           if(parameter != null){
               Journal journal = user.getJournal(Integer.parseInt(parameter));
               session.setAttribute("journal", journal);
           }
           Journal journal = (Journal) session.getAttribute("journal");
        %>
        <h1><%= journal.getTitle()%></h1>
        <h2><%= journal.getDescription()%></h2>
        <p>Created: <%= journal.getDateCreated()%>   Modified: <%= journal.getLastModified() %></p>
        <h3>Entries</h3>
        <%
            if(journal.getEntries().size() > 0){
                for(Entry e : journal.getEntries()){
        %><p id="<%= e.getEntryID() %>" onClick="entryClick(this, <%=e.getEntryID()%>)">Entry <%= e.getTitle()%></p><%
                }
            }
            else{
                %><p>You have no entries</p><%
            }
            %>
            <a href="createEntry.jsp">Create new entry</a>
            <a href="journals.jsp">Return to Journals</a>
    </body>
</html>

<script type="text/javascript">
    function entryClick(elmnt, entryID){
       elmnt.style.color = 'red';
       window.location = "../redbook/viewEntry.jsp?id="+entryID;
   }
</script>
