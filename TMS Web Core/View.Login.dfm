object FViewLogin: TFViewLogin
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
    Left = 240
    Top = 112
    Width = 67
    Height = 13
    Caption = 'Please Sign In'
    ElementID = 'view.login.title'
    Transparent = False
  end
  object edUser: TWebEdit
    Left = 240
    Top = 136
    Width = 121
    Height = 21
    ElementID = 'view.login.eduser'
    TabOrder = 0
    TextHint = 'User'
    OnKeyPress = edUserKeyPress
  end
  object edPassword: TWebEdit
    Left = 240
    Top = 163
    Width = 121
    Height = 21
    ElementID = 'view.login.edpassword'
    PasswordChar = '*'
    TabOrder = 1
    TextHint = 'Password'
    OnKeyPress = edPasswordKeyPress
  end
  object btLogin: TWebButton
    Left = 240
    Top = 190
    Width = 121
    Height = 25
    Caption = 'Login'
    ElementID = 'view.login.btlogin'
    TabOrder = 2
    OnClick = btLoginClick
  end
  object pnlMessage: TWebPanel
    Left = 240
    Top = 32
    Width = 121
    Height = 33
    ElementID = 'view.login.message'
    BorderColor = clSilver
    BorderStyle = bsSingle
    object lbMessage: TWebLabel
      Left = 16
      Top = 11
      Width = 42
      Height = 13
      Caption = 'Message'
      ElementID = 'view.login.message.label'
      Transparent = True
    end
    object WebButton1: TWebButton
      Left = 96
      Top = 3
      Width = 22
      Height = 25
      Caption = 'x'
      ElementID = 'view.login.message.button'
      TabOrder = 0
      OnClick = WebButton1Click
    end
  end
end
