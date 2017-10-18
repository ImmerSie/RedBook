/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function createEntry(){
    var dateModified = $('#date').text();
    var title = $('#createTitleTxt').val().toString();
    var content = $('#entryContent').val().toString();
    
    $.post("entryServlet.do", {dateModified: dateModified, title: title, content: content}, function(response){
        var currentURL = window.location.href;
        if(currentURL.indexOf('createEntry') > 0){
            currentURL = currentURL.substring(0, currentURL.indexOf('createEntry'));
        }
       window.location = currentURL + "entries.jsp";
    });
}

