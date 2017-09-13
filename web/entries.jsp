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
        <h1>Entries</h1>
        <h2><%= user.getName() %></h2>
        <h3>Journal <%= journal.getTitle() %></h3>
        <h3>Entries</h3>
        <%
            if(journal.getEntries().size() > 0){
                for(Entry e : journal.getEntries()){
                    %><p>Entry <%= e.getTitle()%></p><%
                }
            }
            else{
                %><p>You have no entries</p><%
            }
            %>
            <a href="createEntry.jsp">Create new entry</a>
    </body>
</html>
