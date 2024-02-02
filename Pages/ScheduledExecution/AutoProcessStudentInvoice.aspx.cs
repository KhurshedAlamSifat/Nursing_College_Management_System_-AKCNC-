using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_ScheduledExecution_AutoProcessStudentInvoice : BasePage
{
    dalFeePayment dal = new dalFeePayment();
    protected void Page_Load(object sender, EventArgs e)
    {
        //SessionManager.SessionName.Branch = 1;
        string root_query = " select ss_Student.Id as Student_Id, " +
                        " ss_Student.CurrentBalance as Student_CurrentBalance, " +
                        " SUM(ttv_acc_StudentDue.AppliedAmount) as StudentDue_Total " +
                        " from  ss_Student " +
                        " join ttv_acc_StudentDue on ss_Student.Id = ttv_acc_StudentDue.StudentId " +
                        " where ss_Student.CurrentBalance > 0 " +
                        " and ttv_acc_StudentDue.ShortStatus = 'Unpaid' " +
                        " group by ss_Student.Id, ss_Student.CurrentBalance " +
                        " having ss_Student.CurrentBalance >= SUM(ttv_acc_StudentDue.AppliedAmount)	";
        var root_dt = new dalCommon().GetByQuery(root_query);
        if (root_dt.Rows.Count > 0)
        {
            foreach (DataRow root_row in root_dt.Rows)
            {
                var Student_Id = root_row["Student_Id"].ToString();
                var Student_CurrentBalance = root_row["Student_CurrentBalance"].ToString();
                var StudentDue_Total = root_row["StudentDue_Total"].ToString();
                try
                {
                    var Invoice_TransectionIdentifier = "ST INVOICE/" + Guid.NewGuid();
                    var invoiceResRow = dal.StudentInvoice_Insert_ByInternalUser(
                        TransectionIdentifier: Invoice_TransectionIdentifier,
                        StudentId: Convert.ToInt32(Student_Id),
                        DepositedAmount: 0,//Convert.ToDecimal(tbxDepositedAmount.Text),
                        Status: "",
                        CreatedBy: "process",
                        Note: "",
                        DeveloperNote: ""
                        );
                    if (invoiceResRow[0].ToString() == "yes")
                    {
                        var due_dt = dal.StudentDue_Transectional_GetByCriteria(
                        StudentId: Student_Id,
                        ShortStatus: "Unpaid"
                        );
                        foreach (DataRow due_row in due_dt.Rows)
                        {
                            var resRow = dal.StudentDue_Transectional_Pay_ByProcess(
                                    TransectionIdentifier: due_row["StudentDue_TransectionIdentifier"].ToString(),
                                    Invoice_TransectionIdentifier: Invoice_TransectionIdentifier
                                   );
                        }
                    }
                }
                catch (Exception exception)
                {
                    MessageController.Show("Save Failed. EXEC USP_StudentDue_Transectional_Pay_ByProcess ", MessageType.Error, Page);
                    Response.Write("<script>alert('Data inserted successfully')</script>");
                }
            }
        }

        //foreach (var row in dt_root.Rows)
        //{
        //    try
        //    {
        //        var Invoice_TransectionIdentifier = "ST INVOICE/" + Guid.NewGuid();
        //        var invoiceResRow = dal.StudentInvoice_Insert_ByInternalUser(
        //            TransectionIdentifier: Invoice_TransectionIdentifier,
        //            StudentId: Convert.ToInt32(row["Student_Id"].TO),
        //            DepositedAmount: Convert.ToDecimal(tbxDepositedAmount.Text),
        //            Status: "",
        //            CreatedBy: SessionManager.SessionName.UserName,
        //            Note: "",
        //            DeveloperNote: ""
        //            );
        //        if (invoiceResRow[0].ToString() == "yes")
        //        {
        //            var NextPaymentStatus = "Paid";
        //            foreach (GridViewRow row in gvStudentDue.Rows)
        //            {
        //                var lbl_StudentDue_TransectionIdentifier = (Label)row.FindControl("lbl_StudentDue_TransectionIdentifier");
        //                var lbl_Comment = (Label)row.FindControl("lbl_Comment");
        //                var resRow = dal.StudentInvoice_Pay_ByInternalUser(
        //                        TransectionIdentifier: lbl_StudentDue_TransectionIdentifier.Text,
        //                        Invoice_TransectionIdentifier: Invoice_TransectionIdentifier,
        //                        PaidBy: SessionManager.SessionName.UserName
        //                       );
        //                if (resRow["return_status"].ToString() == "yes")
        //                {
        //                    lbl_Comment.Text = "Paid";
        //                }
        //                else
        //                {
        //                    lbl_Comment.Text = resRow["return_message"].ToString();
        //                }
        //            }
        //            btnSave.Visible = false;
        //            btnPrint.Visible = true;
        //            ClearAllAdd();
        //            btnPrint.CommandArgument = Invoice_TransectionIdentifier.ToString();
        //            MessageController.Show(MessageCode.SaveSucceeded, MessageType.Information, Page);
        //        }
        //        else
        //        {
        //            MessageController.Show(invoiceResRow[2].ToString(), MessageType.Error, Page);
        //        }
        //    }
        //    catch (Exception exception)
        //    {
        //        MessageController.Show("Save Failed. Please contact with admin.", MessageType.Error, Page);
        //    }
        //}
    }
}