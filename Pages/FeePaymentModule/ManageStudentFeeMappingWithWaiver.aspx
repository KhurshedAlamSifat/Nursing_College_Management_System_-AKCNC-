<%@ Page Title="Manage Student Fee Mapping With Waiver" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageStudentFeeMappingWithWaiver.aspx.cs" Inherits="Pages_FeePaymentModule_ManageStudentFeeMappingWithWaiver" %>

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
                            <asp:Label ID="Label3" runat="server" Text="Session"></asp:Label></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddlAdmissionSession" runat="server" DataTextField="AdmissionSession" DataValueField="AdmissionSession" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4">
                            <asp:Label ID="Label1" runat="server" Text="Fee Head*"></asp:Label></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddlFeeHead" runat="server" DataTextField="FullName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="form-horizontal">
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-4">
                            <asp:Label ID="Label2" runat="server" Text="Class*"></asp:Label></label>
                        <div class="col-sm-6">
                            <asp:DropDownList ID="ddlClass" runat="server" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="true" DataTextField="ClassName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
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
            <asp:Button ID="btnToggleIsActive" runat="server" Text="All Is Active [Check/Uncheck]" OnClick="btnToggleIsActive_Click" CssClass="btn btn-success" />
            <asp:Button ID="btnToggleWillSave" runat="server" Text="All Will Save [Check/Uncheck]" OnClick="btnToggleWillSave_Click" CssClass="btn btn-success" />
            <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success" />
        </div>
    </div>
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
                    <asp:TemplateField HeaderText="Fee Title">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Fee_Id" runat="server" Text='<%#Eval("Fee_Id") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbl_Fee_FullName" runat="server" Text='<%#Eval("Fee_FullName") %>'></asp:Label>
                            <asp:Label ID="lbl_Fee_DefaultAmount" runat="server" Text='<%#Eval("Fee_DefaultAmount") %>'></asp:Label>
                            <asp:Label ID="lbl_SessionFeeMapping_Id" runat="server" Text='<%#Eval("SessionFeeMapping_Id") %>' Visible="false"></asp:Label>
                            <asp:Label ID="lbl_StudentFeeMapping_Id" runat="server" Text='<%#Eval("StudentFeeMapping_Id") %>' Visible="false"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Current Amount">
                        <ItemTemplate>
                            <asp:Label ID="lbl_StudentFeeMapping_AppliedAmount_Old" runat="server" Text='<%#Eval("StudentFeeMapping_AppliedAmount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="New Amount" ControlStyle-Width="70px">
                        <ItemTemplate>
                            <%--<asp:Label ID="lbl_StudentFeeMapping_AppliedAmount_New" runat="server" Text='<%#Eval("Fee_DefaultAmount") %>'></asp:Label>--%>
                            <asp:TextBox ID="tbx_StudentFeeMapping_AppliedAmount_New" runat="server" Text='<%#Eval("Fee_DefaultAmount") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Approval Id" ControlStyle-Width="50px">
                        <ItemTemplate>
                            <%--<asp:Label ID="lbl_StudentFeeMapping_AppliedAmount_New" runat="server" Text='<%#Eval("Fee_DefaultAmount") %>'></asp:Label>--%>
                            <asp:TextBox ID="StudentFeeMapping_ApprovalId" runat="server" Text='<%#Eval("StudentFeeMapping_ApprovalId") %>'></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Is Active">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbx_StudentFeeMapping_IsActive" runat="server" Checked='<%# Eval("StudentFeeMapping_IsActive").ToString().Equals("Active") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Will Save">
                        <ItemTemplate>
                            <asp:CheckBox ID="cbx_WillSave" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Comment">
                        <ItemTemplate>
                            <asp:Label ID="lbl_Comment" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- 
                        <asp:TemplateField HeaderText="XX">
                        <ItemTemplate>
                            <asp:Label ID="lbl_XX" runat="server" Text='<%#Eval("XX") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    --%>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
    <script type="text/javascript">
    </script>
</asp:Content>

