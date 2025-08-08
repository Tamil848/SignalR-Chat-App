<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="SignalR_01.LogIn" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="txtUsername" runat="server" Placeholder="Enter your name" />
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
    </form>
</body>
</html>
