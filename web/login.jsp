<%-- 
    Document   : login
    Created on : 09/09/2017, 10:08:01 PM
    Author     : Sarah
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%! String passwordLogex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}";%>
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
            if (((HttpServletRequest) request).getSession().getAttribute("user") != null) {
                ((HttpServletResponse) response).sendRedirect("journals.jsp");
            }
        %>
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

        <form action="journals.jsp" method="post">
            <table>
                <tr>
                    <td><img src="emailIcon.png" class="Icon" alt="Icon"></td>
                    <td><input type="email" name="email" placeholder="Email Address" required
                               title="Email address you used to create an account"></td>
                </tr>
                <tr>
                    <td><img src="passwordIcon.png" class="Icon" alt="Icon"></td>
                    <td><input type="password" name="password" placeholder="Password" required pattern="<%=passwordLogex%>"
                               oninvalid="setCustomValidity('Please enter a valid Password')"
                               oninput="setCustomValidity('')" title="Your chosen password when you created an account"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2"><input type="submit" class="Button" value="Login" 
                                           title="Login after you have filled out the above fields"></td>
                </tr>
                <tr>
                    <td colspan="2"><a href="createUser.jsp"> Not a user yet? Click here.</a></td>
                </tr>
            </table>
        </form>
    </body>
</html>

<script type="text/javascript">
    var example = document.referrer;
    if (example === "http://localhost:8080/RedBook/login.jsp") {
        alert("Invalid Login Attempt");
    }
</script>