<%-- 
    Document   : createJournal
    Created on : 09/09/2017, 10:56:23 PM
    Author     : Max
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Journal</title>
    </head>
    <body>
        <h1>Create Journal</h1>
        <form action="newJournal.jsp" method="post">
            <table>
                <tr>
                    <td>Title: </td>
                    <td><input type="text" name="title"></td>
                </tr>
                <tr>
                    <td>Description: </td>
                    <td><input type="text" name="description"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Create Journal"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
