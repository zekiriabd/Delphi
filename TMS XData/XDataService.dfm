object ServerContainer: TServerContainer
  OldCreateOrder = False
  Height = 210
  Width = 431
  object SparkleHttpSysDispatcher: TSparkleHttpSysDispatcher
    Active = True
    Left = 72
    Top = 16
  end
  object XDataServer: TXDataServer
    BaseUrl = 'http://+:3001/softwe3/'
    Dispatcher = SparkleHttpSysDispatcher
    Pool = XDataConnectionPool
    DefaultEntitySetPermissions = [List]
    EntitySetPermissions = <
      item
        EntitySetName = 'user'
        Permissions = [List, Get, Insert, Modify, Delete]
      end>
    Left = 216
    Top = 16
    object XDataServerCORS: TSparkleCorsMiddleware
      Origin = 'www.MyClient.net'
    end
  end
  object XDataConnectionPool: TXDataConnectionPool
    Connection = AureliusConnection
    Left = 216
    Top = 72
  end
  object AureliusConnection: TAureliusConnection
    AdapterName = 'FireDac'
    AdaptedConnection = FDConnection1
    SQLDialect = 'MySQL'
    Left = 216
    Top = 128
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=usersmanagement'
      'Server=127.0.0.1'
      'User_Name=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 56
    Top = 128
  end
end
