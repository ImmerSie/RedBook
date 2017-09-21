/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function getXMLHttpRequest() {
	var xmlHttpReq = false;
	// to create XMLHttpRequest object in non-Microsoft browsers
	if (window.XMLHttpRequest) {
		xmlHttpReq = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		try {
			// to create XMLHttpRequest object in later versions
			// of Internet Explorer
			xmlHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (exp1) {
			try {
				// to create XMLHttpRequest object in older versions
				// of Internet Explorer
				xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (exp2) {
				xmlHttpReq = false;
			}
		}
	}
	return xmlHttpReq;
}

function hideEntries() {
        var jsonEntries = [];
        var checkedEntries = document.getElementsByClassName("entryCheck");
        for(var i = 0; i < checkedEntries.length; i++){
            if(checkedEntries.item(i).checked === true){
                jsonEntries.push(checkedEntries.item(i).value);
            }
        }
        var json = JSON.stringify(jsonEntries);
	var xmlHttpRequest = getXMLHttpRequest();
	xmlHttpRequest.onreadystatechange = getReadyStateHandler(xmlHttpRequest);
	xmlHttpRequest.open("POST", "hideEntryServlet.do", true);
	xmlHttpRequest.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
        xmlHttpRequest.setRequestHeader("Content-length", json.length);
        xmlHttpRequest.setRequestHeader("Connection", "close");
	xmlHttpRequest.send(json);
}

function getReadyStateHandler(xmlHttpRequest) {

	// an anonymous function returned
	// it listens to the XMLHttpRequest instance
	return function() {
		if (xmlHttpRequest.readyState == 4) {
			if (xmlHttpRequest.status == 200) {
                                window.parent.location = window.parent.location.href;
			} else {
				alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
			}
		}
	};
}

