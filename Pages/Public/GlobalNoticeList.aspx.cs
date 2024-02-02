using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Public_GlobalNoticeList : Page
{
    dalHomePageSetup obj = new dalHomePageSetup();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            LoadData();
        }
    }

    #region Load All Dropdown
  
    #endregion
    protected void LoadData()
    {
        DataTable dt = obj.GetAll_Active();
        if (dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Global Notice").Any())
        {
            var dt_LocalNotice = dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Global Notice").CopyToDataTable();
            rptNotice.DataSource = dt_LocalNotice;
            rptNotice.DataBind();
        }
        else
        {
            rptNotice.DataSource = null;
            rptNotice.DataBind();
        }
    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {

    }
}