object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
  ClientHeight = 417
  ClientWidth = 722
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
  object StringGridPrototypeBindSource1: TStringGrid
    Tag = 3
    Left = 40
    Top = 80
    Width = 553
    Height = 177
    ColCount = 3
    FixedCols = 0
    RowCount = 201
    TabOrder = 0
    ColWidths = (
      64
      64
      64)
  end
  object Button1: TButton
    Left = 518
    Top = 263
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 40
    Top = 263
    Width = 202
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 248
    Top = 263
    Width = 264
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = True
    AutoPost = False
    FieldDefs = <
      item
        Name = 'id'
        FieldType = ftInteger
        ReadOnly = False
      end
      item
        Name = 'firstName'
        ReadOnly = False
      end
      item
        Name = 'lastName'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = PrototypeBindSource1CreateAdapter
    Left = 88
    Top = 8
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 180
    Top = 5
    object LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource1
      GridControl = StringGridPrototypeBindSource1
      Columns = <>
    end
  end
end
