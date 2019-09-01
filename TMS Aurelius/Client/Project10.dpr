program Project10;

uses
  Vcl.Forms,
  Unit9 in 'Unit9.pas' {Form9},
  ConnectionModule in '..\ORM\ConnectionModule.pas' {dbGoMSSQLConnection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TdbGoMSSQLConnection, dbGoMSSQLConnection);
  Application.Run;
end.
