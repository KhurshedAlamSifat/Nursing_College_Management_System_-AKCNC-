<%@ Page Title="Manage Session & Fee Mapping" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="ManageSessionFeeMapping.aspx.cs" Inherits="Pages_FeePaymentModule_SessionFeeMapping" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">

    <asp:UpdatePanel ID="Updatepanel1" runat="server">
        <ContentTemplate>
            <div class="form-horizontal">
                <div class="form-group">
                    <div class="col-md-10 col-sm-10 col-xs-10">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="save" />
                        <asp:Label ID="lblError" runat="server" Font-Bold="True" SkinID="message"></asp:Label>
                        <asp:HiddenField ID="hdnID" runat="server" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2">
                        <asp:Label ID="Label5" runat="server" Text="Admission Session"></asp:Label></label>
                    <div class="col-sm-3">
                        <asp:DropDownList ID="ddlAdmissionSession" runat="server" DataTextField="AdmissionSession" DataValueField="AdmissionSession" CssClass="form-control dropdown"></asp:DropDownList>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator2" runat="server" ValidationGroup="save"
                            ErrorMessage="Enter Session" ControlToValidate="ddlAdmissionSession">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2">
                            <asp:Label ID="Label2" runat="server" Text="Class*"></asp:Label></label>
                        <div class="col-sm-3">
                            <asp:DropDownList ID="ddlClass" runat="server" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" AutoPostBack="true" DataTextField="ClassName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2">
                        <asp:Label ID="Label7" runat="server" Text="Fee*"></asp:Label></label>
                    <div class="col-sm-3">
                        <asp:DropDownList ID="ddlFeeHead" runat="server" DataTextField="FullName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator3" runat="server" ValidationGroup="save"
                            ErrorMessage="Enter FeeHead" ControlToValidate="ddlFeeHead">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2">
                        <asp:Label ID="Label6" runat="server" Text="Default Amount Male"></asp:Label></label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="tbxDefaultAmountMale" runat="server" placeholder="" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator1" runat="server" ValidationGroup="save"
                            ErrorMessage="Enter Default Amount Male" ControlToValidate="tbxDefaultAmountFemale">*</asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator4" runat="server" ValidationGroup="edit"
                            ErrorMessage="Enter Default Amount Male" ControlToValidate="tbxDefaultAmountFemale">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2">
                        <asp:Label ID="Label19" runat="server" Text="Default Amount Female"></asp:Label></label>
                    <div class="col-sm-3">
                        <asp:TextBox ID="tbxDefaultAmountFemale" runat="server" placeholder="" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator7" runat="server" ValidationGroup="save"
                            ErrorMessage="Enter Default Amount Female" ControlToValidate="tbxDefaultAmountFemale">*</asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator5" runat="server" ValidationGroup="edit"
                            ErrorMessage="Enter Default Amount Female" ControlToValidate="tbxDefaultAmountFemale">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail3" class="col-sm-2">
                        <asp:Label ID="Labe21" runat="server" Text="Is Active"></asp:Label></label>
                    <div class="col-sm-10">
                        <asp:CheckBox ID="chkIsActive" runat="server" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-11">
                        <asp:Button ID="btnSave" ClientIDMode="Static" runat="server" Text="<%$ Resources:Application,Save %>" CssClass="btn btn-primary" ValidationGroup="save"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnEdit" runat="server" ClientIDMode="Static" Text="<%$ Resources:Application,Edit %>" CssClass="btn btn-primary" ValidationGroup="edit" Visible="false"
                            OnClick="btnEdit_Click" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-12">
                        <div class="box">
                            <div class="box-body">
                                <asp:Repeater ID="rptYear" runat="server">
                                    <HeaderTemplate>
                                        <table id="example1" class="table table-bordered table-hover">
                                            <thead>
                                                <tr>

                                                    <th>
                                                        <asp:Label ID="Label9" runat="server" Text="Id"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label15" runat="server" Text="Admission Session"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label1" runat="server" Text="Fee"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label16" runat="server" Text="Class"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label2" runat="server" Text="Default Amt for Male"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label3" runat="server" Text="Default Amt for female"></asp:Label></th>
                                                    <th>
                                                        <asp:Label ID="Label12" runat="server" Text="Is Active"></asp:Label></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <%--<td><%#Eval("") %></td>--%>
                                            <td><%#Eval("Id") %></td>
                                            <td><%#Eval("AdmissionSession") %></td>
                                            <td><%#Eval("Fee_FullName") %></td>
                                            <td><%#Eval("ClassName") %></td>
                                            <td><%#Eval("DefaultAmountMale") %></td>
                                            <td><%#Eval("DefaultAmountFemale") %></td>
                                            <td><%#Eval("IsActive") %></td>
                                            <td>
                                                <asp:ImageButton ID="btnEdit" runat="server" OnCommand="btnEdit_Command" CommandArgument='<%# Eval("Id")%>' ImageUrl="~/Images/Common/edit.png" ToolTip="Edit" />
                                                <%--<asp:ImageButton ID="btnDelete" runat="server" OnCommand="btnDelete_Command" CommandArgument='<%# Eval("Id")%>' ImageUrl="~/Images/Common/delete.png" ToolTip="Delete" OnClientClick="return confirm('Are you sure?')" />--%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                </table>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
</asp:Content>
