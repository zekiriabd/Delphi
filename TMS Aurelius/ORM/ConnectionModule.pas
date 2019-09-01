unit ConnectionModule;

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.dbGo, 
  System.SysUtils, System.Classes, Aurelius.Sql.MSSQL, Aurelius.Schema.MSSQL,
  Aurelius.Comp.Connection, Data.DB, Data.Win.ADODB;

type
  TdbGoMSSQLConnection = class(TDataModule)
    Connection: TADOConnection;
    AureliusConnection1: TAureliusConnection;
  private
  public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
    
  end;

var
  dbGoMSSQLConnection: TdbGoMSSQLConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses 
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TdbGoMSSQLConnection.CreateConnection: IDBConnection;
begin 
  Result := dbGoMSSQLConnection.AureliusConnection1.CreateConnection; 
end;

class function TdbGoMSSQLConnection.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;



end.
