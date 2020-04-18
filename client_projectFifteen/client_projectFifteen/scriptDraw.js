var canvas;
var ctx;
var flag = false;
var prevX = 0;
var currX = 0;
var prevY = 0;
var currY = 0;
var dot_flag = false;
var x = "#232a34";
var y = 2;

var numOfClick = 0;

var list1_x = "";
var list1_y = "";
var list2_x = "";
var list2_y = "";

function initDrawing() {
    canvas = document.getElementById('can');
    ctx = canvas.getContext("2d");
    w = canvas.width;
    h = canvas.height;
    canvas.addEventListener("mousedown", function (e) { findxy('down', e); }, false);
    canvas.addEventListener("mousemove", function (e) { findxy('move', e); }, false);
    canvas.addEventListener("mouseup", function (e) { findxy('up', e); }, false);
    canvas.addEventListener("mouseout", function (e) { findxy('out', e); }, false);
}

function findxy(res, e) {
    if (res === 'down') {

        numOfClick++;

        prevX = currX;
        prevY = currY;
        currX = e.clientX - canvas.offsetLeft;
        currY = e.clientY - canvas.offsetTop;

        flag = true;
        dot_flag = true;
        if (dot_flag) {
            ctx.beginPath();
            ctx.fillStyle = x;
            ctx.fillRect(currX, currY, 2, 2);
            ctx.closePath();
            dot_flag = false;
        }
    }
    if (res === 'up' || res === "out") {
        flag = false;
    }
    if (res === 'move') {
        if (flag) {
            prevX = currX;
            prevY = currY;
            currX = e.clientX - canvas.offsetLeft;
            currY = e.clientY - canvas.offsetTop;
            if (numOfClick === 1) {
                list1_x += Math.floor(currX).toString() + "_";
                list1_y += Math.floor(currY).toString() + "_";
            }
            if (numOfClick === 2) {
                list2_x += Math.floor(currX).toString() + "_";
                list2_y += Math.floor(currY).toString() + "_";
            }
            draw();
        }
    }
}

function draw() {
    ctx.beginPath();
    ctx.moveTo(prevX, prevY);
    ctx.lineTo(currX, currY);
    ctx.strokeStyle = x;
    ctx.lineWidth = y;
    ctx.stroke();
    ctx.closePath();
}

function clear() {
    ctx.clearRect(0, 0, w, h);
    numOfClick = 0;
    list1_x = "";
    list1_y = "";
    list2_x = "";
    list2_y = "";
}