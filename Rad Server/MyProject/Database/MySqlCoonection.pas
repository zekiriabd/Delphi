unit MySqlCoonection;

// EMS Resource Module

interface

uses
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.FireDac,
  FireDAC.Dapt,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Aurelius.Sql.MySQL,
  Aurelius.Schema.MySQL, Aurelius.Comp.Connection, Data.DB, FireDAC.Comp.Client,
  Aurelius.Sql.Oracle, Aurelius.Schema.Oracle;

type
  TUserResource1 = class(TDataModule)
    FDConnection1: TFDConnection;
    AureliusConnection1: TAureliusConnection;
public
    class function CreateConnection: IDBConnection;
    class function CreateFactory: IDBConnectionFactory;
end;

var
UserResource1: TUserResource1;

implementation
{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Aurelius.Drivers.Base;

{$R *.dfm}

{ TMyConnectionModule }

class function TUserResource1.CreateConnection: IDBConnection;
begin
  Result := UserResource1.AureliusConnection1.CreateConnection;
end;

class function TUserResource1.CreateFactory: IDBConnectionFactory;
begin
  Result := TDBConnectionFactory.Create(
    function: IDBConnection
    begin
      Result := CreateConnection;
    end
  );
end;
end.


