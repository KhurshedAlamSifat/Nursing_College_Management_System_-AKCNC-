using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_User_AdmissionCircular : BasePage
{
    dalAdmissionCircular obj = new dalAdmissionCircular();
    protected void Page_Load(object sender, EventArgs e)
    {

        BindData();

    }
    protected void BindData()
    {
        DataTable dt = obj.GetAll();
        rptYear.DataSource = dt;
        rptYear.DataBind();
    }

}