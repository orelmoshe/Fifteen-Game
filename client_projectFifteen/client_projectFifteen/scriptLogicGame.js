var emptyTabIndex = 15;

function shuffle() {

    var arrShuffle = getArrayShuffle();
    var idCounter = 0;

    for (var i = 0; i < 4; i++) {
        for (var j = 0; j < 4; j++) {

            if (idCounter === 15)
                break;

            // position:
            var but = document.getElementById(idCounter);
            but.style.position = "absolute";
            but.style.top = i * 70 + "px";
            but.style.left = j * 70 + "px";

            // random clolr:
            var R = Math.floor(Math.random() * 256) + 25;
            var G = Math.floor(Math.random() * 256) + 25;
            var B = Math.floor(Math.random() * 256) + 25;
            but.style.backgroundColor = 'rgb(' + R + ',' + G + ',' + B + ')';

            // random text:
            but.value = arrShuffle[idCounter].toString();

            but.tabIndex = idCounter;
            idCounter++;
        }
    }
}

function moveButton(movement) {

    var moveBut = null;

    switch (movement) {
        case "U":
            moveBut = getElementByTabIndex(emptyTabIndex + 4);
            break;
        case "D":
            moveBut = getElementByTabIndex(emptyTabIndex - 4);
            break;
        case "L":
            moveBut = getElementByTabIndex(emptyTabIndex + 1);
            break;
        case "R":
            moveBut = getElementByTabIndex(emptyTabIndex - 1);
            break;
    }

    if (moveBut === null)
        return;

    var i = moveBut.tabIndex;
    var c;
    var k;

    // up
    if (i - 4 >= 0 && i - 4 === emptyTabIndex && movement === "U") {
        for (k = 0; k < 10; k++) setTimeout(function () { moveBut.style.top = parseInt(moveBut.style.top) - 7 + "px"; }, k * 10);
        moveBut.tabIndex = emptyTabIndex;
        emptyTabIndex = i;
        c = parseInt(document.getElementById('Label1').innerHTML) + 1;
        document.getElementById('Label1').innerHTML = c;
    }
    // down
    else if (i + 4 < 16 && i + 4 === emptyTabIndex && movement === "D") {
        for (k = 0; k < 10; k++) setTimeout(function () { moveBut.style.top = parseInt(moveBut.style.top) + 7 + "px"; }, k * 10);
        moveBut.tabIndex = emptyTabIndex;
        emptyTabIndex = i;
        c = parseInt(document.getElementById('Label1').innerHTML) + 1;
        document.getElementById('Label1').innerHTML = c;
    }
    // left
    else if (i - 1 >= 0 && i % 4 !== 0 && i - 1 === emptyTabIndex && movement === "L") {
        for (k = 0; k < 10; k++) setTimeout(function () { moveBut.style.left = parseInt(moveBut.style.left) - 7 + "px"; }, k * 10);
        moveBut.tabIndex = emptyTabIndex;
        emptyTabIndex = i;
        c = parseInt(document.getElementById('Label1').innerHTML) + 1;
        document.getElementById('Label1').innerHTML = c;
    }
    // right
    else if (i + 1 < 16 && (i + 1) % 4 !== 0 && i + 1 === emptyTabIndex && movement === "R") {
        for (k = 0; k < 10; k++) setTimeout(function () { moveBut.style.left = parseInt(moveBut.style.left) + 7 + "px"; }, k * 10);
        moveBut.tabIndex = emptyTabIndex;
        emptyTabIndex = i;
        c = parseInt(document.getElementById('Label1').innerHTML) + 1;
        document.getElementById('Label1').innerHTML = c;
    }

    var nGame = false;
    if (checkWin() === true) {
        nGame = confirm("ניצחת, כל הכבוד! להתחיל משחק חדש?");
        if (nGame === true)
            location.reload();
    }

    if (checkNoSolution() === true) {
        nGame = confirm("הפסדת, לא נורא! להתחיל משחק חדש?");
        if (nGame === true)
            location.reload();
    }
}

function checkWin() {
    for (var i = 0; i < 3; i++) {
        var but = getElementByTabIndex(i);
        if (but === null || parseInt(but.value) !== i + 1)
            return false;
    }
    return true;
}

function checkNoSolution() {
    for (var i = 0; i < 13; i++) {
        var but = getElementByTabIndex(i);
        if (but === null || parseInt(but.value) !== i + 1)
            return false;
    }

    var but13 = getElementByTabIndex(13);
    var but14 = getElementByTabIndex(14);
    if (but13 !== null && but13.value === "15"
        && but14 !== null && but14.value === "14")
        return true;

    return false;
}

function getElementByTabIndex(tabIndex) {
    for (var i = 0; i < 15; i++) {
        var but = document.getElementById(i);
        if (but.tabIndex === tabIndex) {
            return but;
        }
    }
    return null;
}

function clickOnNewGame() {
    location.reload();
}

function getArrayShuffle() {
    var A = new Array();    
    for (var k = 1; k <= 15; k++)
        A.push(k);
    var j, l, i;
    for (i = A.length - 1; i > 0; i--) {
        j = Math.floor(Math.random() * (i + 1));
        l = A[i];
        A[i] = A[j];
        A[j] = l;
    }
    return A;
}