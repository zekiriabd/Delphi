object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 792
  Width = 1083
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=usersmanagement'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 104
    Top = 72
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 112
    Top = 136
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'usersmanagement.dflyway_schema'
    TableName = 'usersmanagement.dflyway_schema'
    Left = 184
    Top = 80
  end
end
