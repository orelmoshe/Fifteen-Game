using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Button[] arrButtons = new Button[15];

        for (short i = 0; i < 15; i++)
        {
            arrButtons[i] = new Button();
            arrButtons[i].ID = i.ToString();
            arrButtons[i].CssClass = "butGame";
            arrButtons[i].Attributes.Add("onclick", "return false;");
            centerDiv.Controls.Add(arrButtons[i]);
        }

        ClientScript.RegisterStartupScript(typeof(Page), "shuffle", "<script>javascript:shuffle();</script>");
    }
}