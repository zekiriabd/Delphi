unit UserDataAccessTMS;

interface
uses
  Data.DB,

  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys.Intf,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.Phys,

  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.DatS,
  FireDAC.UI.Intf,

  System.Generics.Collections,
  System.SysUtils,

  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  Aurelius.Criteria.Linq,
  Aurelius.Criteria.Projections,
  Aurelius.Drivers.FireDac,
  Aurelius.Schema.MySQL,
  Aurelius.Comp.Connection,
  Aurelius.Sql.Mysql,
  User;

type
    TUserDataAccessTMS = class
      class function GetTmsManager():TObjectManager;static;
end;

implementation

class function TUserDataAccessTMS.GetTmsManager(): TObjectManager;
var
  FDConnection:TFDConnection;
  AureliusConnection1: TAureliusConnection;
  TmsConnection : IDBConnection;
begin
    try
      FDConnection := TFDConnection.Create(nil);
      FDConnection.Params.DriverID := 'MySQL';
      FDConnection.Params.Add('Server=127.0.0.1');
      FDConnection.Params.Database := 'usersmanagement';
      FDConnection.Params.UserName := 'root';
      FDConnection.Params.Password := '';

      AureliusConnection1:= TAureliusConnection.Create(nil);
      AureliusConnection1.AdaptedConnection := FDConnection;
      AureliusConnection1.AdapterName:='FireDac';
      AureliusConnection1.SQLDialect:='MySQL';

      TmsConnection :=AureliusConnection1.CreateConnection;

      TDatabaseManager.Update(TmsConnection);
      Result := TObjectManager.Create(TmsConnection);
    finally
      TmsConnection := nil;
      AureliusConnection1.Free;
      FDConnection.Free;
    end;
end;


end.


