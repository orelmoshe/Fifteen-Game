<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<script src="scriptXmlHttp.js"></script>
<script src="scriptDraw.js"></script>
<script src="scriptLogicGame.js"></script>

<script lang="javascript">
    function init() {
        createXMLHttpRequest();
        initDrawing();
    }
</script>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Haim Halfon & Orel Moshe | Project</title>
    <link href="styleFifteen.css" rel="stylesheet" type="text/css" />
</head>

<body onload="init()">

    <form id="form1" runat="server">
        <div id="topDiv">
            <button id="Button1" onclick="clickOnNewGame()">new game</button>
            <div id="counterDiv">
                <label id="Label1">0</label>
            </div>
        </div>
        <div id="centerDiv" runat="server">
        </div>
    </form>

    <button id="Button2" onclick="clickOnOK()">OK</button>
    <canvas id="can" width="280" height="330"></canvas>
</body>

</html>
