/**
 * Changes between the hidden and non-hidden views
 */
function toggleJournalHistory(){
    // Checks if the current view is "hidden"
    if($('#entryHistoryList').is(':hidden')){
        $('#entryHistoryList').show();
        getEntryHistories()
        $('#historyEntryDiv').show();
        setHistoryEntryDiv();
        $('#viewEntryData').hide();
        $('#toggleHistoryBtn').text('Hide History');
    }
    else{
        $('#entryHistoryList').hide();
        $('#historyEntryDiv').hide();
        setHistoryEntryDiv();
        $('#viewEntryData').show();
        $('#toggleHistoryBtn').text('Show History');
    }
}

function setHistoryEntryDiv(){
    var dateCreated = $('#viewDateCreated').text();
    var dateModified = $('#viewDateModified').text();
    var title = $('#viewEntryTitle').text();
    var content = $('#viewEntryContent').text();
    var entryID = $('#entryID').val();
    
    var html = '';
            
    html = '';
    html += '<tr>';
    html += '<td id="viewDateCreated">' + dateCreated + '</td>';
    html += '<td id="viewDateModified">' + dateModified + '</td>';
    html += '<td><button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()">Hide History</button></td>';
    html += '<td id="X"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryTitle" colspan="5">' + title + '</td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryContent" colspan="5">' + content + '</td>';
    html += '</tr>';
    
    //html += generatePage(entryID, dateCreated, dateModified, title, content);
    
    $('#historyEntryDiv').html(html);
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
    html += '<td id="viewDateCreated">' + dateCreated + '</td>';
    html += '<td id="viewDateModified">' + dateModified + '</td>';
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
    var title = $(elmnt).find('input').eq(0).attr('value');
    var content = $(elmnt).find('input').eq(1).attr('value');
    
    var html = '';
    
    // Set the HTML for the the entry history
    html += '<tr>';
    html += '<td id="viewDateCreated">' + dateCreated + '</td>';
    html += '<td id="viewDateModified">Date Modified: ' + dateModified + '</td>';
    html += '<td><button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()">Hide History</button></td>';
    html += '<td id="X"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryTitle" colspan="5">' + title + '</td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryContent" colspan="5">' + content + '</td>';
    html += '</tr>';

    $('#historyEntryDiv').html(html);
}

function generatePage(entryID, dateCreated, dateModified, title, content){
    var html = '';
  
    html += '<tr>';
    html += '<td id="viewDateCreated" value="' + dateCreated + '">' + dateCreated + '</td>';
    html += '<td id="viewDateModified" value="' + dateModified + '">' + dateModified + '</td> ';
    html += '<td>';
    html += '<button type="button" onClick="editEntry()">Edit</button>';
    html += '</td>';
    html += '<td>';
    html += '<button type="button" id="toggleHistoryBtn" onClick="toggleJournalHistory()">Show History</button>';
    html += '</td>';
    html += '<td>';
    html += '<form action="entryServlet.do" method="GET">';
    html += '<input type="hidden" id="entryID" name="entryID" value="' + entryID + '">';
    html += '<input type="submit" class="button" value="Download">';
    html += '</form>';
    html += '</td>';
    html += '<td id="X"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryTitle" colspan="5"> ' + title + '</td>';
    html += '<tr></tr>';
    html += '<td id="viewEntryContent" colspan="5"> '+ content + ' </td>';
    html += '<td>';
    html += '<input type="hidden" name="entryID" value="' + entryID + '" id="entryID">';
    html += '</td>';
    html += '</tr>';
    return html;
}

function updateEntry(){
    var entryID = $('#entryID').val().toString();
    var title = $('#viewEntryTitle').val().toString();
    var content = $('#entryContent').val().toString();
    
    $.post("entryHistoryServlet.do", {entryID: entryID, title: title, content: content}, function(response){
        var html = '';
        html += generatePage(response['entryID'], 'Date Created: ' + response['dateCreated'], 'Date Modified: ' + response['dateModified'],  response['title'], response['content']);
        $('#viewEntryData').html(html); 
    });
}

function editEntry(){
    var dateCreated = $('#viewDateCreated').text();
    var dateModified = $('#viewDateModified').text();
    var title = $('#viewEntryTitle').text();
    var content = $('#viewEntryContent').text();
    var entryID = $('#entryID').val();
    
    var html = '';
    html += '<tr>';
    html += '<td id="viewDateCreated" name="dateCreated">' + dateCreated + '</td>';
    html += '<td id="viewDateModified" name="dateModified">' + dateModified + '</td>';
    html += '<td>';
    html += '<button type="button" onClick="getEntry()">Cancel Edit</button>';
    html += '</td>';
    html += '<td id="X" onClick="getEntry()"><a href="entries.jsp"> X </a></td>';
    html += '<tr></tr>';
    html += '<td colspan="5"><h2> Entry Title: </h2></td>';
    html += '<tr></tr>';
    html += '<td  colspan="5"><input type="text" value="' + title + '" name="entryTitle" id="viewEntryTitle"></td>';
    html += '<tr>';
    html += '<td colspan="5"><input type="button" onclick="boldFunction()" value="Bold"></button>';
    html += '<input type="button" onclick="italiseFunction()" value="Italics"></button>';
    html += '<input type="button" onclick="Heading1()" value="H1"></button>';
    html += '<input type="button" onclick="Heading2()" value="H2"></button>';
    html += '<input type="button" onclick="Heading3()" value="H3"></button></td>';
    html += '</tr>';
    html += '<td  colspan="5"><textarea name="entryContent" rows="6" id="entryContent">' + content + '</textarea></td>';
    html += '<tr></tr>';
    html += '<td colspan="5"><button id="saveBtn" type="submit" onclick="updateEntry()" value="Save Entry" name="Save Entry">Save Entry</button></td>';
    html += '<tr></tr>';
    html += '<td>';
    html += '<input type="hidden" name="entryID" value="' + entryID + '" id="entryID">';
    html += '</td>';
    html += '<tr></tr>';
    html += '<td>';
    html += '<input type="hidden" name="modified" value="modified" id="modified">';
    html += '</td>';
    html += '</tr>';
    
    $('#viewEntryData').html(html); 
}

function getEntry(){
    var entryID = $('#entryID').val();
    $.get("entryServlet.do", {entryID: entryID, noDownload: "true"}, function(response){
        var html = '';
        html += generatePage(response['entryID'], 'Date Created: ' + response['dateCreated'], 'Date Modified: ' + response['dateModified'],  response['title'], response['content']);
        html = micromarkdown.parse(html);
        $('#viewEntryData').html(html); 
    });
}

function generateHistoryRow(entryHisID, dateModified, title, content){
    var html = '';
    html += '<table>';
    html += '<tr id="' + entryHisID + '" onClick="getEntryHistory(this)">';
    html += '<td >' + dateModified + '</td>';
    html += '<input type="hidden" value="' + title + '">';
    html += '<input type="hidden" value="' + content + '">';
    html += '<input type="hidden" value="' + dateModified + '">';
    html += '</tr>';
    html += '</table>';
    return html;
}

function getEntryHistories(){
    var entryID = $('#entryID').val();
    $.get("entryHistoryServlet.do", {entryID: entryID}, function(response){
        var dateModified = $('#viewDateModified').text();
        var colonIndex = dateModified.indexOf(":");
        var splitDate = dateModified.substring(colonIndex + 2);
        var title = $('#viewEntryTitle').text();
        var content = $('#viewEntryContent').text();
        var dateCreated = $('#viewDateCreated').text();
    
        var html = '';
        
        html += '<div id="historyListHeader"> Entry History </div>';
        html += generateHistoryRow(entryID, splitDate, title, content);
        
        if(jQuery.isEmptyObject(response)){
            html += '<p><h3>You have no entries.</h3></p>';
            html += '<p><h3> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p>';
        }
        else{
            $.each(response, function(key, e){
                html += generateHistoryRow(e.entryHisID, e.dateModified, e.title, e.content);                
            });
        }
        
        $('#entryHistoryList').html(html);        
    });  
}

function boldFunction(){
    var textToBold = document.getSelection();
    var fullText = document.getElementById('entryContent').value;
    fullText = fullText.replace(textToBold,'**'+textToBold+'**');
    document.getElementById('entryContent').value = fullText;
}

 function italiseFunction(){
    var textToItalise = document.getSelection();
    var fullText = document.getElementById('entryContent').value;
    fullText = fullText.replace(textToItalise,'*'+textToItalise+'*');
    document.getElementById('entryContent').value = fullText;
}

function Heading1(){
    var textToH1 = document.getSelection();
    var fullText = document.getElementById('entryContent').value;
    fullText = fullText.replace(textToH1,'#'+ textToH1);
    document.getElementById('entryContent').value = fullText;
}

function Heading2(){
    var textToH2 = document.getSelection();
    var fullText = document.getElementById('entryContent').value;
    fullText = fullText.replace(textToH2,'##'+ textToH2);
    document.getElementById('entryContent').value = fullText;
}

 function Heading3(){
    var textToH3 = document.getSelection();
    var fullText = document.getElementById('entryContent').value;
    fullText = fullText.replace(textToH3,'###'+ textToH3);
    document.getElementById('entryContent').value = fullText;
}

function markdown(content){
    var boldRegex = "\*\*.*\*\*";
    var actualContent = content.replace(content.replace)
    return content.replace(boldRegex,'<')
}