object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 281
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 21
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label3: TLabel
    Left = 10
    Top = 123
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Button1: TButton
    Left = 8
    Top = 78
    Width = 185
    Height = 36
    Caption = 'Add New'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 218
    Top = 18
    Width = 409
    Height = 169
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 147
    Width = 98
    Height = 36
    Caption = 'GetById'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 147
    Width = 79
    Height = 36
    Caption = 'Remove'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 70
    Top = 18
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 72
    Top = 51
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 72
    Top = 120
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
  end
  object Button4: TButton
    Left = 8
    Top = 197
    Width = 619
    Height = 36
    Caption = 'Get All'
    TabOrder = 7
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 239
    Width = 619
    Height = 36
    Caption = 'Del All'
    TabOrder = 8
    OnClick = Button5Click
  end
end
