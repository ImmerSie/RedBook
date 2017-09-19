<%-- 
    Document   : logout
    Created on : 10/10/2016, 12:01:34 AM
    Author     : jack
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
        <%session.invalidate();%>
    </head>
    <body>      
        <a href="index.html">
            <img src="WhtLogo.png" class="logoutLogo" alt="Logo">
        </a>
        
        <div id="journalAddTable">
            <table>
                <tr>
                    <td> You have successfully logged out. </td>
                </tr>
                <tr>
                    <td> Click <a href="index.html">here</a> to return to the homepage. </td>
                </tr>
                    <p></p>
            </table>
        </div>
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div>  
    </body>
</html>
