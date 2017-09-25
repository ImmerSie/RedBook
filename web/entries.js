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
                html += '<tr onClick="entryClick(this, ' + e.entryID + ')">';
                html += '<td></td>';
                html += '<td>' + e.title + '</td>';
                html += '<td></td><td>' + e.content + '</td>';
                html += '<td><p>Created:' + e.dateCreated + '</p></td>';
                html += '<td><p>Modified:' + e.dateModified + '</p></td>';
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
                html += '<input type="checkbox" class="entryCheck" name="' +  e.entryID + '" value="' + e.entryID + '">';
                html += '<tr onClick="entryClick(this, ' + e.entryID + ')">';
                html += '<td></td>';
                html += '<td>' + e.title + '</td>';
                html += '<td></td><td>' + e.content + '</td>';
                html += '<td><p>Created:' + e.dateCreated + '</p></td>';
                html += '<td><p>Modified:' + e.dateModified + '</p></td>';
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