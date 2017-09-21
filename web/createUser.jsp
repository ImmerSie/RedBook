<%-- 
    Document   : createUser
    Created on : 05/09/2017, 4:00:21 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User Account</title>
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
            <a/>        
        </p>
        
            <form action="newUser.jsp" method="post">
            <table>
                <tr>
                    <td>
                       <img src="userIcon.png" class="Icon" alt="User Icon"> 
                    </td>
                    <td><input type="text" name="name"></td>
                </tr>
                <tr>
                    <td>
                        <img src="emailIcon.png" class="Icon" alt="Email Icon">
                    </td>
                    <td><input type="email" name="email"></td>
                </tr>
                <tr>
                    <td>
                        <img src="passwordIcon.png" class="Icon" alt="Password Icon">
                    </td>
                    <td><input type="password" name="password"></td>
                </tr>
   
                <tr>
                    <td></td>
                    <td><input type="submit" value="Sign Up"></td>
                </tr>
                <tr>
                        <td colspan="2"> 
                            <a href="login.jsp">
                                Already a user? Click here.
                            </a>
                        </td>
                </tr>
            </table>
        </form>
            
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
