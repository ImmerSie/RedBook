<%-- 
    Document   : createEntry
    Created on : 13/09/2017, 8:07:44 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Entry</title>
    </head>
    <body>
        <h1>Create Entry</h1>
        <form action="entries.jsp" method="post">
            <table>
                <tr>
                    <td>Title: </td>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <td>Content </td>
                    <td><textarea name="content" rows="5"></textarea></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Create Entry"></td>
                </tr>
            </table>
        </form>
        <a href="entries.jsp">Return to Entries</a>
    </body>
</html>
