program Project10;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit9 in 'Unit9.pas' {Form9},
  ConnectionModule in 'ConnectionModule.pas' {MSSQLConnection: TDataModule},
  Unit1 in 'Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TMSSQLConnection, MSSQLConnection);
  Application.Run;
end.
