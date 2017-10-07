<%-- 
    Document   : createEntry
    Created on : 13/09/2017, 8:07:44 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage = "login.jsp"%>
<%@page import="models.User"
        import="java.util.Date"
        import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Entry</title>
        <%User user = (User) session.getAttribute("user");%>
        <%! String testempty = ".{}*"; %>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
    </head>
    <body>
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="entries.jsp"> Entries </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="icon"></li>
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
        
        <h1></h1>  
        
        <p>
            <a href="journals.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            <a/>        
        </p>

        <form action="entries.jsp" method="post">
            <div class="newEntry">
                <table>
                    <tr>
                        <%
                            Date entryDate = new Date();
                            SimpleDateFormat ft = new SimpleDateFormat("E - dd/MM/yyyy");
                        %>
                        <td id="date"> <%=ft.format(entryDate)%> </td>
                        <td id="X"><a href="entries.jsp"> X </a></td>
                    <tr></tr>
                        <td><h2> Entry Title: </h2></td>
                    <tr></tr>
                        <td><input type="text" name="title" placeholder="Enter title here..." required 
                                   oninvalid="setCustomValidity('Title cannot be blank. Please input a title for this journal entry.')"
                                   oninput="setCustomValidity('')"></td>
                    </tr>
                    <tr>
                        <td><textarea name="content" rows="6" placeholder="Enter content here..." id="entryContent" required
                                      oninvalid="setCustomValidity('Please enter content for your journal entry.')"
                                      oninput="setCustomValidity('')"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Save" id="saveBtn"></td>
                    </tr>
                </table>
            </div>
        </form>
        
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>
        
        <a href="entries.jsp">Return to Entries</a>
    </body>
</html>