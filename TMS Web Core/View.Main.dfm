object FViewMain: TFViewMain
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
  object lbViewHome: TWebLinkLabel
    Left = 24
    Top = 92
    Width = 27
    Height = 13
    ElementID = 'main.menu.home'
    OnClick = lbViewHomeClick
    Caption = 'Home'
  end
  object lbViewuser: TWebLinkLabel
    Left = 24
    Top = 111
    Width = 26
    Height = 13
    ElementID = 'main.menu.user'
    OnClick = lbViewuserClick
    Caption = 'user'
  end
  object WebPanel1: TWebPanel
    Left = 136
    Top = 92
    Width = 471
    Height = 369
    ElementID = 'main.webpanel'
    BorderColor = clSilver
    BorderStyle = bsSingle
  end
end
