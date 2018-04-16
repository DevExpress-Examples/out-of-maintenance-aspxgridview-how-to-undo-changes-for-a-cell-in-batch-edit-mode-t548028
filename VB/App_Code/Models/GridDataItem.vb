Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Collections.Specialized
Imports System.Linq
Imports System.Web

Public Class GridDataItem
	Private privateID As Integer
	Public Property ID() As Integer
		Get
			Return privateID
		End Get
		Set(ByVal value As Integer)
			privateID = value
		End Set
	End Property
	Private privateC1 As Integer
	Public Property C1() As Integer
		Get
			Return privateC1
		End Get
		Set(ByVal value As Integer)
			privateC1 = value
		End Set
	End Property
	Private privateC2 As Double
	Public Property C2() As Double
		Get
			Return privateC2
		End Get
		Set(ByVal value As Double)
			privateC2 = value
		End Set
	End Property
	Private privateC3 As String
	Public Property C3() As String
		Get
			Return privateC3
		End Get
		Set(ByVal value As String)
			privateC3 = value
		End Set
	End Property
	Private privateC4 As Boolean
	Public Property C4() As Boolean
		Get
			Return privateC4
		End Get
		Set(ByVal value As Boolean)
			privateC4 = value
		End Set
	End Property
	Private privateC5 As DateTime
	Public Property C5() As DateTime
		Get
			Return privateC5
		End Get
		Set(ByVal value As DateTime)
			privateC5 = value
		End Set
	End Property

	Public Shared Function GetData() As List(Of GridDataItem)
		Dim key = "34FAA431-CF79-4869-9488-93F6AAE81263"
		If HttpContext.Current.Session(key) Is Nothing Then
			HttpContext.Current.Session(key) = Enumerable.Range(0, 100).Select(Function(i) New GridDataItem With {.ID = i, .C1 = i Mod 2, .C2 = i * 0.5 Mod 3, .C3 = "C3 " & i, .C4 = i Mod 2 = 0, .C5 = New DateTime(2013 + i, 12, 16)}).ToList()
		End If
		Return CType(HttpContext.Current.Session(key), List(Of GridDataItem))
	End Function

	Public Shared Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
		Dim item = New GridDataItem() With {.ID = GridDataItem.GetData().Count}
		LoadNewValues(item, newValues)
		GridDataItem.GetData().Add(item)
		Return item
	End Function

	Public Shared Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
		Dim id = Convert.ToInt32(keys("ID"))
		Dim item = GridDataItem.GetData().First(Function(i) i.ID = id)
		LoadNewValues(item, newValues)
		Return item
	End Function

	Protected Shared Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary)
		item.C1 = Convert.ToInt32(values("C1"))
		item.C2 = Convert.ToDouble(values("C2"))
		item.C3 = Convert.ToString(values("C3"))
		item.C4 = Convert.ToBoolean(values("C4"))
		item.C5 = Convert.ToDateTime(values("C5"))
	End Sub
End Class