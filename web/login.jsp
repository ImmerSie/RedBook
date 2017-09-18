<%-- 
    Document   : login
    Created on : 09/09/2017, 10:08:01 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="authenticateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <img src="WhtLogo.png" class="logo" alt="Logo">
            <h1>Login</h1>
            <form action="journals.jsp" method="post">
            <table>
                <tr>
                    <td>Email: </td>
                    <td><input type="email" name="email"></td>
                </tr>
                <tr>
                    <td>Password: </td>
                    <td><input type="password" name="password"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Login"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
