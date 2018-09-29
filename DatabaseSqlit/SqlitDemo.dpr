program SqlitDemo;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit5 in 'Unit5.pas' {Form5},
  User in 'Models\User.pas',
  DatabaseAccess in 'Database\DatabaseAccess.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
