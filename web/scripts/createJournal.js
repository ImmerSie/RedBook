/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function createJournal(){
    var title = $('#createJournalTitle').val().toString();
    var description = $('#createJournalDesc').val().toString();
    var userID = $('#createJournalUserID').val().toString(); 
    
    $.post("journalServlet.do", {userID: userID, title: title, description: description}, function(response){
        var journalID = response['journalID'];
        var currentURL = window.location.href;
        if(currentURL.indexOf('createJournal') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('createJournal'));
        }
       window.location = currentURL + "entries.jsp?id=" + journalID;
    });
}
