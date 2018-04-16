<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HotKeys.aspx.cs" Inherits="HotKeys" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Undo changes via hot keys</title>
    <script>
        var cell;
        var changedCells = [];

        document.onkeydown = onKeyDown;

        function onKeyDown(e) {
            if (e.keyCode == 90 && e.ctrlKey && changedCells.length != 0) {
                var cell = changedCells.pop();
                if (cell.rowHandle < 0) grid.batchEditApi.ResetChanges(cell.rowHandle);
                else grid.batchEditApi.SetCellValue(cell.rowHandle, cell.columnIndex, cell.value);
            }
        }

        function onBatchStartEditing(s, e) {
            columnIndex = e.visibleIndex < 0 ? null : e.focusedColumn.index;
            cell = new GridCell(e.visibleIndex, columnIndex, e.rowValues[e.focusedColumn.index].value);
        }

        function onBatchEndEditing(s, e) {
            setTimeout(function () {
                if (grid.batchEditApi.HasChanges(cell.rowHandle, cell.columnIndex) && !isNewRowAndExistsInArray(cell))
                    changedCells.push(cell);
                else removeCellFromStack(cell);
            }, 0);
        }

        function isNewRowAndExistsInArray(cell) {
            return changedCells.find(function (i) {
                return cell.rowHandle < 0 && i.equals(cell);
            }) ? true : false;
        }

        function removeCellFromStack(cell) {
            changedCells = changedCells.filter(function (i) {
                return !(cell.rowHandle >= 0 && i.equals(cell));
            });
        }

        function GridCell(rowHandle, columnIndex, value) {
            this.rowHandle = rowHandle;
            this.columnIndex = columnIndex;
            this.value = value;
            this.equals = Equals;
        }

        function Equals(cell) {
            return this.rowHandle == cell.rowHandle && this.columnIndex == cell.columnIndex; 
        }
    </script>
</head>
<body>
    <h3>Press 'Ctrl + Z' to undo cell changes or remove the new row</h3>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxGridView ID="Grid" runat="server" ClientInstanceName="grid" KeyFieldName="ID" OnBatchUpdate="Grid_BatchUpdate">
                <ClientSideEvents BatchEditStartEditing="onBatchStartEditing" BatchEditEndEditing="onBatchEndEditing" />
                <SettingsEditing Mode="Batch" />
                <Columns>
                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" />
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
