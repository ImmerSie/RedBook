<%-- 
    Document   : logout
    Created on : 10/10/2016, 12:01:34 AM
    Author     : jack
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
        <%session.invalidate();%>
    </head>
    <body>
        <p>You have been logged out. Click <a href="index.html">here</a> to return to the main page.</p>
    </body>
</html>
