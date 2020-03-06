program FlywayDemo;

uses
  Vcl.Forms,
  Unit2 in 'Unit2.pas' {Form2},
  Flyway in 'Flyway.pas',
  Unit1 in 'Unit1.pas' {DataModule1: TDataModule};

{$R *.res}

begin

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, DataModule1);
  TFlyway.Create();
  Application.Run;
end.
