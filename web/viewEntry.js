/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function toggleJournalHistory(){
    //$('#entryHistoryList').toggle();
    if($('#entryHistoryList').is(':hidden')){
        $('#entryHistoryList').show();
        setViewHistoryTable();
        $('#historyEntryDiv').show();
        $('#viewEntryData').hide();
        $('#toggleHistoryBtn').text('Hide History');
    }
    else{
        $('#entryHistoryList').hide();
        $('#historyEntryDiv').hide();
        $('#viewEntryData').show();
        $('#toggleHistoryBtn').text('Show History');
    }
}

function setViewHistoryTable(){
    var dateModified = $('#viewDateModified').attr('value');
    var dateCreated = $('#viewDateCreated').attr('value');
    var flag = $('#viewFlag').attr('value');
    var title = $('#viewEntryTitle').text();
    var content = $('#viewEntryContent').text();
    
    var html = '';
    
    html += '<tr>';
    html += '<td id="viewDateCreated">Date Created: ' + dateCreated + '</td>';
    html += '<td id="viewDateModified">Date Modified: ' + dateModified + '</td>';
    html += '<td id="viewFlag">Flag: ' + flag + '</td>';
    html += '<td><button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()">Hide History</button></td>';
    html += '<td id="X"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryTitle" colspan="5">' + title + '</td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryContent" colspan="5">' + content + '</td>';
    html += '</tr>';
    
    $('#historyEntryDiv').html(html);
}

function getEntryHistory(elmnt){
    var dateModified = $(elmnt).find('input').eq(2).attr('value');
    var dateCreated = $('#viewDateCreated').attr('value');
    var flag = $('#viewFlag').attr('value');
    var title = $(elmnt).find('input').eq(0).attr('value');
    var content = $(elmnt).find('input').eq(1).attr('value');
    
    var html = '';
    
     html += '<tr>';
    html += '<td id="viewDateCreated">Date Created: ' + dateCreated + '</td>';
    html += '<td id="viewDateModified">Date Modified: ' + dateModified + '</td>';
    html += '<td id="viewFlag">Flag: ' + flag + '</td>';
    html += '<td><button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()">Hide History</button></td>';
    html += '<td id="X"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryTitle" colspan="5">' + title + '</td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryContent" colspan="5">' + content + '</td>';
    html += '</tr>';

    $('#historyEntryDiv').html(html);
}