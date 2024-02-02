<%@ Page Title="Payment Summary Report Format1" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="PaymentSummaryReport_Format1.aspx.cs" Inherits="Pages_FeePaymentModule_PaymentSummaryReport_Format1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <div class="panel panel-success">
        <div class="panel-body">
            <div class="col-lg-6 col-md-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4">
                            <asp:Label ID="Label23" runat="server" Text="Paid Date From"></asp:Label><span class="required">*</span></label>
                        <div class="col-sm-6">
                            <asp:TextBox ID="tbx_PaidDateFrom" runat="server" CssClass="form-control" placeholder="dd/MM/yyyy"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="tbx_PaidDateFrom"
                                TargetControlID="tbx_PaidDateFrom">
                            </cc1:CalendarExtender>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4">
                            <asp:Label ID="Label4" runat="server" Text="Paid Date To"></asp:Label><span class="required">*</span></label>
                        <div class="col-sm-6">
                            <asp:TextBox ID="tbx_PaidDateTo" runat="server" CssClass="form-control" placeholder="dd/MM/yyyy"></asp:TextBox>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="tbx_PaidDateTo"
                                TargetControlID="tbx_PaidDateTo">
                            </cc1:CalendarExtender>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-success" />
            <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excell" OnClick="btnExportToExcel_Click" CssClass="btn btn-success" />
        </div>
    </div>
    <div class="panel panel-success">
        <div class="panel-body">
            <asp:GridView ID="gvList" runat="server" CssClass="table table-striped dt-responsive display" AutoGenerateColumns="false">
                <Columns>
                    <asp:TemplateField HeaderText="RegistrationNumber">
                        <ItemTemplate>
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
                    <asp:TemplateField HeaderText="OldBalance">
                        <ItemTemplate>
                            <asp:Label ID="lbl_OldBalance" runat="server" Text='<%#Eval("OldBalance") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DepositedAmount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_DepositedAmount" runat="server" Text='<%#Eval("DepositedAmount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="PaidAmount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_PaidAmount" runat="server" Text='<%#Eval("PaidAmount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RemainingBalance">
                        <ItemTemplate>
                            <asp:Label ID="lbl_RemainingBalance" runat="server" Text='<%#Eval("RemainingBalance") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AdmissionFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_AdmissionFee" runat="server" Text='<%#Eval("AdmissionFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="DevelopmentFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_DevelopmentFee" runat="server" Text='<%#Eval("DevelopmentFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SessionFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_SessionFee" runat="server" Text='<%#Eval("SessionFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TuitionFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_TuitionFee" runat="server" Text='<%#Eval("TuitionFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ExaminationFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_ExaminationFee" runat="server" Text='<%#Eval("ExaminationFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CanteenFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_CanteenFee" runat="server" Text='<%#Eval("CanteenFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="AccommodationFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_AccommodationFee" runat="server" Text='<%#Eval("AccommodationFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LateFeeTuition">
                        <ItemTemplate>
                            <asp:Label ID="lbl_LateFeeTuition" runat="server" Text='<%#Eval("LateFeeTuition") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RegistrationFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_RegistrationFee" runat="server" Text='<%#Eval("RegistrationFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="LabFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_LabFee" runat="server" Text='<%#Eval("LabFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TransportFee">
                        <ItemTemplate>
                            <asp:Label ID="lbl_TransportFee" runat="server" Text='<%#Eval("TransportFee") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="IdentityCard">
                        <ItemTemplate>
                            <asp:Label ID="lbl_IdentityCard" runat="server" Text='<%#Eval("IdentityCard") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="InitialDue">
                        <ItemTemplate>
                            <asp:Label ID="lbl_InitialDue" runat="server" Text='<%#Eval("InitialDue") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="panel-footer" style="text-align: right;">
            <asp:Label ID="Label1" runat="server" Font-Bold="true">Total Old Amount: </asp:Label>
            <asp:Label ID="lblTotalOldBalance" runat="server" Font-Bold="true"></asp:Label>
            &nbsp;&nbsp;
            <asp:Label ID="Label10" runat="server" Font-Bold="true">Total Deposited Amount: </asp:Label>
            <asp:Label ID="lblTotalDepositedAmount" runat="server" Font-Bold="true"></asp:Label>
            &nbsp;&nbsp;
            <asp:Label ID="Label3" runat="server" Font-Bold="true">Total Paid Amount: </asp:Label>
            <asp:Label ID="lblTotalPaidAmount" runat="server" Font-Bold="true"></asp:Label>
            &nbsp;&nbsp;
            <asp:Label ID="Label2" runat="server" Font-Bold="true">Total Remaining Balance: </asp:Label>
            <asp:Label ID="lblTotalRemainingBalance" runat="server" Font-Bold="true"></asp:Label>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

