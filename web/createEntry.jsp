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
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="createEntry.js"></script>
        <title>Create Entry</title>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <!-- If a user is not logged in while trying to access this page, they are redirected to the login JSP page -->
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <!-- JQuery Tooltips Code Implementation -->
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
        <!-- Side navigation bar -->
        <nav role="side">
            <ul>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="entries.jsp"> Entries </a></li>
                <li class="current"><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav> 
        
        <!-- Top navigation bar -->
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
        <!--<form action="entries.jsp" method="post">-->
        
        <!-- Journal Entry Creation Form -->
            <div class="newEntry">
                <table>
                     <table style ="width: 100%;">
                    <tr>
                        <!-- Code for date formatting, to put in an easier to understand format -->
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
                        <!-- Title for the journal entry field -->
                        <td><input type="text" name="title" id="createTitleTxt" placeholder="Enter title here..." required 
                                   oninvalid="setCustomValidity('Title cannot be blank. Please input a title for this journal entry.')"
                                   oninput="setCustomValidity('')" title="Give this journal entry a title"></td>
                    </tr>
                    <tr>
                        <td><input type="button" onclick="boldFunction()" value="Bold"></button>
                        <input type="button" onclick="italiseFunction()" value="Italics"></button>
                        <input type="button" onclick="Heading1()" value="H1"></button>
                        <input type="button" onclick="Heading2()" value="H2"></button>
                        <input type="button" onclick="Heading3()" value="H3"></button></td>
                    </tr>
                    <tr>
                        <!-- Text field for the content of the journal entry -->
                        <td colspan="1" ><textarea name="content" placeholder="Enter content here..." id="entryContent" required 
                                      oninvalid="setCustomValidity('Please enter content for your journal entry.')" 
                                      oninput="setCustomValidity('')"></textarea></td>                         
                    </tr>
                    <tr>
                        <!-- Button to confirm creation of a new journal entry -->
                        <!--<td><input type="submit" value="Save" id="saveBtn" title="Confirm this new entry"></td>-->
                        <td><button  value="Save" id="saveBtn" onclick="createEntry()">Save</button></td>
                    </tr>
                </table>
            </div>
        <!--</form type="submit">-->
        
        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
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
            var textToItalise = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToItalise,'*'+textToItalise+'*');
            document.getElementById('entryContent').value = fullText;
        }
        function Heading1(){
            var textToH1 = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToH1,'#'+ textToH1);
            document.getElementById('entryContent').value = fullText;
        }
        function Heading2(){
            var textToH2 = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToH2,'##'+ textToH2);
            document.getElementById('entryContent').value = fullText;
        }
         function Heading3(){
            var textToH3 = document.getSelection();
            var fullText = document.getElementById('entryContent').value;
            fullText = fullText.replace(textToH3,'###'+ textToH3);
            document.getElementById('entryContent').value = fullText;
        }
    </script>
</html>
