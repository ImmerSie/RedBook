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
        <link href="template.css" rel="stylesheet" type="text/css"/>
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
                
            %>
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="entries.jsp"> Dashboard </a></li>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" class="icon"></li>
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <a href="index.html">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
            
            <h1>Journals</h1>
                
            <div id="addJournal">    
                <a href="createJournal.jsp"> + </a>
            </div>
            
            <div id="journalAddTable">
                <tr>
                <p id="journalIcon">
                <% if(user.getJournals().size() > 0){
                    for(Journal j : user.getJournals()){
                        %><p id="<%= j.getJournalID()%>" onClick="journalClick(this, <%= j.getJournalID()%>)">
                        <img src="journal.png" alt=""/> <%= j.getTitle()%></p><%
                    }
                }
            } else { %>
                </p><p><h3>Incorrect login details. Click <a href="login.jsp">here</a> to return to the login page.</h3></p>
            <% } %>
                </tr>
            </div>
            
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 
            
        <h1></h1>  
        
    </body>
</html>

<script type="text/javascript">
   function journalClick(elmnt, journalID){
       elmnt.style.color = 'red';
       window.location = "../RedBook/entries.jsp?id="+journalID;
   }
   
    //$(document).ready(function(){  });
    /** window.onload = function(){
        function journalClick(Journal j){
            window.location = "../entries.jsp";
            console.log("hit click");
        }
    };**/
</script>
