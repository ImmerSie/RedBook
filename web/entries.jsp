<%-- 
    Document   : entries
    Created on : 10/09/2017, 12:35:45 PM
    Author     : Max
--%>

<%@page import="java.util.Date"%>
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
           String parameter = request.getParameter("id");
           if(parameter != null){
               Journal journal = journalApp.getJournalFromID(Integer.parseInt(parameter));
               session.setAttribute("journal", journal);
           }
           Journal journal = (Journal) session.getAttribute("journal");
        %>
        <h1><%= journal.getTitle()%></h1>
        <h2><%= journal.getDescription()%></h2>
        <p>Created: <%= journal.getDateCreated()%>   Modified: <%= journal.getLastModified() %></p>
        <h3>Entries</h3>
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
                entryApp.updateXML(journal, filePath);
            }
            if(journal.getEntries().size() > 0)
            { %>
                <table>
                    <% for(Entry e : journal.getEntries()){ %>
                    <tr onClick="entryClick(this, <%=e.getEntryID()%>)">
                        <td><%= e.getTitle() %></td>
                        <td><%= e.getContentSnippet()%></td>
                        <td><%= e.getFlag() %></td>
                        <td><input type="hidden" value="<%= e.getEntryID()%>" name="entryID" id="entryID"></td>
                    </tr>
                    <% } %>
                </table>              
            <% }
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
