object FViewuserList: TFViewuserList
  Left = 0
  Top = 0
  Width = 695
  Height = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  OnCreate = WebFormCreate
  object lbPaginationInfo: TWebLabel
    Left = 8
    Top = 376
    Width = 141
    Height = 13
    Caption = 'Showing 1 to 10 of 57 entries'
    ElementID = 'view.user.list.pagination.info'
    Transparent = True
  end
  object btNew: TWebButton
    Left = 8
    Top = 8
    Width = 50
    Height = 25
    Caption = 'New'
    ElementID = 'view.user.list.newbutton'
    TabOrder = 0
    OnClick = btNewClick
  end
  object WebDBTableControl1: TWebDBTableControl
    Left = 8
    Top = 94
    Width = 521
    Height = 265
    ElementClassName = 'table-responsive'
    ElementID = 'view.user.list.table'
    BorderColor = clSilver
    ColHeader = False
    ElementTableClassName = 'table table-striped table-bordered table-hover dataTable'
    OnGetCellChildren = WebDBTableControl1GetCellChildren
    Columns = <
      item
        DataField = 'id'
        Title = 'id'
      end
      item
        DataField = 'FirstName'
        Title = 'FirstName'
      end
      item
        DataField = 'LastName'
        Title = 'LastName'
      end
      item
        Title = 'Actions'
      end>
    DataSource = WebDataSource
  end
  object cbPageSize: TWebComboBox
    Left = 8
    Top = 67
    Width = 81
    Height = 21
    ElementID = 'view.user.list.cbPageSize'
    ItemIndex = 0
    Items.Strings = (
      '10'
      '25'
      '50'
      '100')
    TabOrder = 2
    Text = '10'
    OnChange = cbPageSizeChange
  end
  object edSearch: TWebEdit
    Left = 408
    Top = 67
    Width = 121
    Height = 21
    ElementID = 'view.user.list.search'
    TabOrder = 3
    OnChange = edSearchChange
  end
  object lcPaginator: TWebListControl
    Left = 240
    Top = 365
    Width = 289
    Height = 25
    ElementID = 'view.user.list.pagination'
    DefaultItemClassName = 'page-item'
    DefaultItemLinkClassName = 'page-link'
    ElementListClassName = 'pagination'
    Items = <>
    Style = lsPagination
  end
  object userDataset: TXDataWebDataSet
    EntitySetName = 'user'
    Connection = DMConnection.ApiConnection
    Left = 72
    Top = 144
    object userDatasetid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object userDatasetFirstName: TStringField
      FieldName = 'FirstName'
      Required = True
      Size = 255
    end
    object userDatasetLastName: TStringField
      FieldName = 'LastName'
      Required = True
      Size = 255
    end
  end
  object WebDataSource: TWebDataSource
    DataSet = userDataset
    Left = 72
    Top = 200
  end
end
