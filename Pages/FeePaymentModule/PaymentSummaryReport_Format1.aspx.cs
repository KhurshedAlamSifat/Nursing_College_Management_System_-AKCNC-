using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_FeePaymentModule_PaymentSummaryReport_Format1 : BasePage
{
    dalFeePayment dal = new dalFeePayment();
    List<int> EffectiveYearList = new List<int>() { 2022, 2023 };
    Dictionary<string, string> EffectiveMonthDict = new Dictionary<string, string>() { { "01", "January" }, { "02", "February" }, { "03", "March" }, { "04", "April" }, { "05", "May" }, { "06", "June" }, { "07", "July" }, { "08", "August" }, { "09", "September" }, { "10", "October" }, { "11", "November" }, { "12", "December" } };
    Dictionary<string, string> ShortStatusDict = new Dictionary<string, string>() { { "Unpaid", "Unpaid" }, { "Paid", "Paid" } };
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
        tbx_PaidDateFrom.Text = "";
        tbx_PaidDateTo.Text = "";
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(tbx_PaidDateFrom.Text) || string.IsNullOrEmpty(tbx_PaidDateTo.Text))
        {
            MessageController.Show("Please select 'Paid Date From' and 'Paid Date To'.", MessageType.Warning, Page);
            return;
        }
        DataTable dt = dal.PaymentSummaryReport_Format1(
            PaidDateFrom: tbx_PaidDateFrom.Text,
            PaidDateTo: tbx_PaidDateTo.Text
            );
        if (dt.Rows.Count > 0)
        {
            gvList.DataSource = dt;
            gvList.DataBind();
            btnExportToExcel.Visible = true;
            lblTotalOldBalance.Text = dt.Compute("Sum(OldBalance)", "").ToString();
            lblTotalDepositedAmount.Text = dt.Compute("Sum(DepositedAmount)", "").ToString();
            lblTotalPaidAmount.Text = dt.Compute("Sum(PaidAmount)", "").ToString();
            lblTotalRemainingBalance.Text = dt.Compute("Sum(RemainingBalance)", "").ToString();
        }
        else
        {
            gvList.DataSource = null;
            gvList.DataBind();
            btnExportToExcel.Visible = false;
            lblTotalOldBalance.Text = "";
            lblTotalDepositedAmount.Text = "";
            lblTotalPaidAmount.Text = "";
            lblTotalRemainingBalance.Text = "";
        }

    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.AddHeader("content-disposition", "attachment; filename=PaymentSummaryReport_Format1.xlsx");
        Response.ContentType = "application/excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvList.RenderControl(htw);
        string style = @"<style> td { mso-number-format:\@;} </style>";
        Response.Write(style);
        Response.Write(sw.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    #region Get Criteria
    #endregion
}