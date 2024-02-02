﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Admin_DecumentEntry : BasePage
{
    dalDocument obj = new dalDocument();
    List<string> CategoryList = new List<string>() { "", "Student-Waiver-Approval" };
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = "/Pages/Admin/" + Path.GetFileName(Request.PhysicalPath) + Request.Url.Query;
        if (SessionManager.SessionName.UserName == null)
        {
            dalCommon.LoginReturnUrl(url);
        }
        else if (!dalCommon.IsPermitted(url))
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["ID"] = (int)0;
            LoadDropdown();
            ClearAll();
            LoadGridView();
        }
    }
    protected void LoadDropdown()
    {
        Common.LoadDropdown(ddlClass, "bs_ClassName", 1, 0);
        ddlCategory.DataSource = CategoryList;
        ddlCategory.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            //int ClassId, int GroupId, int ShiftId, int SectionId, int Sequence, string Title, string FileName, string VisibleFileName, string YoutubeId, string Status, string CreatedBy
            var ClassId = ddlClass.SelectedValue != "" ? Convert.ToInt32(ddlClass.SelectedValue) : 0;
            var Category = ddlCategory.SelectedValue;

            var Title = tbxTitle.Text;

            var FileName = "";
            var VisibleFileName = "";

            if (flFile.HasFile)
            {
                if (ValidImage(flFile) == false)
                {
                    MessageController.Show("Failed. File size is too big.", MessageType.Warning, Page);
                    return;
                }
                else
                {
                    VisibleFileName = flFile.FileName;
                    FileName = Guid.NewGuid().ToString() + "." + VisibleFileName.Split('.').LastOrDefault();
                    flFile.SaveAs(Server.MapPath("~/VariableContent/Document/" + FileName));
                }
            }
            var Status = "Active";
            var resDataTable = obj.InsertDocument(Category, ClassId, Title, FileName, VisibleFileName, Status, SessionManager.SessionName.UserName);
            if (resDataTable.Rows[0][0].ToString() == "yes")
            {
                MessageController.Show(MessageCode.SaveSucceeded, MessageType.Information, Page);
                ClearAll();
                LoadGridView();
            }
            else
            {
                MessageController.Show(resDataTable.Rows[0][2].ToString(), MessageType.Error, Page);
            }
        }
        catch (Exception exception)
        {
            MessageController.Show("Save Failed. Please contact with admin.", MessageType.Error, Page);
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearAll();
    }
    protected void ClearAll()
    {
        ddlClass.SelectedValue = "";
        ddlCategory.SelectedValue = "";

        tbxTitle.Text = "";

    }
    protected void LoadGridView()
    {
        var criteria = "1=1";
        DataTable dt = obj.GetDocumentByCriteria(criteria);
        rptYear.DataSource = dt;
        rptYear.DataBind();
    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        //int ID = Convert.ToInt32(e.CommandArgument);
        //DataTable dt = obj.GetById(ID);
        //if (dt.Rows.Count > 0)
        //{
        //    ddlCategory.SelectedValue = dt.Rows[0]["Category"].ToString();
        //    tbxTitle.Text = dt.Rows[0]["Title"].ToString();
        //    edtrContent.Content = dt.Rows[0]["Content"].ToString();
        //    tbxYoutubeLink.Text = dt.Rows[0]["YoutubeLink"].ToString();
        //    tbxSequence.Text = dt.Rows[0]["Sequence"].ToString();
        //    ddlStatus.SelectedValue = dt.Rows[0]["Status"].ToString();
        //    if (dt.Rows[0]["ImageLink"].ToString() != "")
        //    {
        //        pnlCurrentImage.Visible = true;
        //        imgCurrent.ImageUrl = "~/VariableContent/HomePage/" + dt.Rows[0]["ImageLink"].ToString();
        //    }
        //    else
        //    {
        //        pnlCurrentImage.Visible = false;
        //        imgCurrent.ImageUrl = "";
        //    }
        //}
        //ViewState["ID"] = ID;
        //btnSave.Visible = false;
        //btnEdit.Visible = true;
    }
    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        //int ID = Convert.ToInt32(e.CommandArgument);
        //DataTable dt = obj.GetDocumentById(ID);
        //var fileName = dt.Rows[0]["FileName"].ToString();
        //if (fileName != "")
        //{
        //    if (System.IO.File.Exists(Server.MapPath("/VariableContent/Document/" + fileName)))
        //    {
        //        System.IO.File.Delete(Server.MapPath("/VariableContent/Document/" + fileName));
        //    }
        //}
        //new Common().Delete("bs_Content", ID);
        //MessageController.Show(MessageCode.DeleteSucceeded, MessageType.Information, Page);
        //LoadGridView();
    }


    //# Helper Methods
    protected bool ValidImage(FileUpload file)
    {
        //bool flag = false;
        //string extension = Path.GetExtension(file.FileName).ToLower();
        //if (extension == ".jpeg" || extension == ".jpg" || extension == ".png")
        //{
        //    flag = true;
        //}
        //else if (file.PostedFile.ContentLength < 524288)
        //{
        //    flag = true;
        //}
        //return flag;
        return true;
    }
}

