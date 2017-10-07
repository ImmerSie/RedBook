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
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Welcome!</title>
        <%
            if(session.getAttribute("user")== null){
            response.sendRedirect("login.jsp");}
        %>
    </head>
    <body>

        <a href="index.html">
            <img src="WhtLogo.png" class="logoutLogo" alt="Logo">
        </a>

        <%
            String filePath = application.getRealPath("WEB-INF/users.xml");
        %>
        <jsp:useBean id="userApp" class="controllers.LoginController" scope="application">
            <jsp:setProperty name="userApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <%
            Users users = userApp.getUsers();
            String email = request.getParameter("email");

            if (users.getUser(email) == null) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                int userID = userApp.getNewUserID();
                User user = new User(userID, name, email, password);
                session.setAttribute("user", user);
                users.addUser(user);
                userApp.updateXML(users, filePath);
        %>
        <p>Redirecting you to the journals page... </p>
        <%  String redirectURL = "journals.jsp";
            response.sendRedirect(redirectURL);
        %> 
        <% } else { %>
        <p><h3>A user with that email address has already been registered. Click <a href="createUser.jsp">here</a> to return to the account registration page.</h3></p>
        <% }%>

    <div id="background">
        <img src="DBackground.png" class="stretch" alt="background" />
    </div> 
</body>
</html>
