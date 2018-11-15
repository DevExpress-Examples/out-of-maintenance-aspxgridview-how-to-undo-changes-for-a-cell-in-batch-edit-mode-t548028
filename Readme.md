<!-- default file list -->
*Files to look at*:

* [GridDataItem.cs](./CS/App_Code/Models/GridDataItem.cs) (VB: [GridDataItem.vb](./VB/App_Code/Models/GridDataItem.vb))
* [ContextMenu.aspx](./CS/ContextMenu.aspx) (VB: [ContextMenu.aspx.vb](./VB/ContextMenu.aspx.vb))
* [ContextMenu.aspx.cs](./CS/ContextMenu.aspx.cs) (VB: [ContextMenu.aspx.vb](./VB/ContextMenu.aspx.vb))
* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [HotKeys.aspx](./CS/HotKeys.aspx) (VB: [HotKeys.aspx.vb](./VB/HotKeys.aspx.vb))
* [HotKeys.aspx.cs](./CS/HotKeys.aspx.cs) (VB: [HotKeys.aspx.vb](./VB/HotKeys.aspx.vb))
<!-- default file list end -->
# ASPxGridView - How to undo changes for a cell in Batch Edit Mode


<p>This example demonstrates two approaches to reset cell changes.<br>1) It is allowed to reset changes for a cell via the context menu item.<br>2) It is possible to undo the last change of the modified cell value using 'Ctrl+Z' hot keys.<br>For detailed information, see Implementation Details.<br><strong>If you wish to use both approaches at once in your project, you need to synchronize the changedCells stack from the 'HotKey' approach with actual cells that were changed after resetting a value via the context menu item.</strong></p>
<br><br><br><br><br><br><br>


<h3>Description</h3>

<p>1. The Context Menu approach<br>Add an item to the context menu in the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridView_FillContextMenuItemstopic">ASPxGridView.FillContextMenuItems</a>&nbsp;event handler as follows:</p>
<code lang="cs">protected void Grid_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if(e.MenuType == DevExpress.Web.GridViewContextMenuType.Rows) {
            e.Items.Add(e.CreateItem("Reset Changes", "reset_cell"));
        }
    }
</code>
<p>To identify each cell, add the "oncontextmenu" attribute for every cell and send its&nbsp;column index to the client-side function as shown below: &nbsp;</p>
<code lang="cs">protected void Grid_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e) {
        e.Cell.Attributes.Add("oncontextmenu", "onCellRightBtnClick(" + e.DataColumn.Index + ")");
    }
</code>
<p>On the client side, there are two functions (<em>onCellRightBtnClick</em>,&nbsp;<em>onContextItemClick</em>) and one global variable (<em>clickedColumnIndex</em>).&nbsp;</p>
<p>The <em>onContextItemClick</em> function is a handler of the ASPxClientGridView.ContextMenuItemClick event.<br>The&nbsp;<em>clickedColumnIndex</em> variable is used as a parameter of the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientCardViewBatchEditApi_ResetChangestopic(HeuboQ)">ASPxClientCardViewBatchEditApi.ResetChanges(Int32,Int32)</a>&nbsp;method.<br><br>2. The Hot Keys approach<br>It is implemented fully on the client side. The main idea is to store changed cells in&nbsp;a stack&nbsp;and remove a value&nbsp;if the <strong>'Ctrl + Z'</strong> combination is&nbsp;performed.&nbsp;<br>A cell is initialized in the client-side <em>BatchEditStartEditing</em> event. In the client-side&nbsp;<em>BatchEditEndEditing</em> event, the modified cell is added to the stack.&nbsp;<br>For&nbsp;new rows, a value&nbsp;is pushed into the stack once for each new row. Further cells changes in new rows won't be stored in the stack.<br>If&nbsp;a cell gets its old value,&nbsp;there is no need to keep it in the stack. The <em>removeCellFromStack</em> function&nbsp;is used for this purpose.</p>

<br/>


