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
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Journals</title>
        <!-- JQuery Tooltips Code Implementation -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $( function() {
                $( document ).tooltip();
            } );
        </script>
    </head>
    <body>
        <!-- Setting the file path for the XML file which would contain the data of the users -->
        <%
            if (application.getAttribute("userApp") == null) {
                String filePath = application.getRealPath("WEB-INF/users.xml");
                %>
                <!-- A JavaBean will allow access to getter/setter methods and serializable objects -->
                <jsp:useBean id="userApp" class="controllers.LoginController" scope="application">
                    <jsp:setProperty name="userApp" property="filePath" value="<%=filePath%>"/>
                </jsp:useBean>
                <!-- Setting the file path for the XML file which would contain the data of the user's journals -->
            <% }
            LoginController userApp = (LoginController) application.getAttribute("userApp");
            
            if (session.getAttribute("journalApp") == null) {
                String filePath2 = application.getRealPath("WEB-INF/journals.xml");
                %>
                <!-- A JavaBean will allow access to getter/setter methods and serializable objects -->
                <jsp:useBean id="journalApp" class="controllers.JournalController" scope="session">
                    <jsp:setProperty name="journalApp" property="filePath" value="<%=filePath2%>"/>
                </jsp:useBean>
            <% }
            JournalController journalApp = (JournalController) session.getAttribute("journalApp");
            
            Users users = userApp.getUsers();

            //Obtaining data fields from previous Login JSP page
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            //Retrieve session for a user
            User user = (User) session.getAttribute("user");
            session.setAttribute("entryApp", null);
            
            //If the retrieved user session is null or email belongs to an existing user account, begin login verification
            if (user == null || (email != null && !(user.getEmail().equals(email)))) {
                user = users.login(email, password);
            }
            //If the retrieved user session is null but did not pass the login verification, then redirect to the Login JSP page
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
            //Setup a session with the user data that matches
            if (user != null) {
                String name = request.getParameter("name");
                int userID = userApp.getNewUserID();
                session.setAttribute("user", user);
                userApp.saveUsers();
        %>
        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 

        <h1 class="head1">Journals</h1>
        
        <!-- Link to create a new journal under the logged in user -->
        <div id="addJournal">    
            <a href="createJournal.jsp" title="Create a new journal"> + </a>
        </div>
        
        <!-- Display all journals belonging to the user as an image with a link -->
        <div id="journalPosition">
            <% if (user.getJournals().size() > 0) {
                    for (Journal j : user.getJournals()) {
                        %>
                        <div class="journal" onClick="journalClick(this, <%= j.getJournalID()%>)">
                            <img src="journal.png" alt="Journal"/>
                            <p class="journalTitle"> <%= j.getTitle()%> </p>
                        </div>
                    <% }
                }
            } else { %>
            <!-- If none of the above conditions are fulfilled, then display this error message with redirection link -->
            <p><h3 class="head3">Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</h3></p>
            <% }%>
    </div>
    
    <!-- Top navigation bar -->
    <nav role="main">
        <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="userIcon" alt="User Icon"></li>
                <li><div id="usersName"> <%= user.getName()%> </div></li>
                <img src="RedLogo.png" class="logo" alt="Logo">
            </ul>
        </div>
    </nav>
    
    <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
    <div id="background">
        <img src="DBackground.png" class="stretch" alt="background" />
    </div> 
</body>
</html>

<!-- JavaScript code for activating the link of the journal images from earlier in this document-->
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
