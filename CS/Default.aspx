<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASPxGridView - How to reset changes for a cell in Batch Edit Mode</title>
</head>
<body>
    <h3>ASPxGridView - How to reset changes for a cell in Batch Edit Mode</h3>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxHyperLink ID="ContextMenuLink" NavigateUrl="ContextMenu.aspx" runat="server" Text="Reset via the context menu" Font-Size="Large"/>
            <br />
            <dx:ASPxHyperLink ID="HotKeyLink" NavigateUrl="HotKeys.aspx" runat="server" Text="Reset via hot keys" Font-Size="Large" />
        </div>
    </form>
</body>
</html>
