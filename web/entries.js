/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function getEntries(){
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");
    $.get("hideEntryServlet.do", {sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value}, function(response){
        var html = '';
        if(jQuery.isEmptyObject(response)){
            html += '<p><h3>You have no entries.</h3></p>';
            html += '<p><h3> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p>';
        }
        else{
            $.each(response, function(key, e){
                html += '<div style="overflow-x:auto;">';
                html += '<div class="entryList">';    
                html += '<table>';
                html += '<input type="checkbox" class="entryCheck" name="' +  e.entryID + '" value="' + e.entryID + '">';
                html += '<tr class="entryRow" onClick="entryClick(this, ' + e.entryID + ')">';
                html += '<td></td>';
                html += '<td>' + e.title + '</td>';
                html += '<td></td><td>' + e.content + '</td>';
                html += '<td><p value="<%= e.dateCreated %>">Created: ' + e.dateCreated + '</p></td>';
                html += '<td><p value="<%= e.dateModified %>">Modified: ' + e.dateModified + '</p></td>';
                html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
                html += '<td>' + e.flag + '</td>';
                html += '<td></td><td></td><td>';
                html += '<td>';    
                html += '<button type="button" onClick="hide()">Hide</button>';
                html += '</td>';
                html += '<td><input type="hidden" value="' + e.entryID + '" name="entryID" id="entryID"></td>';
                html += '</tr>';
                html += '</table>';
                html += '</div>';
                html += '</div>';
            });
        }
        
        $('#ajaxEntries').html(html);
    });  
}

function hideEntries(){
    var jsonEntries = [];
    var checkedEntries = document.getElementsByClassName("entryCheck");
    for(var i = 0; i < checkedEntries.length; i++){
        if(checkedEntries.item(i).checked === true){
            jsonEntries.push(checkedEntries.item(i).value);
        }
    }
    
    var json = JSON.stringify(jsonEntries);
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");
    
    $.post("hideEntryServlet.do", {json: json, sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value}, function(response){
        var html = '';
        if(jQuery.isEmptyObject(response)){
            html += '<p><h3>You have no entries.</h3></p>';
            html += '<p><h3> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p>';
        }
        else{
            $.each(response, function(key, e){
                html += '<div style="overflow-x:auto;">';
                html += '<div class="entryList">';    
                html += '<table>';
                html += '<td>';
                html += '<input type="checkbox" class="entryCheck" name="' +  e.entryID + '" value="' + e.entryID + '">';
                html += '<tr class="entryRow" onClick="entryClick(this, ' + e.entryID + ')">';
                html += '<td></td>';
                html += '<td>' + e.title + '</td>';
                html += '<td></td><td>' + e.content + '</td>';
                html += '<td><p value="<%= e.dateCreated %>">Created: ' + e.dateCreated + '</p></td>';
                html += '<td><p value="<%= e.dateModified %>">Modified: ' + e.dateModified + '</p></td>';
                html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
                html += '<td onClick="entryClick(this, ' + e.entryID + ')">' + e.flag + '</td>';
                html += '<td></td><td></td><td>';
                html += '<td>';    
                html += '<button type="button" onClick="hide()">Hide</button>';
                html += '</td>';
                html += '<td><input type="hidden" value="' + e.entryID + '" name="entryID" id="entryID"></td>';
                html += '</tr>';
                html += '</table>';
                html += '</div>';
                html += '</div>';
            });
        }
        $('#ajaxEntries').html(html);
    });
}


function searchBy(){
    var searchDrop = document.getElementById("searchBy");
    var searchValue = searchDrop.options[searchDrop.selectedIndex].value;
    
    if(searchValue === "searchTitle"){
        var html = '';
        
        html += '<input type="text" id="titleSearch" name="titleSearch">';
        html += '<button value="goSearch" onClick="searchByTitle()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';
        
        $('#searchInput').html(html);
    }
    else if(searchValue === "searchContent"){
        var html = '';
        
        html += '<input type="text" id="contentSearch" name="contentSearch">';
        html += '<button value="goSearch" onClick="searchByContent()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';
        
        $('#searchInput').html(html);
    }
    else if(searchValue === "date"){
        var html = '';
        html += '<input type="text" id="datepickerSearch" placeholder="Date...">';
        html += '</td><td><button onClick="removeSearch()">X</button>'; 
        
        $('#searchInput').html(html);
        $('#datepickerSearch').datepicker().on("input change", function(e){
            searchByDate(e.target.value);
            
        });
    }
    else if(searchValue === "searchBetween"){
        var html = '';
        
        html += '<input type="text" id="datepickerFrom" placeholder="Date..."> and <input type="text" id="datepickerTo" placeholder="Date...">';
        //html += '<p>and</p>';
        //html += '<input type="text" id="datepickerTo" placeholder="Date...">';
        html += '<button value="goSearch" onClick="searchBetweenDates()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';
        
        $('#searchInput').html(html);
        $('#datepickerFrom').datepicker();
        $('#datepickerTo').datepicker();
    }
    else{
        removeSearch();
    }
}

function removeSearch(){
    $('#ajaxEntries').show();
    $('#searchResultEntries').html('');
    $('#searchInput').html('');
    document.getElementById("searchBy").selectedIndex = "0";
}

function searchByTitle(){
    var keyword = $('#titleSearch').val().toString().toLowerCase();
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    for(var i = 0; i < row.length; i++){
        var eTitle = $(row.item(i)).find('td').eq(1).text();
        if(eTitle.toLowerCase().indexOf(keyword) >= 0){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eContent = $(row.item(i)).find('td').eq(3).text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';    
            html += '<table>';
            html += '<input type="checkbox" class="entryCheck" name="' +  entryID + '" value="' + entryID + '">';
            html += '<tr onClick="entryClick(this, ' + entryID + ')">';
            html += '<td></td>';
            html += '<td>' + eTitle + '</td>';
            html += '<td></td><td>' + eContent + '</td>';
            html += '<td><p value="<%= e.dateCreated %>">' + eCreated + '</p></td>';
            html += '<td><p value="<%= e.dateModified %>">' + eModified + '</p></td>';
            html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
            html += '<td>' + eFlag + '</td>';
            html += '<td></td><td></td><td>';
            html += '<td>';    
            html += '<button type="button" onClick="hide()">Hide</button>';
            html += '</td>';
            html += '<td><input type="hidden" value="' + entryID + '" name="entryID" id="entryID"></td>';
            html += '</tr>';
            html += '</table>';
            html += '</div>';
            html += '</div>';
        }
    }
    
    if(html.length < 1){
        html += '<h3>You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

function searchByContent(){
    var keyword = $('#contentSearch').val().toString().toLowerCase();
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    for(var i = 0; i < row.length; i++){
        var eContent = $(row.item(i)).find('td').eq(3).text();
        if(eContent.toLowerCase().indexOf(keyword) >= 0){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eTitle = $(row.item(i)).find('td').eq(1).text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';    
            html += '<table>';
            html += '<input type="checkbox" class="entryCheck" name="' +  entryID + '" value="' + entryID + '">';
            html += '<tr onClick="entryClick(this, ' + entryID + ')">';
            html += '<td></td>';
            html += '<td>' + eTitle + '</td>';
            html += '<td></td><td>' + eContent + '</td>';
            html += '<td><p value="<%= e.dateCreated %>">' + eCreated + '</p></td>';
            html += '<td><p value="<%= e.dateModified %>">' + eModified + '</p></td>';
            html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
            html += '<td>' + eFlag + '</td>';
            html += '<td></td><td></td><td>';
            html += '<td>';    
            html += '<button type="button" onClick="hide()">Hide</button>';
            html += '</td>';
            html += '<td><input type="hidden" value="' + entryID + '" name="entryID" id="entryID"></td>';
            html += '</tr>';
            html += '</table>';
            html += '</div>';
            html += '</div>';
        }
    }
    
    if(html.length < 1){
        html += '<h3>You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

function searchByDate(selectedDate){
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    for(var i = 0; i < row.length; i++){
        var eCreated = $(row.item(i)).find('p').eq(0).text();
        var colonIndex = eCreated.toString().indexOf(":");
        var dateSection = eCreated.toString().substring(colonIndex);
        var splitDate = dateSection.split(" ");
        var month = splitDate[0].substring(1);
        var day = splitDate[1].substring(0, splitDate[1].length - 1);
        var year = splitDate[2];
        var rowDate = new Date (month + " " + day + " " + year);
        var searchDate = new Date(selectedDate);
        if(searchDate.getTime() === rowDate.getTime()){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eTitle = $(row.item(i)).find('td').eq(1).text();
            var eContent = $(row.item(i)).find('td').eq(3).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';    
            html += '<table>';
            html += '<input type="checkbox" class="entryCheck" name="' +  entryID + '" value="' + entryID + '">';
            html += '<tr onClick="entryClick(this, ' + entryID + ')">';
            html += '<td></td>';
            html += '<td>' + eTitle + '</td>';
            html += '<td></td><td>' + eContent + '</td>';
            html += '<td><p value="<%= e.dateCreated %>">' + eCreated + '</p></td>';
            html += '<td><p value="<%= e.dateModified %>">' + eModified + '</p></td>';
            html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
            html += '<td>' + eFlag + '</td>';
            html += '<td></td><td></td><td>';
            html += '<td>';    
            html += '<button type="button" onClick="hide()">Hide</button>';
            html += '</td>';
            html += '<td><input type="hidden" value="' + entryID + '" name="entryID" id="entryID"></td>';
            html += '</tr>';
            html += '</table>';
            html += '</div>';
            html += '</div>';
        }
    }
    
    if(html.length < 1){
        html += '<h3>You have no results<h3>';
    }
        
    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}


function searchBetweenDates(){
    var row = document.getElementsByClassName("entryRow");
    var fromDate = $('#datepickerFrom').datepicker("getDate");
    var toDate = $('#datepickerTo').datepicker("getDate");
    var html = '';
    for(var i = 0; i < row.length; i++){
        var eCreated = $(row.item(i)).find('p').eq(0).text();
        var colonIndex = eCreated.toString().indexOf(":");
        var dateSection = eCreated.toString().substring(colonIndex);
        var splitDate = dateSection.split(" ");
        var month = splitDate[0].substring(1);
        var day = splitDate[1].substring(0, splitDate[1].length - 1);
        var year = splitDate[2];
        var rowDate = new Date (month + " " + day + " " + year);
        if(fromDate.getTime() < rowDate.getTime() && toDate.getTime() > rowDate.getTime()){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eTitle = $(row.item(i)).find('td').eq(1).text();
            var eContent = $(row.item(i)).find('td').eq(3).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';    
            html += '<table>';
            html += '<input type="checkbox" class="entryCheck" name="' +  entryID + '" value="' + entryID + '">';
            html += '<tr onClick="entryClick(this, ' + entryID + ')">';
            html += '<td></td>';
            html += '<td>' + eTitle + '</td>';
            html += '<td></td><td>' + eContent + '</td>';
            html += '<td><p value="<%= e.dateCreated %>">' + eCreated + '</p></td>';
            html += '<td><p value="<%= e.dateModified %>">' + eModified + '</p></td>';
            html += '<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>';
            html += '<td>' + eFlag + '</td>';
            html += '<td></td><td></td><td>';
            html += '<td>';    
            html += '<button type="button" onClick="hide()">Hide</button>';
            html += '</td>';
            html += '<td><input type="hidden" value="' + entryID + '" name="entryID" id="entryID"></td>';
            html += '</tr>';
            html += '</table>';
            html += '</div>';
            html += '</div>';
        }
    }
    
    if(html.length < 1){
        html += '<h3>You have no results<h3>';
    }
    
    //$('#searchInput').html(html);
    
    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}
