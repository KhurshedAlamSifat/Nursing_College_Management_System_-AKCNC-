using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HomePages_LocalHomePage : System.Web.UI.Page
{
    dalHomePageSetup obj = new dalHomePageSetup();
    protected string CampusNo = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CampusNo = Request.QueryString["CampusNo"] ?? "1";

        if (Common.SessionInfo == null)
        {
            Common.SessionInfo = new bdoSessionInfo();
        }
        if (CampusNo == "1")
        {
            Common.SessionInfo.Branch = 1;
        }
        else if (CampusNo == "2")
        {
            Common.SessionInfo.Branch = 2;
        }
        else
        {
            Common.SessionInfo.Branch = 3;
        }
        DataTable dt = obj.GetAll_Active();

        //#Local Notice
        if (dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Local Notice").Any())
        {
            var dt_LocalNotice = dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Local Notice").CopyToDataTable();
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

        //#Text With Image or Video
        if (dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Text With Image" || r.Field<string>("Category") == "Text With Youtube Video").Any())
        {
            var dt_TextWithOthers = dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Text With Image" || r.Field<string>("Category") == "Text With Youtube Video").CopyToDataTable();
            rptrMiddleContents.DataSource = dt_TextWithOthers;
            rptrMiddleContents.DataBind();
        }
        else
        {
            rptrMiddleContents.DataSource = null;
            rptrMiddleContents.DataBind();
        }

        //#Image For Gallery
        if (dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Image For Gallery").Any())
        {
            var dt_ImageForGallery = dt.AsEnumerable().Where(r => r.Field<string>("Category") == "Image For Gallery").CopyToDataTable();
            rptrImageForGallery.DataSource = dt_ImageForGallery;
            rptrImageForGallery.DataBind();
        }
        else
        {
            rptrImageForGallery.DataSource = null;
            rptrImageForGallery.DataBind();
        }
    }
}