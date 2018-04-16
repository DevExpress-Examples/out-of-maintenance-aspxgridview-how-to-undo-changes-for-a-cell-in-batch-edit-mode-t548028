using DevExpress.Web.Data;
using System;
using System.Web.UI;

public partial class ContextMenu : Page {

    protected void Page_Init(object sender, EventArgs e) {
        Grid.DataSource = GridDataItem.GetData();
        Grid.DataBind();
    }

    protected void Grid_FillContextMenuItems(object sender, DevExpress.Web.ASPxGridViewContextMenuEventArgs e) {
        if(e.MenuType == DevExpress.Web.GridViewContextMenuType.Rows) {
            e.Items.Add(e.CreateItem("Reset Changes", "reset_cell"));
        }
    }

    protected void Grid_HtmlDataCellPrepared(object sender, DevExpress.Web.ASPxGridViewTableDataCellEventArgs e) {
        e.Cell.Attributes.Add("oncontextmenu", "onCellRightBtnClick(" + e.DataColumn.Index + ")");
    }

    protected void Grid_BatchUpdate(object sender, ASPxDataBatchUpdateEventArgs e) {
        foreach(var args in e.InsertValues)
            GridDataItem.InsertNewItem(args.NewValues);
        foreach(var args in e.UpdateValues)
            GridDataItem.UpdateItem(args.Keys, args.NewValues);
        e.Handled = true;
    }
}