using DevExpress.Web.Data;
using System;
using System.Web.UI;

public partial class HotKeys : Page {
    protected void Page_Init(object sender, EventArgs e) {
        Grid.DataSource = GridDataItem.GetData();
        Grid.DataBind();
    }

    protected void Grid_BatchUpdate(object sender, ASPxDataBatchUpdateEventArgs e) {
        foreach(var args in e.InsertValues)
            GridDataItem.InsertNewItem(args.NewValues);
        foreach(var args in e.UpdateValues)
            GridDataItem.UpdateItem(args.Keys, args.NewValues);
        e.Handled = true;
    }
}