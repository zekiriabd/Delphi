object FViewHome: TFViewHome
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  OnCreate = WebFormCreate
  object WebLabel1: TWebLabel
    Left = 24
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Home'
    ElementID = 'view.home.title'
    Transparent = True
  end
  object tcHome: TWebTableControl
    Left = 24
    Top = 43
    Width = 429
    Height = 214
    ElementClassName = 'table-responsive'
    ElementID = 'view.home.list'
    Align = alCustom
    BorderColor = clSilver
    ColHeader = False
    ElementTableClassName = 'table table-striped table-bordered table-hover'
    ColCount = 1
    RowCount = 1
  end
  object XDataClient: TXDataWebClient
    Connection = DMConnection.ApiConnection
    OnLoad = XDataClientLoad
    Left = 496
    Top = 64
  end
end
