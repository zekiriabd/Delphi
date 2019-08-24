program Project10;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit9 in 'Unit9.pas' {Form9},
  ConnectionModule in 'ConnectionModule.pas' {MSSQLConnection: TDataModule},
  UserDB in 'UserDB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMSSQLConnection, MSSQLConnection);
  Application.CreateForm(TForm9, Form9);
  Application.Run;
end.
