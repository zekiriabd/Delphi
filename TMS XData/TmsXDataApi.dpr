program TmsXDataApi;

uses
  Vcl.Forms,
  XDataService in 'XDataService.pas' {ServerContainer: TDataModule},
  XDatatServer in 'XDatatServer.pas' {MainForm},
  uUser in 'Models\uUser.pas',
  uUserService in 'Controllers\uUserService.pas',
  uUserServiceImp in 'Controllers\uUserServiceImp.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TServerContainer, ServerContainer);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
