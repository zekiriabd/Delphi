object dbGoMSSQLConnection: TdbGoMSSQLConnection
  OldCreateOrder = True
  Height = 198
  Width = 282
  object Connection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Persist Security Info=False;User ID=sa;Init' +
      'ial Catalog="";Data Source=DESKTOP-MAGJ7HQ\SQLEXPRESS;Initial Fi' +
      'le Name="";Server SPN="";'
    Provider = 'SQLNCLI11.1'
    Left = 64
    Top = 8
  end
  object AureliusConnection1: TAureliusConnection
    AdapterName = 'dbGo'
    AdaptedConnection = Connection
    SQLDialect = 'MSSQL'
    Left = 176
    Top = 8
  end
end
