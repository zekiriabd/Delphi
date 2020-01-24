object FViewCrudContainer: TFViewCrudContainer
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
  object lbTitle: TWebLabel
    Left = 32
    Top = 16
    Width = 20
    Height = 13
    Caption = 'Title'
    ElementID = 'view.crudcontainer.title'
    Transparent = True
  end
  object WebPanel1: TWebPanel
    Left = 24
    Top = 43
    Width = 521
    Height = 289
    ElementID = 'view.crudcontainer.webpanel'
    BorderColor = clSilver
    BorderStyle = bsSingle
  end
end
