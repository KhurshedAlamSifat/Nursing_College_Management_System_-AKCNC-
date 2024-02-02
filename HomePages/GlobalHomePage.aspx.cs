using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HomePage_GlobalHome : System.Web.UI.Page
{
    dalHomePageSetup obj = new dalHomePageSetup();
    protected string ScrollingMessage = "";
    protected void Page_PreLoad(object sender, EventArgs e)
    {
        if (Common.SessionInfo == null)
        {
            Common.SessionInfo = new bdoSessionInfo();
        }
        Common.SessionInfo.Branch = 1;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Common.SessionInfo == null)
        {
            Common.SessionInfo = new bdoSessionInfo();
        }
        Common.SessionInfo.Branch = 1;
        //#ScrollingMessage
        DataTable dt = obj.GetAll_Active();
        //#Local Notice
        if (dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Global Notice").Any())
        {
            var dt_LocalNotice = dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Global Notice").CopyToDataTable();
            rptNotice.DataSource = dt_LocalNotice;
            rptNotice.DataBind();
            pnlScrollingMessage.Visible = true;
        }
        else
        {
            rptNotice.DataSource = null;
            rptNotice.DataBind();
            pnlScrollingMessage.Visible = false;
        }
    }
}