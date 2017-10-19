/**
 * Creates the entry row in HTML format
 * 
 * @param {String} entryID the Entry ID of the current entry
 * @param {String} eTitle the Entry Title of the the current entry
 * @param {String} eContent the Entry Content of the current entry
 * @param {String} eCreated the Created Date of the current Entry
 * @param {String} eModified the Last Modified date of the current Entry
 * @param {String} eFlag the Flag of the current entry
 * @param {Boolean} forResultTable if this is for the entry row or not 
 * @returns {String} The HTML format of the entry row
 */
function createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, forResultTable) {
    ///Iniates the HTML varaible with a blank string
    var html = '';
    
    //Adds the surrounding div tags for formatting

    html += '<input type="checkbox" class="entryCheck" name="' +  entryID + '" value="' + entryID + '">';
    
    //Checks if it is for the search results table, else there is different formatting (prevents duplication)
    if(forResultTable){
        html += '<tr onClick="entryClick(this, ' + entryID + ')">';
    }
    else{
       html += '<tr class="entryRow" onClick="entryClick(this, ' + entryID + ')">';
    }
    
    //Adds the actual content of each column as well as the buttons for Visible/hide/Delete
    html += '<td></td>';
    html += '<td>' + eTitle + '</td>';
    html += '<td><input type="hidden" value="' + eContent + '"/></td>';
    html += '<td><p value="' + eCreated + '">' + eCreated + '</p></td>';
    html += '<td><p value="' + eModified + '">' + eModified + '</p></td>';
    html += '<td><input type="hidden" value="' + entryID + '" name="entryID" id="entryID"></td>';
    html += '<td></td>';
    if(eModified === eCreated){
        html += '<td>Unmodified</td>';
    } else {
        html += '<td>Modified</td>';
    }

    html += '<td>';
    //The dropdown list to change the visibility of an entry
    html += '<div class="vis-wrapper">';
    html += '<a class="vis-icon fr" href="#" alt="select visibility" onclick="toggle("vis-dropdown")">...</a>';
    html += '<div id="vis-dropdown">';
    html += '<text class="vis-links" onClick="visiblise(' + entryID + ')">Visible</text></br>';
    html += '<text class="vis-links" onClick="hide(' + entryID + ')">Hidden</text></br>';
    html += '<text class="vis-links" onClick="del(' + entryID + ')">Deleted</text>';
    html += '</td>'

    html += '</tr>';

    //Closes the tags of the table
    html += '</div>';
    html += '</div>';
    html += '</td>';




    //Returns the final HTML string
    return html;
}

/**
 * Changes the Entry's visibility to visibile
 * 
 * @param {String} entryID
 */
function visiblise(entryID) {
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");
    $.post("entryHistoryServlet.do", {sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value, changeTo: "visible", entryID: entryID}, function (response) {
        getEntries();
    });
}

/**
 * Changes the Entry's Hidden property to hidden
 * 
 * @param {String} entryID
 */
function hide(entryID) {
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");
    $.post("entryHistoryServlet.do", {sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value, changeTo: "hidden", entryID: entryID}, function (response) {
        getEntries();
    });
}

/**
 * Changes the Entry's Deletion property to "deleted"
 * 
 * @param {String} entryID
 */
function del(entryID) {
    var html = '<h2>Testing del</h2>';
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");
    $.post("entryHistoryServlet.do", {sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value, changeTo: "deleted", entryID: entryID}, function (response) {
        getEntries();
    });
}

/**
 * Sets All the entries of into a html format so it can be shown on screen
 */
function getEntries() {
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");

    //Sorts and filters the entries repectively
    $.get("hideEntryServlet.do", {sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value}, function (response) {

        // Initialises the HTML string as an empty String
        var html = '';

        // If there are no entries, it tells the user they have no entries
        // and prompts the user to create the first entry
        if (jQuery.isEmptyObject(response)) {
            html += '<p><h3 class="head3">You have no entries.</h3></p>';
            html += '<p><h3 class="head3"> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p>';
        } else {
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';
            html += '<table>';
            $.each(response, function (key, e) {
                // Adds the appropriate HTML for each entry
                html += createEntryRowHTML(e.entryID, e.title, e.content, e.dateCreated, e.dateModified, e.flag, false);
            });

            html += '</table>';
            html += '</div>';
            html += '</div>';
        }

        // Sets the entries html to the new HTML of the entries
        $('#ajaxEntries').html(html);
    });
}

/**
 * Hides the entries which have the "hidden" property
 */
function hideEntries() {
    //Initialises the JSON entries to an empty Array
    var jsonEntries = [];
    var checkedEntries = document.getElementsByClassName("entryCheck");

    // Checks if the entry is checked and adds it to the Array
    for (var i = 0; i < checkedEntries.length; i++) {
        if (checkedEntries.item(i).checked === true) {
            jsonEntries.push(checkedEntries.item(i).value);
        }
    }

    // Changes the Array into a JSON string
    var json = JSON.stringify(jsonEntries);
    var sortingDrop = document.getElementById("sorting");
    var filterDrop = document.getElementById("filter");

    // Hides the "checked" entries and then refreshes the table to only show the 
    // non hidden entries
    $.post("hideEntryServlet.do", {json: json, sorting: sortingDrop.options[sortingDrop.selectedIndex].value, filter: filterDrop.options[filterDrop.selectedIndex].value}, function (response) {
        var html = '';
        if (jQuery.isEmptyObject(response)) {
            html += '<p><h3 class="head3">You have no entries.</h3></p>';
            html += '<p><h3 class="head3"> Click <a href="createEntry.jsp">here</a> to create your first!</h3></p>';
        } else {
            html += '<div style="overflow-x:auto;">';
            html += '<div class="entryList">';
            html += '<table>';

            $.each(response, function (key, e) {
                html += createEntryRowHTML(e.entryID, e.title, e.content, e.dateCreated, e.dateModified, e.flag, false);
            });


            html += '</table>';
            html += '</div>';
            html += '</div>';
        }
        $('#ajaxEntries').html(html);
    });
}

/**
 * Searches the Entry list on a certain criteria and displays the search results
 */
function searchBy() {
    var searchDrop = document.getElementById("searchBy");
    var searchValue = searchDrop.options[searchDrop.selectedIndex].value;

    if (searchValue === "searchTitle") {
        var html = '';

        html += '<input type="text" id="titleSearch" name="titleSearch">';
        html += '<button value="goSearch" onClick="searchByTitle()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
    } else if (searchValue === "searchContent") {
        var html = '';

        html += '<input type="text" id="contentSearch" name="contentSearch">';
        html += '<button value="goSearch" onClick="searchByContent()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
    } else if (searchValue === "date") {
        var html = '';
        html += '<input type="text" id="datepickerSearch" placeholder="Date...">';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
        $('#datepickerSearch').datepicker({
            dateFormat: 'dd/mm/yy'
        }).on("input change", function (e) {
            searchByDate(e.target.value);

        });
    } else if (searchValue === "month") {
        var html = '';
        html += '<input type="text" id="datepickerSearch" placeholder="Month...">';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
        $('#datepickerSearch').datepicker({
            changeMonth: true,
            changeYear: true,
            showButtonPanel: true,
            dateFormat: 'mm/yy',
            onClose: function (dateText, inst) {
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year, month, 1,0,0,0,0));
                }
            }
                ).on("input change", function (e) {
            searchByMonth(e.target.value);

        });
    } else if (searchValue === "year") {
        var html = '';
        html += '<input type="text" id="datepickerSearch" placeholder="Year...">';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
        $('#datepickerSearch').datepicker({
            changeYear: true,
            showButtonPanel: true,
            dateFormat: 'yy',
            onClose: function (dateText, inst) {
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker('setDate', new Date(year,1,1,0,0,0,0));
            }
        }).on("input change", function (e) {
          searchByYear(e.target.value);

        });
    } else if (searchValue === "searchBetween") {
        var html = '';

        html += '<input type="text" id="datepickerFrom" placeholder="Date..."> and <input type="text" id="datepickerTo" placeholder="Date...">';
        html += '<button value="goSearch" onClick="searchBetweenDates()">Go</button>';
        html += '</td><td><button onClick="removeSearch()">X</button>';

        $('#searchInput').html(html);
        $('#datepickerFrom').datepicker();
        $('#datepickerTo').datepicker();
    } else {
        // If nothing is selected, remove the search query
        removeSearch();
    }
}

/**
 * Removes the search query
 */
function removeSearch() {
    $('#ajaxEntries').show();

    // Sets the search results and Input to empty strings
    $('#searchResultEntries').html('');
    $('#searchInput').html('');
    document.getElementById("searchBy").selectedIndex = "0";
}

/**
 * Searches the entries by title and displays the serach results
 */
function searchByTitle() {
    // Set the keyword to lower case to make the search case insensitive
    var keyword = $('#titleSearch').val().toString().toLowerCase();
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    var content = false;
    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';

    // Searches every entry in the table
    for (var i = 0; i < row.length; i++) {
        var eTitle = $(row.item(i)).find('.eTitle').text();

        // If the search matches, add the entry to the search table
        if (eTitle.toLowerCase().indexOf(keyword) >= 0) {
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();

            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
            content = true;
        }

    }
    html += '</table>';
    html += '</div>';
    html += '</div>';

    // If no results have come, display message "You have no results"
    if (!content) {
        html = '<h3 class="head3">You have no results<h3>';
    }

    // Hide the current table and show the search result table
    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

/**
 * Searches the table by content and displays the results
 */
function searchByContent() {
    // Content search is case insensitive
    var keyword = $('#contentSearch').val().toString().toLowerCase();
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    var content = false;

    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';
    for (var i = 0; i < row.length; i++) {
        var eContent = $(row.item(i)).find('.eContent').text();
        if (eContent.toLowerCase().indexOf(keyword) >= 0) {
           var entryID = $(row.item(i)).find('input').eq(0).val();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();



            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
            content = true;
           
        }
    }

    html += '</table>';
    html += '</div>';
    html += '</div>';
    if (!content) {
        html = '<h3 class="head3">You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

/**
 * Searches the table if it is within 2 dates and displays the results
 * 
 * @param {Date} selectedDate the Date the user has searched for
 */
function searchByDate(selectedDate) {
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';
    var content = false;

    for (var i = 0; i < row.length; i++) {
        // Converts the date as a string to a Date Object
        var eCreated = $(row.item(i)).find('.eCreated').text();
        var commaIndex = eCreated.toString().indexOf(",");
        var dateMonth = eCreated.toString().substring(0, commaIndex);
        var year = eCreated.toString().substring(commaIndex + 2, commaIndex + 6);
        var splitDate = dateMonth.split(" ");
        var month = splitDate[0];
        var day = splitDate[1];
        var rowDate = new Date (month + " " + day + " " + year);
        
        // Sets the search Date as a Date Object
        var dateParts = selectedDate.split("/");
        var searchDate = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);
        if (searchDate.getTime() === rowDate.getTime()) {
           var entryID = $(row.item(i)).find('input').eq(0).val();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();

            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
            content = true;
        }
    }
    html += '</table>';
    html += '</div>';
    html += '</div>';

    if (!content) {
        html += '<h3 class="head3">You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

/**
 * Searches the for a month via calender format
 * 
 * @param {Date} selectedMonth the Date the user has searched for
 */
function searchByMonth(selectedMonth) {
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';
    var content = false;
    
    //

    for (var i = 0; i < row.length; i++) {
        // Converts the date as a string to a Date Object
        var eCreated = $(row.item(i)).find('.eCreated').text();
        var commaIndex = eCreated.toString().indexOf(",");
        var dateMonth = eCreated.toString().substring(0, commaIndex);
        var year = eCreated.toString().substring(commaIndex + 2, commaIndex + 6);
        var splitDate = dateMonth.split(" ");
        var month = splitDate[0];
        var day = splitDate[1];
        var rowDate = new Date (month + " " + day + " " + year);
        
        // Sets the search Date as a Date Object
        var searchDate = new Date(selectedMonth);
        if(searchDate.getYear() === rowDate.getYear() && searchDate.getMonth() === rowDate.getMonth()){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eTitle = $(row.item(i)).find('td').eq(1).text();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();

            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
            content = true;
        }       
    }
    html += '</table>';
    html += '</div>';
    html += '</div>';

    if (!content) {
        html += '<h3 class="head3">You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

/**
 * Searches the for via year through a calender format
 * 
 * @param {Date} selectedMonth the Date the user has searched for
 */
function searchByYear(selectedYear) {
    var row = document.getElementsByClassName("entryRow");
    var html = '';
    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';
    var content = false;
    
    //

    for (var i = 0; i < row.length; i++) {
        // Converts the date as a string to a Date Object
        var eCreated = $(row.item(i)).find('.eCreated').text();
        var commaIndex = eCreated.toString().indexOf(",");
        var dateMonth = eCreated.toString().substring(0, commaIndex);
        var year = eCreated.toString().substring(commaIndex + 2, commaIndex + 6);
        var splitDate = dateMonth.split(" ");
        var month = splitDate[0];
        var day = splitDate[1];
        var rowDate = new Date (month + " " + day + " " + year);
        
        // Sets the search Date as a Date Object
        var searchDate = new Date(selectedYear);
        if(searchDate.getYear() === rowDate.getYear()){
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eTitle = $(row.item(i)).find('td').eq(1).text();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();


            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
            content = true;



        }
       
    }
     html += '</table>';
        html += '</div>';
        html += '</div>';

    if (!content) {
        html += '<h3 class="head3">You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

/**
 * Searches the entries between 2 dates and displays the results
 */
function searchBetweenDates() {
    var row = document.getElementsByClassName("entryRow");

    // Gets the dates from the datepicker
    var fromDate = $('#datepickerFrom').datepicker("getDate");
    var toDate = $('#datepickerTo').datepicker("getDate");
    var html = '';
    html += '<div style="overflow-x:auto;">';
    html += '<div class="entryList">';
    html += '<table>';
    var content = false;
    for (var i = 0; i < row.length; i++) {
         var eCreated = $(row.item(i)).find('.eCreated').text();
         var commaIndex = eCreated.toString().indexOf(",");
        var dateMonth = eCreated.toString().substring(0, commaIndex);
        var year = eCreated.toString().substring(commaIndex + 2, commaIndex + 6);
        var splitDate = dateMonth.split(" ");
        var month = splitDate[0];
        var day = splitDate[1];
        var rowDate = new Date (month + " " + day + " " + year);
        
        // Checks if the entry date is in between the 2 dates of the search criteria
        if (fromDate.getTime() < rowDate.getTime() && toDate.getTime() > rowDate.getTime()) {
            var entryID = $(row.item(i)).find('input').eq(0).val();
            var eContent = $(row.item(i)).find('p.eContent').text();
            var eCreated = $(row.item(i)).find('p').eq(0).text();
            var eModified = $(row.item(i)).find('p').eq(1).text();
            var eFlag = $(row.item(i)).find('td').eq(14).text();

            html += createEntryRowHTML(entryID, eTitle, eContent, eCreated, eModified, eFlag, true);
        }
    }

     html += '</table>';
        html += '</div>';
        html += '</div>';

    if (!content) {
        html += '<h3 class="head3">You have no results<h3>';
    }

    $('#ajaxEntries').hide();
    $('#searchResultEntries').html(html);
}

function cancelJournalEdit() {
    $('#journalDetails').show();
    $('#editJournal').hide();
    $('#editJournal').html('');

}

function updateJournal() {
    var title = $('#journalDetTitleInput').val();
    var description = $('#journalDetDescInput').val();
    var journalID = $('#journalID').val();
    var userID = $('#userID').val();

    $.post("journalServlet.do", {userID: userID, journalID: journalID, title: title, description: description}, function (response) {
        $('#journalDetTitle').text(response['title']);
        $('#journalDetDesc').text(response['description']);
        cancelJournalEdit();
    });

}

function editJournal() {
    var title = $('#journalDetTitle').text();
    var description = $('#journalDetDesc').text();

    $('#journalDetails').hide();

    var html = '';
    html += '<div class="modal-content">';
    html += '<div class="modal-header">';
    html += '<h2 class="head2">Edit Journal Details</h2>';
    html += '</div>';
    html += '<div class="modal-body">';
    html += '<h3 class="head3">Title: </h3><input type="text" id="journalDetTitleInput" value="' + title + '"></br>';
    html += '<h3 class="head3">Description: </h3><input id="journalDetDescInput" value="' + description + '">';
    html += '</div>';
    html += '<div class="modal-footer">';
    html += '<button class="editJournalDetSaveBtn" onClick="updateJournal()">Save</button>';
    html += '<button class="editJournalDetCancelBtn" onClick="cancelJournalEdit()">Cancel</button>';
    html += '</div>';
    html += '</div>';

    $('#editJournal').show();
    $('#editJournal').html(html);

}