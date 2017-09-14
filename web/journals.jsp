<%-- 
    Document   : journals
    Created on : 09/09/2017, 10:13:34 PM
    Author     : Max
--%>

<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page import="models.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Journals</title>
    </head>
    <body>
        <% 
            String filePath = application.getRealPath("WEB-INF/users.xml");
        %>
        <jsp:useBean id="accounts" class="controllers.LoginController" scope="application">
            <jsp:setProperty name="accounts" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <%
            Users users = accounts.getUsers();
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            User user = (User) session.getAttribute("user");
            if(user == null || (email != null && !(user.getEmail().equals(email)))){
                user = users.login(email, password);
            }
            if(user != null){
                String name = request.getParameter("name");
                int userID = accounts.getNewUserID();
                session.setAttribute("user", user);
                accounts.updateXML(users, filePath);
                
            %><h1>Journal Page</h1>
                <p>Welcome, <%= user.getName() %>!</p>
                <p>Click <a href="login.jsp">here</a> to return to the login page.</p>
                <p>Click <a href="createJournal.jsp">here</a> to create a new journal</p>
                <% if(user.getJournals().size() > 0){
                    for(Journal j : user.getJournals()){
                        %><p id="<%= j.getJournalID()%>" onClick="journalClick(this, <%= j.getJournalID()%>)">Journal: <%= j.getTitle()%></p><%
                    }
                }
            } else { %>
            <p>Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</p>
            <% } %>
    </body>
</html>

<script type="text/javascript">
   function journalClick(elmnt, journalID){
       elmnt.style.color = 'red';
       window.location = "../redbook/entries.jsp?id="+journalID;
   }
   
    //$(document).ready(function(){  });
    /** window.onload = function(){
        function journalClick(Journal j){
            window.location = "../entries.jsp";
            console.log("hit click");
        }
    };**/
</script>
