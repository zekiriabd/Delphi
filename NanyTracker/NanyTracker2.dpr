program NanyTracker2;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  UBaby in 'Models\UBaby.pas',
  DatabaseAccess in 'Database\DatabaseAccess.pas' {DataModule1: TDataModule},
  BabyList in 'View\BabyList.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
