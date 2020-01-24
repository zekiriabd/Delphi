object FViewErrorPage: TFViewErrorPage
  Left = 0
  Top = 0
  Width = 534
  Height = 426
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  object lbTitle: TWebLabel
    Left = 24
    Top = 24
    Width = 128
    Height = 13
    Caption = 'Oops... an error occurred!'
    ElementID = 'view.errorpage.title'
    Transparent = False
  end
  object lbMessage: TWebLabel
    Left = 24
    Top = 56
    Width = 42
    Height = 13
    Caption = 'Message'
    ElementID = 'view.errorpage.message'
    Transparent = False
  end
end
