using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Admin_DocumentDownload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!string.IsNullOrEmpty(Request.QueryString["FileName"]))
            {
                var FileName = Request.QueryString["FileName"];
                var VisibleFileName = Request.QueryString["VisibleFileName"];
                //Int64 FgIqcFileId = Convert.ToInt64(Request.QueryString["FgIqcFileId"]);
                //var FgIqcFile = new FgIqcDa(false).GetFgIqcFileById(FgIqcFileId);
                FileInfo file = new FileInfo(Server.MapPath("~/VariableContent/Document/" + FileName));
                if (file.Exists)
                {
                    Response.Clear();
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + VisibleFileName);
                    Response.AddHeader("Content-Length", file.Length.ToString());
                    Response.ContentType = "text/plain";
                    Response.Flush();
                    Response.TransmitFile(file.FullName);
                }
            }
            else if (!string.IsNullOrEmpty(Request.QueryString["FileId"]))
            {
                var FileId = Request.QueryString["FileId"];
                var dt = new dalDocument().GetDocumentById(Convert.ToInt32(FileId));
                if (dt.Rows.Count > 0)
                {
                    var VisibleFileName = dt.Rows[0]["VisibleFileName"];
                    //Int64 FgIqcFileId = Convert.ToInt64(Request.QueryString["FgIqcFileId"]);
                    //var FgIqcFile = new FgIqcDa(false).GetFgIqcFileById(FgIqcFileId);
                    FileInfo file = new FileInfo(Server.MapPath("~/VariableContent/Document/" + dt.Rows[0]["FileName"]));
                    if (file.Exists)
                    {
                        Response.Clear();
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + VisibleFileName);
                        Response.AddHeader("Content-Length", file.Length.ToString());
                        Response.ContentType = "text/plain";
                        Response.Flush();
                        Response.TransmitFile(file.FullName);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
}