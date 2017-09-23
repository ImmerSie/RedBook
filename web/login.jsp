<%-- 
    Document   : login
    Created on : 09/09/2017, 10:08:01 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
            if(((HttpServletRequest) request).getSession().getAttribute("user") != null){
            ((HttpServletResponse) response).sendRedirect("journals.jsp");
        }%>
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="TEST" />
        </div>
        <a href="index.html">
            <img src="WhtLogo.png" class="logo" alt="Logo">
        </a>
        <p>
            <a href="index.html">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            <a/>
        </p>
        
        <form action="journals.jsp" method="post">
            <table>
                <tr>
                    <td>
                        <img src="emailIcon.png" class="Icon" alt="Icon">
                    </td>
                    <td><input type="email" name="email"></td>
                </tr>
                <tr>
                    <td>
                        <img src="passwordIcon.png" class="Icon" alt="Icon">
                    </td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2">
                        <input type="submit" class="Button" value="Login">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a href="createUser.jsp"> Not a user yet? Click here.</a>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
