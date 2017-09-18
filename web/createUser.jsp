<%-- 
    Document   : createUser
    Created on : 05/09/2017, 4:00:21 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="authenticateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <title>Create User Account</title>
    </head>
    
    <body>
        <img src="WhtLogo.png" class="logo" alt="Logo">
            <h1>Create User</h1>
            <form action="newUser.jsp" method="post">
            <table>
                <tr>
                    <td>Name: </td>
                    <td><input type="text" name="name"></td>
                </tr>
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
                    <td><input type="submit" value="Sign Up"></td>
                </tr>
            </table>
        </form>
            
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="" />
        </div>
    </body>
</html>
