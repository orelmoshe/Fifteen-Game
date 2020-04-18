var finalUrl = "http://localhost:57050/Handler.ashx";

var xmlHttp;

function createXMLHttpRequest() {
    try {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    catch (e) {
        try {
            xmlHttp = new XMLHttpRequest();
        }
        catch (e) {
            xmlHttp = null;
        }
    }
}

function clickOnOK() {

    var url = finalUrl
        + "?numOfClick=" + numOfClick
        + "&list1_x=" + list1_x + "&list1_y=" + list1_y
        + "&list2_x=" + list2_x + "&list2_y=" + list2_y;

    xmlHttp.open("GET", url, true);
    xmlHttp.onreadystatechange = getResponse;
    xmlHttp.send();    
}

function getResponse() {
    if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
        if (xmlHttp.responseText === "X") {
            alert("!הציור שציירת לא נראה כמו חץ, נסה שנית");
        }
        else {
            moveButton(xmlHttp.responseText);
        }   
        clear();
    }
}