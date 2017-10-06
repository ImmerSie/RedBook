<%-- 
    Document   : viewEntry
    Created on : 14/09/2017, 8:24:52 PM
    Author     : Max
--%>

<%@page import="models.EntryHistory"%>
<%@page import="models.User"%>
<%@page import="controllers.EntryController"%>
<%@page import="models.Entry"%>
<%@page import="models.User"%>
<%@page import="models.Journal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page errorPage = "login.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri='http://ur6lad.co.ua/markdown-taglib' prefix ='md' %> 
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Open+Sans" />
        <link href="template.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Entry</title>
        <%User user = (User) session.getAttribute("user");%>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script type="text/javascript" language="javascript" src="viewEntry.js"></script>
        <%
            SimpleDateFormat ft1 = new SimpleDateFormat("dd/MM/yyyy - E - hh:mm aa");
        %>
    </head>
    <body>
        <nav role="side">
            <ul>
                <p></p>
                <li><a href="journals.jsp"> Journals </a></li>
                <li><a href="entries.jsp"> Entries </a></li>
                <li><a href="createEntry.jsp"> Add Journal Entry </a></li>
                <li><a href="help.jsp"> Help </a></li>
            </ul>
        </nav>
        
        <nav role="main">
            <div id= "topNav">
            <ul>
                <li><a href="logout.jsp"> Logout </a></li>
                <li><img src="userIcon.png" id="icon"></li>
                <li><div id="usersName"> <%= user.getName() %>  </div></li>
                <a href="journals.jsp">
                    <img src="RedLogo.png" class="logo" alt="Logo">
                </a>
            </ul>
            </div>
        </nav>
                
               
                
        <h1></h1>  
        
        <p>
            <a href="entries.jsp">
                <img src="backArrow.png" class="backButton" alt="Go Back">
            <a/>        
        </p>

        
        <div id="viewDialog" title="Entry">
            <%  String filePath = application.getRealPath("WEB-INF/entriesHistory.xml");
            %>
            <jsp:useBean id="entryHisApp" class="controllers.EntryHistoryController" scope="session">
                <jsp:setProperty name="entryHisApp" property="filePath" value="<%=filePath%>"/>
            </jsp:useBean>
            <% 
                EntryController entryApp = (EntryController) session.getAttribute("entryApp");
                Journal journal = (Journal) session.getAttribute("journal");
                String parameter = request.getParameter("id");
                Entry entry = null;
                if(parameter != null){
                    entry = journal.getEntry(Integer.parseInt(parameter));
                }
                entryHisApp.setEntry(entry);
            %>
                
                                            <%-- 
                                    VIEW ENTRY
                                --%>
                <div class="table" id="viewEntryTable">
                    <table id="viewEntryData">
                         <input type="hidden" id="entryID" name="entryID" value="<%=entry.getEntryID()%>">
                        </tr>
                    </table>
                                            <%-- 
                                    ENTRY HISTORY
                                --%>
                        
                    <table id="viewHistoryTable"></table>
                    <table id="historyEntryDiv"></table>
                    
                </div>
                <div id="entryHistoryList"></div>             
        </div>
            
        <div id="background">
            <img src="DBackground.png" class="stretch" alt="background" />
        </div> 
            
    </body>
</html>

<script type="text/javascript">   
    $('#entryHistoryList').hide();
    $('#viewHistoryTable').hide();
    
    getEntry();
</script>
