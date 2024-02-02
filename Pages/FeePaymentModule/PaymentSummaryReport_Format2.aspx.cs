using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using iTextSharp.text;
//using iTextSharp.text.html.simpleparser;
//using iTextSharp.text.pdf;

public partial class Pages_FeePaymentModule_PaymentSummaryReport_Format2 
    : BasePage
{
    dalFeePayment dal = new dalFeePayment();
    List<int> EffectiveYearList = new List<int>() { 2023 };
    Dictionary<int, string> EffectiveMonthDict = new Dictionary<int, string>() { { 1, "January" }, { 2, "February" }, { 3, "March" }, { 4, "April" }, { 5, "May" }, { 6, "June" }, { 7, "July" }, { 8, "August" }, { 9, "September" }, { 10, "October" }, { 11, "November" }, { 12, "December" } };
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
            LoadInitialData();
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string criteria = " 1 = 1 ";
        if (!string.IsNullOrEmpty(ddlAdmissionSession.SelectedValue))
        {
            criteria += " AND ss_AdmissionSession.AdmissionSession = '" + ddlAdmissionSession.SelectedValue + "'";
        }
        if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            criteria += " AND bs_ClassName.Id = " + ddlClass.SelectedValue + "";
        }
        if (tbxRegNo.Text != "")
        {
            criteria += " AND ss_Student.RegNo like '%" + tbxRegNo.Text + "%'";
        }
        DataTable dt = new dalStudent().GetDetailByCriteria(criteria);
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
    protected void btnLoadStudent_Click(object sender, EventArgs e)
    {
        try
        {
            tbxStudent_Id.Text = "";
            tbxStudent_RegistrationNumber.Text = "";
            tbxStudent_Name.Text = "";
            tbxStudent_Class.Text = "";
            tbxTotalTargetAmount.Text = "";
            var Student_Id = ((Button)sender).CommandArgument;
            DataTable due_dt = new dalStudent().GetDetailByCriteria(" ss_Student.Id=" + Student_Id);
            if (due_dt.Rows.Count > 0)
            {
                tbxStudent_Id.Text = due_dt.Rows[0]["Student_Id"].ToString();
                tbxStudent_RegistrationNumber.Text = due_dt.Rows[0]["Student_RegistrationNumber"].ToString();
                tbxStudent_Name.Text = due_dt.Rows[0]["Student_Name"].ToString();
                tbxStudent_Class.Text = due_dt.Rows[0]["Student_Class"].ToString();
                tbxTotalTargetAmount.Text = due_dt.Rows[0]["TotalTargetAmount"].ToString();
                {
                    var dueDataTable = dal.PaymentSummaryReport_Format2(
                        StudentId: due_dt.Rows[0]["Student_Id"].ToString()
                        );
                    gvStudentDue.DataSource = dueDataTable;
                    gvStudentDue.DataBind();

                    var totalPaidAmount = Convert.ToDecimal(due_dt.Rows[0]["TotalUnrecordedPaidAmount"].ToString()) +(dueDataTable.Rows.Count > 0 ? Convert.ToDecimal(dueDataTable.Compute("SUM(StudentDue_AppliedAmount)", string.Empty)) : 0);
                    tbxTotalPaidAmount.Text = totalPaidAmount.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void ClearAllAdd()
    {
        tbxStudent_Id.Text = "";
        tbxStudent_RegistrationNumber.Text = "";
        tbxStudent_Name.Text = "";
        tbxStudent_Class.Text = "";

        tbxTotalTargetAmount.Text = "";
        tbxTotalPaidAmount.Text = "";
    }
}


