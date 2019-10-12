object UserResource1: TUserResource1
  OldCreateOrder = False
  Height = 300
  Width = 600
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=UsersManagementConn')
    LoginPrompt = False
    Left = 302
    Top = 168
  end
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = FDConnection1
    SQLDialect = 'MySQL'
    Left = 304
    Top = 96
  end
end
