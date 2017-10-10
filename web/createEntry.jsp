<%-- 
    Document   : createEntry
    Created on : 13/09/2017, 8:07:44 PM
    Author     : Sarah
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
        <nav role="side">
            <ul>
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
                <li><img src="userIcon.png" id="userIcon" alt="User Icon"></li>
                <li><div id="usersName"> <%= user.getName() %> </div></li>
                <img src="RedLogo.png" class="logo" alt="Logo">
            </ul>
            </div>
        </nav>
        
        <h1></h1>  
        
        <p>
            <a href="journals.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            </a>        
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
                        <td id="exitSymbol"><a href="entries.jsp" title="Cancel this entry"> X </a></td>
                    <tr></tr>
                        <td><h2> Entry Title: </h2></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="title" placeholder="Enter title here..." required 
                                   oninvalid="setCustomValidity('Title cannot be blank. Please input a title for this journal entry.')"
                                   oninput="setCustomValidity('')" title="Give this journal entry a title"></td>
                    </tr>
                    <tr>
                        <td><input type="button" onclick="boldFunction()" value="Bold"></button></td>
                        <td><input type="button" onclick="italiseFunction()" value="Italise"></button></td>
                        <td><input type="button" onclick="dPFunction()" value="Dot Point"></button></td>
                
                        <td><textarea name="content" rows="6" placeholder="Enter content here..." id="entryContent" required
                                      oninvalid="setCustomValidity('Please enter content for your journal entry.')"
                                      oninput="setCustomValidity('')"></textarea></td>
                    </tr>
                    <tr>
                        <td colspan="4"><textarea name="content" rows="6" placeholder="Enter content here..." id="entryContent"></textarea></td>
                        <td><input type="submit" value="Save" id="saveBtn" title="Confirm this new entry"></td>
                    </tr>
                    <tr>
                        <td colspan="4"><input type="submit" value="Save" id="saveBtn"></td>
                    </tr>
                </table>
            </div>
        </form>
        
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>   
    </body>
    
    <script>
        function boldFunction(){
            var textToBold = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToBold,'**'+textToBold+'**');
            document.getElementById('entryContent').value = fullText;
        }
         function italiseFunction(){
            var textToBold = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToBold,'*'+textToBold+'*');
            document.getElementById('entryContent').value = fullText;
        }
        function dPFunction(){
            var textToBold = document.getSelection().value.split('\n');
            var fullText = document.getElementById('entryContent').value;
            
            
            
            fullText = fullText.replace(textToBold,'-'+textToBold);
            document.getElementById('entryContent').value = fullText;
        }
    </script>
</html>
