program NannyTracker;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  MainPage in 'MainPage.pas' {FMainPage},
  uUser in 'Models\uUser.pas',
  LyoutHeader in 'LyoutHeader.pas' {FlyoutHeader: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMainPage, FMainPage);
  //Application.CreateForm(TFlyoutHeader, FlyoutHeader);
  Application.Run;
end.
