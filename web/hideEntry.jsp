<%-- 
    Document   : hideEntry
    Created on : 18/09/2017, 9:09:10 PM
    Author     : Max
--%>

    <%  String filePath = application.getRealPath("WEB-INF/entries.xml");
    %>
    <jsp:useBean id="entryApp" class="controllers.EntryController" scope="application">
        <jsp:setProperty name="entryApp" property="filePath" value="<%=filePath%>"/>
    </jsp:useBean>
    <%
        entryApp.hideEntry();
    %>


<!--<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>-->
