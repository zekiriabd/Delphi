object FViewUserProfile: TFViewUserProfile
  Left = 0
  Top = 0
  Width = 604
  Height = 434
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TabOrder = 1
  OnShow = WebFormShow
  object WebLabel1: TWebLabel
    Left = 24
    Top = 24
    Width = 55
    Height = 13
    Caption = 'User Profile'
    ElementID = 'view.userprofile.title'
    Transparent = True
  end
  object WebLabel3: TWebLabel
    Left = 24
    Top = 59
    Width = 26
    Height = 13
    Caption = 'User:'
    ElementID = 'view.userprofile.form.lbUser'
    Transparent = True
  end
  object WebLabel2: TWebLabel
    Left = 24
    Top = 86
    Width = 21
    Height = 13
    Caption = 'Jwt:'
    ElementID = 'view.userprofile.form.lbJwt'
    Transparent = True
  end
  object edUser: TWebEdit
    Left = 56
    Top = 56
    Width = 121
    Height = 21
    ElementID = 'view.userprofile.form.edUser'
    ReadOnly = True
    TabOrder = 0
  end
  object edJwt: TWebEdit
    Left = 56
    Top = 83
    Width = 121
    Height = 21
    ElementID = 'view.userprofile.form.edJwt'
    ReadOnly = True
    TabOrder = 1
  end
end
