Imports Microsoft.VisualBasic
Imports DevExpress.Web.Data
Imports System
Imports System.Web.UI

Partial Public Class HotKeys
	Inherits Page
	Protected Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs)
		Grid.DataSource = GridDataItem.GetData()
		Grid.DataBind()
	End Sub

	Protected Sub Grid_BatchUpdate(ByVal sender As Object, ByVal e As ASPxDataBatchUpdateEventArgs)
		For Each args In e.InsertValues
			GridDataItem.InsertNewItem(args.NewValues)
		Next args
		For Each args In e.UpdateValues
			GridDataItem.UpdateItem(args.Keys, args.NewValues)
		Next args
		e.Handled = True
	End Sub
End Class