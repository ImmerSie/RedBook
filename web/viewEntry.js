/**
 * Changes between the hidden and non-hidden views
 */
function toggleJournalHistory(){
    // Checks if the current view is "hidden"
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

/**
 * Create the HTML to show the Hidden table
 */
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

/**
 * Shows the entry history of a specific entry
 * 
 * @param {type} entry The entry to get the history for
 */
function getEntryHistory(entry){
    // Gets the differeent elements of the entry
    var dateModified = $(entry).find('input').eq(2).attr('value');
    var dateCreated = $('#viewDateCreated').attr('value');
    var flag = $('#viewFlag').attr('value');
    var title = $(entry).find('input').eq(0).attr('value');
    var content = $(entry).find('input').eq(1).attr('value');
    
    var html = '';
    
    // Set the HTML for the the entry history
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