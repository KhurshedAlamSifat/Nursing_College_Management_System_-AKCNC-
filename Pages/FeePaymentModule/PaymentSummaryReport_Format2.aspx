<%@ Page Title="Payment Summary Report Format 2" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="PaymentSummaryReport_Format2.aspx.cs" Inherits="Pages_FeePaymentModule_PaymentSummaryReport_Format2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <asp:Panel ID="pnlAdd" runat="server">
        <div class="panel panel-success">
            <div class="panel-body">
                <div class="col-md-12 col-sm-12 col-xs-12">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="add" />
                    <asp:Label ID="lblError" runat="server" Font-Bold="True" SkinID="message"></asp:Label>
                    <asp:HiddenField ID="hdnID" runat="server" />
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label22" runat="server" Text="Registration No."></asp:Label><span class="required">*</span></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxStudent_Id" runat="server" CssClass="form-control" Visible="false"></asp:TextBox>
                                <asp:TextBox ID="tbxStudent_RegistrationNumber" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" ValidationGroup="add"
                                    ErrorMessage="Select Student" ControlToValidate="tbxStudent_RegistrationNumber">*</asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label2" runat="server" Text="Class"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxStudent_Class" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label24" runat="server" Text="Name"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxStudent_Name" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label3" runat="server" Text="Total Target Amount"></asp:Label><span class="required">*</span></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxTotalTargetAmount" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label4" runat="server" Text="Total Paid Amount"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxTotalPaidAmount" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel-body">
                <asp:GridView ID="gvStudentDue" runat="server" CssClass="table table-striped dt-responsive display" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="Paid Date">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StudentDue_PaidDate" runat="server" Text='<%#Eval("StudentDue_PaidDate") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tracking Id">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StudentDue_TrackingId" runat="server" Text='<%#Eval("StudentDue_TrackingId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Fee Display Name">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Fee_DisplayName" runat="server" Text='<%#Eval("Fee_DisplayName") %>'></asp:Label>
                                -<asp:Label ID="lbl_StudentDue_EffectiveMonthName" runat="server" Text='<%#Eval("StudentDue_EffectiveMonthName") %>'></asp:Label>
                                -<asp:Label ID="lbl_StudentDue_EffectiveYear" runat="server" Text='<%#Eval("StudentDue_EffectiveYear") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Target Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Mapping_TargetAmount" runat="server" Text='<%#Eval("Mapping_TargetAmount") %>'></asp:Label>
                                -
                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Mapping_UnrecordedPaidAmount") %>'></asp:Label>
                                =
                                <asp:Label ID="Label5" runat="server" Text='<%#Eval("Mapping_NetTargetAmount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Paid Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StudentDue_AppliedAmount" runat="server" Text='<%#Eval("StudentDue_AppliedAmount") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Concurrent Due Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbl_ConcurrentTargetGap" runat="server" Text='<%#Eval("ConcurrentTargetGap") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div class="panel-footer">
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pnlSearch" runat="server">
        <div class="panel panel-success">
            <div class="panel-body">
                <div class="col-lg-5 col-md-5">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label8" runat="server" Text="Session"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlAdmissionSession" runat="server" DataTextField="AdmissionSession" DataValueField="AdmissionSession" CssClass="form-control dropdown"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 col-md-5">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label6" runat="server" Text="Class"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:DropDownList ID="ddlClass" runat="server" DataTextField="ClassName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 col-md-5">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-4">
                                <asp:Label ID="Label7" runat="server" Text="RegNo"></asp:Label></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="tbxRegNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success" />
                </div>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="test" runat="server">
        <div class="panel panel-success">
            <div class="panel-body">
                <asp:GridView ID="gvList" runat="server" CssClass="table table-striped dt-responsive display" AutoGenerateColumns="false">
                    <Columns>
                        <asp:TemplateField HeaderText="RegistrationNumber">
                            <ItemTemplate>
                                <asp:Label ID="lbl_StudentId" runat="server" Text='<%#Eval("Student_Id") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lbl_12" runat="server" Text='<%#Eval("Student_RegistrationNumber") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lbl_NameEng" runat="server" Text='<%#Eval("Student_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Class">
                            <ItemTemplate>
                                <asp:Label ID="lbl_ClassName" runat="server" Text='<%#Eval("Student_Class") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Session">
                            <ItemTemplate>
                                <asp:Label ID="lbl_Session" runat="server" Text='<%#Eval("Student_AdmissionSession") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Section">
                            <ItemTemplate>
                                <asp:Button ID="btnLoadStudent" runat="server" Text="Select" CommandArgument='<%#Eval("Student_Id") %>' OnClick="btnLoadStudent_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
        document.getElementById('cphMain_tbxDepositedAmount').value = '';
        function tbxDepositedAmountOnInput() {
            let _DepositedAmount = document.getElementById('cphMain_tbxDepositedAmount').value;
            let DepositedAmount = Number(_DepositedAmount);

            let _NetPayable = document.getElementById('cphMain_tbxNetPayable').value;
            let NetPayable = Number(_NetPayable);

            let NextBalance = DepositedAmount - NetPayable;
            if (NextBalance > 0) {
                document.getElementById('cphMain_tbxNextBalance').value = NextBalance;
            } else {
                document.getElementById('cphMain_tbxNextBalance').value = '';
            }
        }
    </script>
</asp:Content>

