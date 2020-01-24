object FViewuserEdit: TFViewuserEdit
  Left = 0
  Top = 0
  Width = 593
  Height = 346
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  OnCreate = WebFormCreate 
  object pnlMessage: TWebPanel
    Left = 296
    Top = 113
    Width = 273
    Height = 60
    ElementID = 'view.user.form.message'
    BorderColor = clSilver
    BorderStyle = bsSingle
    object lbMessage: TWebLabel
      Left = 16
      Top = 24
      Width = 42
      Height = 13
      Caption = 'Message'
      ElementID = 'view.user.form.message.label'
      Transparent = True
    end
    object btCloseMessage: TWebButton
      Left = 248
      Top = 11
      Width = 22
      Height = 25
      Caption = 'x'
      ElementID = 'view.user.form.message.button'
      TabOrder = 0
      OnClick = btCloseMessageClick
    end
  end    
  object btCancel: TWebButton
    Left = 126
    Top = 286
    Width = 96
    Height = 25
    Caption = 'Cancel'
    ElementID = 'view.user.form.btBack'
    TabOrder = 1
    OnClick = btCancelClick
  end
  object btSave: TWebButton
    Left = 24
    Top = 286
    Width = 96
    Height = 25
    Caption = 'Save'
    ElementID = 'view.user.form.btSave'
    TabOrder = 4
    OnClick = btSaveClick
  end
  object btDelete: TWebButton
    Left = 305
    Top = 286
    Width = 96
    Height = 25
    Caption = 'Delete'
    ElementID = 'view.user.form.btDelete'
    TabOrder = 5
    OnClick = btDeleteClick
  end
  object lbid: TWebLabel
    Left = 24
    Top = 192
    Width = 14
    Height = 13
    Caption = 'id:'
    ElementID = 'view.user.form.lbid'
    Transparent = True
  end
  object edid: TWebDBEdit
    Left = 221
    Top = 189
    Width = 200
    Height = 21
    ElementID = 'view.user.form.edid'
    Enabled = True
    TabOrder = 6
    Text = 'edid'
    DataField = 'id'
    DataSource = DataSource
  end
  object lbFirstName: TWebLabel
    Left = 24
    Top = 219
    Width = 14
    Height = 13
    Caption = 'FirstName:'
    ElementID = 'view.user.form.lbFirstName'
    Transparent = True
  end
  object edFirstName: TWebDBEdit
    Left = 221
    Top = 216
    Width = 200
    Height = 21
    ElementID = 'view.user.form.edFirstName'
    Enabled = True
    TabOrder = 7
    Text = 'edFirstName'
    DataField = 'FirstName'
    DataSource = DataSource
  end
  object lbLastName: TWebLabel
    Left = 24
    Top = 246
    Width = 14
    Height = 13
    Caption = 'LastName:'
    ElementID = 'view.user.form.lbLastName'
    Transparent = True
  end
  object edLastName: TWebDBEdit
    Left = 221
    Top = 243
    Width = 200
    Height = 21
    ElementID = 'view.user.form.edLastName'
    Enabled = True
    TabOrder = 8
    Text = 'edLastName'
    DataField = 'LastName'
    DataSource = DataSource
  end
  object DataSource: TWebDataSource
    DataSet = userDataset
    Left = 176
    Top = 56
  end
  object userDataset: TXDataWebDataSet
    AfterApplyUpdates = userDatasetAfterApplyUpdates
    EntitySetName = 'user'
    Connection = DMConnection.ApiConnection
    Left = 176
    Top = 8
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
  object XDataClientuserGet: TXDataWebClient
    Connection = DMConnection.ApiConnection
    OnLoad = XDataClientuserGetLoad
    Left = 64
    Top = 8
  end
  object XDataClientuserDelete: TXDataWebClient
    Connection = DMConnection.ApiConnection
    OnLoad = XDataClientuserDeleteLoad
    OnError = XDataClientuserDeleteError
    Left = 64
    Top = 56
  end
end
