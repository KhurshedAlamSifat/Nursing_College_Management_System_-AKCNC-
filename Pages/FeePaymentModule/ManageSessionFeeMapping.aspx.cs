using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_FeePaymentModule_SessionFeeMapping : BasePage
{
    dalFeePayment dal = new dalFeePayment();
    protected static int ID;
    List<string> ChargeByList = new List<string>() { "System", "User", "Process" };
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
            btnSave.CssClass = Common.SessionInfo.Button;
            btnEdit.CssClass = Common.SessionInfo.Button;
            LoadInitialData();
            LoadListData();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        var row = dal.SessionFeeMapping_Insert(
            FeeHeadId: Convert.ToInt32(ddlFeeHead.SelectedValue),
            AdmissionSession: ddlAdmissionSession.SelectedValue,
            DefaultAmountMale: string.IsNullOrEmpty(tbxDefaultAmountMale.Text) ? 0 : Convert.ToDecimal(tbxDefaultAmountMale.Text),
            DefaultAmountFemale: Convert.ToDecimal(tbxDefaultAmountFemale.Text),
            IsActive: chkIsActive.Checked ? "Active" : "Inactive",
            CreatedBy: SessionManager.SessionName.UserName
            );
        if (row["return_status"].ToString() == "yes")
        {
            MessageController.Show(MessageCode.SaveSucceeded, MessageType.Information, Page);
        }
        else
        {
            MessageController.Show(row["return_message"].ToString(), MessageType.Error, Page);
        }
        LoadListData();
        ClearAll();
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        var row = dal.SessionFeeMapping_Update(
            Id: ID,
            //FeeHeadId: Convert.ToInt32(ddlFeeHead.SelectedValue),
            //AdmissionSession: tbxAdmissionSession.Text,
            DefaultAmountMale: string.IsNullOrEmpty(tbxDefaultAmountMale.Text) ? 0 : Convert.ToDecimal(tbxDefaultAmountMale.Text),
            DefaultAmountFemale: Convert.ToDecimal(tbxDefaultAmountFemale.Text),
            IsActive: chkIsActive.Checked ? "Active" : "Inactive",
            UpdatedBy: SessionManager.SessionName.UserName
            );
        if (row["return_status"].ToString() == "yes")
        {
            MessageController.Show(MessageCode.SaveSucceeded, MessageType.Information, Page);
        }
        else
        {
            MessageController.Show(row["return_message"].ToString(), MessageType.Error, Page);
        }
        LoadListData();
        ClearAll();
    }
    protected void ClearAll()
    {
        ddlAdmissionSession.SelectedIndex = 0;
        ddlAdmissionSession.Enabled = true;
        ddlClass.SelectedIndex = 0;
        ddlClass.Enabled = true;
        
        ddlFeeHead.Items.Clear();
        ddlFeeHead.Items.Insert(0, new ListItem("---Please Select---", ""));
        ddlFeeHead.Enabled = true;

        tbxDefaultAmountMale.Text = "";
        tbxDefaultAmountFemale.Text = "";
        chkIsActive.Checked = false;
        btnSave.Visible = true;
        btnEdit.Visible = false;
    }
    protected void LoadInitialData()
    {
        ddlClass.DataSource = new Common().GetAll("bs_ClassName");
        ddlClass.DataBind();
        ddlClass.Items.Insert(0, new ListItem("---Please Select---", ""));

        DataTable dt = new Common().GetAll("acc_FeeHead");
        ddlFeeHead.DataSource = dt;
        ddlFeeHead.DataBind();
        ddlFeeHead.Items.Insert(0, new ListItem("---Please Select---", ""));

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
                ddlFeeHead.DataSource = new dalCommon().GetByQuery("select * from acc_FeeHead where ClassId = '"+ ddlClass.SelectedValue + "' or ClassId is null;");
                ddlFeeHead.DataBind();
                ddlFeeHead.Items.Insert(0, new ListItem("---Please Select---", ""));
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void LoadListData()
    {
        string criteria = "1=1";
        DataTable dt = dal.SessionFeeMapping_GetByCriteria(criteria);
        rptYear.DataSource = dt;
        rptYear.DataBind();
    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        ID = Convert.ToInt32(e.CommandArgument);
        string criteria = "acc_SessionFeeMapping.Id=" + ID;
        DataTable dt = dal.SessionFeeMapping_GetByCriteria(criteria);
        if (dt.Rows.Count > 0)
        {
            ddlAdmissionSession.SelectedIndex = ddlAdmissionSession.Items.IndexOf(ddlAdmissionSession.Items.FindByValue(dt.Rows[0]["AdmissionSession"].ToString()));
            ddlAdmissionSession.Enabled = false;
            ddlClass.SelectedIndex = ddlClass.Items.IndexOf(ddlClass.Items.FindByValue(dt.Rows[0]["ClassId"].ToString()));
            ddlClass.Enabled = false;
            ddlFeeHead.SelectedIndex = ddlFeeHead.Items.IndexOf(ddlFeeHead.Items.FindByValue(dt.Rows[0]["FeeHeadId"].ToString()));
            ddlFeeHead.Enabled = false;
            tbxDefaultAmountMale.Text = dt.Rows[0]["DefaultAmountMale"].ToString();
            tbxDefaultAmountFemale.Text = dt.Rows[0]["DefaultAmountFemale"].ToString();
            chkIsActive.Checked = dt.Rows[0]["IsActive"].ToString() == "Active" ? true : false;
        }
        btnSave.Visible = false;
        btnEdit.Visible = true;
    }
    //protected void btnDelete_Command(object sender, CommandEventArgs e)
    //{
    //    //ID = Convert.ToInt32(e.CommandArgument);
    //    //new Common().Delete("bs_Year", ID);
    //    //MessageController.Show(MessageCode.DeleteSucceeded, MessageType.Information, Page);
    //    //BindData();
    //}
}