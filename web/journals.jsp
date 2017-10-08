<%-- 
    Document   : journals
    Created on : 09/09/2017, 10:13:34 PM
    Author     : Sarah
--%>

<%@page import="controllers.JournalController"%>
<%@page import="controllers.LoginController"%>
<%@page import="models.Journal"%>
<%@page import="models.User"%>
<%@page import="models.Users"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Journals</title>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $( function() {
                $( document ).tooltip();
            } );
        </script>
    </head>
    <body>
        <%
            if (application.getAttribute("userApp") == null) {
                String filePath = application.getRealPath("WEB-INF/users.xml");%>
        <jsp:useBean id="userApp" class="controllers.LoginController" scope="application">
            <jsp:setProperty name="userApp" property="filePath" value="<%=filePath%>"/>
        </jsp:useBean>
        <% }
            LoginController userApp = (LoginController) application.getAttribute("userApp");
            if (session.getAttribute("journalApp") == null) {
                String filePath2 = application.getRealPath("WEB-INF/journals.xml");%>
        <jsp:useBean id="journalApp" class="controllers.JournalController" scope="session">
            <jsp:setProperty name="journalApp" property="filePath" value="<%=filePath2%>"/>
        </jsp:useBean>
        <% }
            JournalController journalApp = (JournalController) session.getAttribute("journalApp");

            Users users = userApp.getUsers();
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            User user = (User) session.getAttribute("user");
            session.setAttribute("journal", null);
            session.setAttribute("entryApp", null);

            if (user == null || (email != null && !(user.getEmail().equals(email)))) {
                user = users.login(email, password);
            }
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
            if (user != null) {
                String name = request.getParameter("name");
                int userID = userApp.getNewUserID();
                session.setAttribute("user", user);
                userApp.saveUsers();
        %>
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 

        <h1>Journals</h1>

        <div id="addJournal">    
            <a href="createJournal.jsp" title="Create a new journal"> + </a>
        </div>

        <div id="journalPosition">
            <% if (user.getJournals().size() > 0) {
                    for (Journal j : user.getJournals()) {
            %>
            <div class="journal" onClick="journalClick(this, <%= j.getJournalID()%>)">
                <img src="journal.png" alt=""/>
                <p class="journalTitle"> <%= j.getTitle()%> </p>
            </div>
            <% }
                }
            } else { %>
            <p><h3>Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</h3></p>
            <% }%>
    </div>

    <nav role="main">
        <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="icon"></li>
                <li><div id="usersName"> <%= user.getName()%> </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
        </div>
    </nav>

    <div id="background">
        <img src="DBackground.png" class="stretch" alt="background" />
    </div> 
</body>
</html>

<script type="text/javascript">
    function journalClick(elmnt, journalID) {
        elmnt.style.color = 'red';
        var currentURL = window.location.href;
        if (currentURL.indexOf('journal') > 0) {
            currentURL = currentURL.substring(0, currentURL.indexOf('journal'));
            currentURL = currentURL + "entries.jsp";
        }
        window.location = currentURL + "?id=" + journalID;
    }
</script>
