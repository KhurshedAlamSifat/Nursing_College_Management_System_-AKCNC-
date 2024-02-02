<%@ Page Title="Due Summary" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="DueSummaryByStudentReport.aspx.cs" Inherits="Pages_FeePaymentModule_DueSummaryByStudentReport" %>

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
                            <asp:Label ID="Label4" runat="server" Text="Session"></asp:Label></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddlAdmissionSession" runat="server" DataTextField="AdmissionSession" DataValueField="AdmissionSession" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4">
                            <asp:Label ID="Label2" runat="server" Text="Class"></asp:Label></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddlClass" runat="server" DataTextField="ClassName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
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
                    <asp:TemplateField HeaderText="Session">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Session" runat="server" Text='<%#Eval("AdmissionSession") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Credit Amount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_TotalCreditAmount" runat="server" Text='<%#Eval("TotalCreditAmount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Due">
                        <ItemTemplate>
                            <asp:Label ID="lbl_NetBalance" runat="server" Text='<%#Eval("CuurentBalance") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="panel-footer" style="text-align: right;">
            <asp:Label ID="Label11" runat="server" Font-Bold="true">Sum Total Credit Amount: </asp:Label>
            <asp:Label ID="lblSumTotalCreditAmount" runat="server" Font-Bold="true"></asp:Label>
            &nbsp;
            &nbsp;
            <asp:Label ID="Label1" runat="server" Font-Bold="true">Sum Cuurent Balance: </asp:Label>
            <asp:Label ID="lblSumCuurentBalance" runat="server" Font-Bold="true"></asp:Label>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

