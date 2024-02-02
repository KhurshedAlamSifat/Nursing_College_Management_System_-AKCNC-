﻿using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_FeePaymentModule_ManageStudentFeeMappingWithWaiver : BasePage
{
    dalFeePayment dal = new dalFeePayment();
    protected static bool _cbx_StudentFeeMapping_IsActive_Common = false;
    protected static bool _cbx_Mapping_WillSave_Common = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = "/Pages/FeePaymentModule/" + Path.GetFileName(Request.PhysicalPath) + Request.Url.Query;
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
            //btnSave.CssClass = Common.SessionInfo.Button;
            //btnEdit.CssClass = Common.SessionInfo.Button;
            LoadInitialData();
            //LoadListData();
        }
    }

    void LoadInitialData()
    {
        ddlClass.DataSource = new Common().GetAll("bs_ClassName");
        ddlClass.DataBind();
        ddlClass.Items.Insert(0, new ListItem("---Please Select---", ""));

        ddlAdmissionSession.DataSource = new dalCommon().GetByQuery("select * from ss_AdmissionSession where IsActive = 'Active' order by AdmissionSession desc;");
        ddlAdmissionSession.DataBind();
        ddlAdmissionSession.Items.Insert(0, new ListItem("---Please Select---", ""));
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            ddlFeeHead.Items.Clear();
            if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
            {
                ddlFeeHead.DataSource = new dalCommon().GetByQuery("select * from acc_FeeHead where IsActive = 'Active' AND (ClassId = " + ddlClass.SelectedValue + " OR ClassId is null) " +
                    "and IsActive_ForWaiver = 'Active' order by PriorityOrder;");
                ddlFeeHead.DataBind();
                ddlFeeHead.Items.Insert(0, new ListItem("---Please Select---", ""));
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlAdmissionSession.SelectedValue))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Session is required')", true);
            return;
        }
        if (string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Class is required')", true);
            return;
        }
        if (string.IsNullOrEmpty(ddlFeeHead.SelectedValue))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Fee Heaed is required')", true);
            return;
        }
        DataTable dt = dal.StudentFeeMapping_Setup_GetByCriteria(
            AdmissionSession: ddlAdmissionSession.SelectedValue,
            ClassId: ddlClass.SelectedValue,
            FeeHeadId: ddlFeeHead.SelectedValue,
            RegistrationNumber: tbxRegNo.Text
            );
        if (dt.Rows.Count > 0)
        {
            gvList.DataSource = dt;
            gvList.DataBind();
        }
        else
        {
            gvList.DataSource = null;
            gvList.DataBind();
        }
    }
    protected void btnToggleIsActive_Click(object sender, EventArgs e)
    {
        _cbx_StudentFeeMapping_IsActive_Common = !_cbx_StudentFeeMapping_IsActive_Common;
        foreach (GridViewRow row in gvList.Rows)
        {
            CheckBox chkcheck = (CheckBox)row.FindControl("cbx_StudentFeeMapping_IsActive");
            chkcheck.Checked = _cbx_StudentFeeMapping_IsActive_Common;
        }
    }
    protected void btnToggleWillSave_Click(object sender, EventArgs e)
    {
        _cbx_Mapping_WillSave_Common = !_cbx_Mapping_WillSave_Common;
        foreach (GridViewRow row in gvList.Rows)
        {
            CheckBox chkcheck = (CheckBox)row.FindControl("cbx_WillSave");
            chkcheck.Checked = _cbx_Mapping_WillSave_Common;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in gvList.Rows)
        {
            CheckBox cbx_WillSave = (CheckBox)row.FindControl("cbx_WillSave");
            var lbl_Fee_DefaultAmount = (Label)row.FindControl("lbl_Fee_DefaultAmount");
            var lbl_Comment = (Label)row.FindControl("lbl_Comment");
            var lbl_StudentId = (Label)row.FindControl("lbl_StudentId");
            var lbl_SessionFeeMapping_Id = (Label)row.FindControl("lbl_SessionFeeMapping_Id");
            var lbl_StudentFeeMapping_Id = (Label)row.FindControl("lbl_StudentFeeMapping_Id");
            var tbx_StudentFeeMapping_AppliedAmount_New = (TextBox)row.FindControl("tbx_StudentFeeMapping_AppliedAmount_New");
            var tbx_StudentFeeMapping_ApprovalId = (TextBox)row.FindControl("StudentFeeMapping_ApprovalId");
            var cbx_StudentFeeMapping_IsActive = (CheckBox)row.FindControl("cbx_StudentFeeMapping_IsActive");

            if (Convert.ToDecimal(lbl_Fee_DefaultAmount.Text) != Convert.ToDecimal(tbx_StudentFeeMapping_AppliedAmount_New.Text) && string.IsNullOrEmpty(tbx_StudentFeeMapping_ApprovalId.Text))
            {
                lbl_Comment.Text = "Required Apploval Id";
                continue;
            }
            if (lbl_Fee_DefaultAmount.Text != tbx_StudentFeeMapping_AppliedAmount_New.Text && !string.IsNullOrEmpty(tbx_StudentFeeMapping_ApprovalId.Text))
            {
                var dt = new dalDocument().GetDocumentById(Convert.ToInt32(tbx_StudentFeeMapping_ApprovalId.Text));
                if (dt.Rows.Count == 0)
                {
                    lbl_Comment.Text = "Invalid Apploval Id";
                    continue;
                }
            }

            if (cbx_WillSave.Checked == true && !string.IsNullOrEmpty(lbl_SessionFeeMapping_Id.Text))
            {
                var resRow = dal.StudentFeeMapping_InsertOrUpdate(
                    Id: string.IsNullOrEmpty(lbl_StudentFeeMapping_Id.Text) ? 0 : Convert.ToInt32(lbl_StudentFeeMapping_Id.Text),
                    SessionFeeMappingId: Convert.ToInt32(lbl_SessionFeeMapping_Id.Text),
                    StudentId: Convert.ToInt32(lbl_StudentId.Text),
                    DefaultAmount: Convert.ToDecimal(lbl_Fee_DefaultAmount.Text),
                    WaiverPercentage: -1,//!string.IsNullOrEmpty(tbx_NewPercentage.Text) ? Convert.ToDecimal(tbx_NewPercentage.Text) : -1,
                    ConsumptionUnit: -1,
                    AppliedAmount: Convert.ToDecimal(tbx_StudentFeeMapping_AppliedAmount_New.Text),
                    ApprovalId: !string.IsNullOrEmpty(tbx_StudentFeeMapping_ApprovalId.Text) ? Convert.ToInt32(tbx_StudentFeeMapping_ApprovalId.Text.Trim()) : -1,
                    IsActive: cbx_StudentFeeMapping_IsActive.Checked ? "Active" : "Inactive",
                    EntryBy: SessionManager.SessionName.UserName
                    );
                if (resRow["return_status"].ToString() == "yes")
                {
                    lbl_Comment.Text = "Saved";
                }
                else
                {
                    lbl_Comment.Text = resRow["return_message"].ToString();
                }
            }
            else
            {
                lbl_Comment.Text = "";
            }
        }
    }
    #region Get Criteria
    protected string GetCriteria()
    {
        string criteria = "1=1 ";

        if (ddlFeeHead.SelectedValue != "")
        {
            criteria += " and FeeHeadId=" + ddlFeeHead.SelectedValue;
        }
        if (ddlClass.SelectedValue != "")
        {
            criteria += " and CurrentClassId=" + ddlClass.SelectedValue;
        }
        if (tbxRegNo.Text != "")
        {
            if (criteria == "")
                criteria = "RegNo='" + tbxRegNo.Text + "'";
            else
                criteria += " and RegNo='" + tbxRegNo.Text + "'";
        }
        return criteria;
    }
    #endregion
}