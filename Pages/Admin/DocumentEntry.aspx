<%@ Page Title="Content Entry" Language="C#" MasterPageFile="~/MasterPage/AdminMaster.master" AutoEventWireup="true" CodeFile="DocumentEntry.aspx.cs"
    Inherits="Pages_Admin_DecumentEntry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphMain" runat="Server">
    <contenttemplate>
        <div class="row">
            <div class="col-md-12">
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
                            <asp:Label ID="Label2" runat="server" Text="Title"></asp:Label><span class="required">*</span></label>
                        <div class="col-sm-4">
                            <asp:TextBox ID="tbxTitle" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator8" runat="server" ValidationGroup="save"
                                ErrorMessage="Enter Title" ControlToValidate="tbxTitle">*</asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2">
                            <asp:Label ID="Label8" runat="server" Text="Class"></asp:Label></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlClass" runat="server" DataTextField="ClassName" DataValueField="Id" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                        <label for="inputEmail3" class="col-sm-2">
                            <asp:Label ID="Label4" runat="server" Text="Category"></asp:Label></label>
                        <div class="col-sm-4">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control dropdown"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail3" class="col-sm-2">
                            <asp:Label ID="Label13" runat="server" Text="File"></asp:Label></label>
                        <div class="col-sm-4">
                            <asp:FileUpload ID="flFile" runat="server" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-6 text-right">
                            <asp:Button ID="btnSave" runat="server" ClientIDMode="Static" Text="<%$ Resources:Application,Save %>" CssClass="btn btn-primary" ValidationGroup="save"
                                OnClick="btnSave_Click" />
                            <%--<asp:Button ID="btnEdit" runat="server" ClientIDMode="Static" Text="<%$ Resources:Application,Edit %>" CssClass="btn btn-primary" ValidationGroup="save" Visible="false"
                                OnClick="btnEdit_Click" />--%>
                            <%-- <asp:Button ID="btnReset" runat="server" Text="<%$ Resources:Application,Refresh %>" CssClass="btn btn-primary" CausesValidation="false"
                                OnClick="btnReset_Click" />--%>
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
                                                            <asp:Label ID="Label3" runat="server" Text="Id"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label6" runat="server" Text="Title"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label5" runat="server" Text="Category"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label11" runat="server" Text="ClassName"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label12" runat="server" Text="Title"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label16" runat="server" Text="VisibleFileName"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label18" runat="server" Text="CreatedBy"></asp:Label></th>
                                                        <th>
                                                            <asp:Label ID="Label1" runat="server" Text="<%$ Resources:Application,Action %>"></asp:Label></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td><%#Eval("Id") %></td>
                                                <td><%#Eval("Title") %></td>
                                                <td><%#Eval("Category") %></td>
                                                <td><%#Eval("ClassName") %></td>
                                                <td><%#Eval("Title") %></td>
                                                <td>
                                                    <%# (Eval("FileName") != null) ? "<a href='/Pages/Admin/DocumentDownload.aspx?FileName="+ Eval("FileName") + "&VisibleFileName="+Eval("VisibleFileName")+"'>"+Eval("VisibleFileName")+"</a>"  : "" %>
                                                </td>
                                                <td><%#Eval("CreatedBy") %></td>
                                                <td>
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
            </div>
        </div>
    </contenttemplate>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="Server">
</asp:Content>

