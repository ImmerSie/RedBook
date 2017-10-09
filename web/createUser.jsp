<%-- 
    Document   : createUser
    Created on : 05/09/2017, 4:00:21 PM
    Author     : Max
--%>

<%@page import="javax.mail.internet.AddressException"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%!
   String regex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$";
   String passwordRegex = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{6,}";
    %>

<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="loginAndCreateUser.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User Account</title>
        <%
            if(((HttpServletRequest) request).getSession().getAttribute("user") != null){
            ((HttpServletResponse) response).sendRedirect("login.jsp");
        }%>
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
                    <td><input type="text" name="name" placeholder="Full Name" required="required"></td>
                </tr>
                <tr>
                    <td>
                        <img src="emailIcon.png" class="Icon" alt="Email Icon">
                    </td>
                    <td><input type="email" name="email" placeholder="Email Address" required="required" pattern="<%=regex%>" autocomplete="on" 
                                oninvalid="setCustomValidity('Please enter a valid Email Address ')" oninput="setCustomValidity('')" onchange="setCustomerValidity('')"
                                ></td>
                    
                </tr>
                <tr>
                    <td>
                        <img src="passwordIcon.png" class="Icon" alt="Password Icon">
                    </td>
                    <td><input type="password" name="password" placeholder="Password" required="required" pattern="<%=passwordRegex%>"
                               oninvalid="setCustomValidity('Password must contain atleast 6 characters, 1 Uppercase, 1 lowercase and 1 number')"
                               oninput="setCustomValidity('')" onchange="setCustomerValidity('')"/></td>
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
