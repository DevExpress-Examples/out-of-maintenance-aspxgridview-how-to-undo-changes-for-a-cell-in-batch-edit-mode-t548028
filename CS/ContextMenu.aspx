<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ContextMenu.aspx.cs" Inherits="ContextMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset changes via context menu</title>
    <script>

        var clickedColumnIndex;

        function onCellRightBtnClick(columnIndex) {
            clickedColumnIndex = columnIndex;
        }

        function onContextItemClick(s, e) {
            if (e.item.name == 'reset_cell' && e.objectType == 'row') {
                if (e.elementIndex < 0)
                    s.batchEditApi.ResetChanges(e.elementIndex);
                else
                    s.batchEditApi.ResetChanges(e.elementIndex, clickedColumnIndex);
            }
        }
    </script>
</head>
<body>
    <h3>Use the context menu to reset cell changes</h3>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="Grid" runat="server" ClientInstanceName="grid" OnFillContextMenuItems="Grid_FillContextMenuItems"
                KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate" OnHtmlDataCellPrepared="Grid_HtmlDataCellPrepared">
                <ClientSideEvents ContextMenuItemClick="onContextItemClick" />
                <SettingsDataSecurity AllowDelete="false" />
                <SettingsEditing Mode="Batch" />
                <SettingsContextMenu Enabled="true" EnableRowMenu="True">
                    <RowMenuItemVisibility Refresh="false"></RowMenuItemVisibility>
                </SettingsContextMenu>
                <Columns>
                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" />
                    <dx:GridViewDataColumn FieldName="C1" />
                    <dx:GridViewDataSpinEditColumn FieldName="C2" />
                    <dx:GridViewDataTextColumn FieldName="C3" />
                    <dx:GridViewDataCheckColumn FieldName="C4" />
                    <dx:GridViewDataDateColumn FieldName="C5" />
                </Columns>
            </dx:ASPxGridView>
        </div>
    </form>
</body>
</html>

