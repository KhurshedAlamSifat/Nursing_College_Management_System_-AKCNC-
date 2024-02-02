using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_FeePaymentModule_StudentFeeMappingReport : BasePage
{
    dalFeePayment dal = new dalFeePayment();
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
        ddlAdmissionSession.DataSource = new dalCommon().GetByQuery("select * from ss_AdmissionSession where IsActive = 'Active' order by AdmissionSession desc;");
        ddlAdmissionSession.DataBind();
        ddlAdmissionSession.Items.Insert(0, new ListItem("---Please Select---", ""));

        ddlClass.DataSource = new Common().GetAll("bs_ClassName");
        ddlClass.DataBind();
        ddlClass.Items.Insert(0, new ListItem("---Please Select---", ""));
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlAdmissionSession.SelectedValue))
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please select session.')", true);
            return;
        }
        try
        {
            ddlFeeHead.Items.Clear();
            if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
            {
                ddlFeeHead.DataSource = new dalCommon().GetByQuery("select * from acc_FeeHead where IsActive = 'Active' and (ClassId = " + ddlClass.SelectedValue + " OR ClassId is null) " +
                    "and acc_FeeHead.Id in (select acc_SessionFeeMapping.FeeHeadId from acc_SessionFeeMapping where AdmissionSession = '" + ddlAdmissionSession.SelectedValue + "')" +
                    "order by PriorityOrder;");
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
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Please select session.')", true);
            return;
        }
        DataTable dt = dal.StudentFeeMapping_GetByCriteria(
            AdmissionSession: ddlAdmissionSession.SelectedValue,
            ClassId: ddlClass.SelectedValue,
            FeeHeadId: ddlFeeHead.SelectedValue,
            RegistrationNumber: tbxRegNo.Text,
            FeeHeadIsActive: "Active",
            StudentFeeMappingIsActive: "Active"
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

    #region Get Criteria
    #endregion
}