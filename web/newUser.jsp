<%-- 
    Document   : newUser
    Created on : 05/09/2017, 4:09:00 PM
    Author     : Max
--%>

<%@page import="models.User"%>
<%@page import="models.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome!</title>
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
            
            if(users.getUser(email) == null){
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                int userID = accounts.getNewUserID();
                User user = new User(userID, name, email, password);
                session.setAttribute("user", user);
                users.addUser(user);
                accounts.updateXML(users, filePath);
                
                %><p>Welcome, <%= name %>!</p>
                <p>Click <a href="index.html">here</a> to return to the landing page.</p>
            <% } else { %>
            <p>A user with that email address has already been registered. Click <a href="createUser.jsp">here</a> to return to the account registration page.</p>
            <% } %>
    </body>
</html>
