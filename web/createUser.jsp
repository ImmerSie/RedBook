<%-- 
    Document   : createUser
    Created on : 05/09/2017, 4:00:21 PM
    Author     : Sarah
--%>

<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Creating regular expression patterns which are used as input field formats for accepted data -->
<%!
    String regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
    String passwordRegex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}";
%>

<html>
    <head>
        <!-- CSS Stylesheet setup -->
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User Account</title>
        <!-- If a user is currently logged in, they are redirected to the journals JSP page -->
        <%
            if (((HttpServletRequest) request).getSession().getAttribute("user") != null) {
                ((HttpServletResponse) response).sendRedirect("journals.jsp");
            }
        %>
        <!-- JQuery Tooltips Code Implementation -->
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        /<script>
            /*
            $( function() {
                $( document ).tooltip();
            } );*/
        </script>
    </head>

    <body>
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
        
        <!-- Registration form to create an account for RedBook-->
        <form action="newUser.jsp" method="post">
            <table>
                <tr>
                    <!-- User's full name, display name or username -->
                    <td><img src="userIcon.png" class="Icon" alt="User Icon"></td>
                    <td><input type="text" name="name" placeholder="Full Name" required 
                               oninvalid="setCustomValidity('Please enter your name')" oninput="setCustomValidity('')"
                               title="Enter your full name or username"></td>
                </tr>
                <tr>
                    <!-- Email address required to be in correct email format -->
                    <td><img src="emailIcon.png" class="Icon" alt="Email Icon"></td>
                    <td><input type="email" name="email" placeholder="Email Address" required pattern="<%=regex%>" autocomplete="on" 
                               oninvalid="setCustomValidity('Please enter a valid Email Address')" oninput="setCustomValidity('')" 
                               onchange="setCustomValidity('')" title="Enter an email address to connect to your account"></td>

                </tr>
                <tr>
                    <!-- Password should follow a secure format including a mix of numbers, upper/lower case letters or other characters -->
                    <td><img src="passwordIcon.png" class="Icon" alt="Password Icon"></td>
                    <td><input type="password" name="password" placeholder="Password" required pattern="<%=passwordRegex%>"
                               oninvalid="setCustomValidity('Password must contain at least 6 characters, 1 uppercase, 1 lowercase and 1 number')"
                               oninput="setCustomValidity('')" onchange="setCustomerValidity('')"
                               title="Create a password to secure your account"/></td>
                </tr>
                <tr>
                    <!-- Submission button for creating an account -->
                    <td></td>
                    <td><input type="submit" value="Sign Up" 
                               title="Create your account after you have filled out the above fields"></td>
                </tr>
                <tr>
                    <!-- If a user already has a registered account, they can be quickly linked to the Login JSP page -->
                    <td colspan="2"> 
                        <a href="login.jsp">
                            Already a user? Click here.
                        </a>
                    </td>
                </tr>
            </table>
        </form>

        <!-- Setting the background image to fit different web browser and screen sizes by stretching -->
        <style>
            body {
                background-image: url("DBackground.png");
            }
        </style>
        
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="" />
        </div>
    </body>
</html>
