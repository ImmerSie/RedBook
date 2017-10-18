<%-- 
    Document   : login
    Created on : 09/09/2017, 10:08:01 PM
    Author     : Sarah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%
            String logex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
            String passwordLogex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"; 
            //Setting password and email format, which are the same as the createUser formats
        %>
        <!-- JQuery Tooltips Code Implementation -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $( function() {
                $( document ).tooltip({
                    position: { my: "left+15 center", at: "right center" }
                });
            } );
        </script>
    </head>
    <body>
        <!-- If a user is already logged in, they are redirected to the journals JSP page -->
        <%
            if (((HttpServletRequest) request).getSession().getAttribute("user") != null) {
                ((HttpServletResponse) response).sendRedirect("journals.jsp");
            }
        %>
        
        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="TEST" />
        </div>
        <a href="index.html">
            <img src="WhtLogo.png" class="logo" alt="Logo">
        </a>
        <p>
            <a href="index.html">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            </a>
        </p>

        <!-- Login form for RedBook -->
        <form action="journals.jsp" method="post">
            <div class="userTableDiv">
            <% if(session.getAttribute("error") != null && session.getAttribute("error").equals("invalidLogin")){ %>
                    <tr id="loginDetailErr"><td colspan="1"><p>Invalid login details!</p></td></tr>
            <% } else {
                session.setAttribute("error", null);
            }%>
                <table class="userTable">
                    <tr>
                        <!-- Email address required to be in correct email format -->
                        <td><img src="emailIcon.png" class="Icon" alt="Icon"></td>
                        <td><input type="email" name="email" placeholder="Email Address" required pattern="<%=logex%>"
                               oninvalid="setCustomValidity('Please enter a valid Email Address')" oninput="setCustomValidity('')"
                               title="Email address you used to create an account"></td>
                    </tr>
                    <tr>
                        <!-- Password should follow a secure format including a mix of numbers, upper/lower case letters or other characters -->
                        <td><img src="passwordIcon.png" class="Icon" alt="Icon"></td>
                        <td><input type="password" name="password" placeholder="Password" required pattern="<%=passwordLogex%>"
                               oninvalid="setCustomValidity('Please enter a valid Password')"
                               oninput="setCustomValidity('')" title="Your chosen password when you created an account"/></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <!-- Login button for submitting details and gaining access to RedBook -->
                        <td colspan="2"><input type="submit" class="Button" value="Login"></td>
                    </tr>
                    <tr>
                        <!-- If a user does not have an account, they can quickly be directed to the createUser JSP page -->
                        <td colspan="2"><a href="createUser.jsp"> Not a user yet? Click here.</a></td>
                    </tr>
                </table>
            </div>
        </form>
    </body>
</html>

<!-- Checks for an invalid login attempt and displays alert message -->
<script type="text/javascript">
    var example = document.referrer;
    if (example === "http://localhost:8080/redBook/login.jsp") {
        alert("Invalid Login Attempt");
    }
</script>