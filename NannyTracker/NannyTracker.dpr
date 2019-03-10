program NannyTracker;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  MainPage in 'MainPage.pas' {FMainPage},
  uUser in 'Models\uUser.pas',
  uBaby in 'Models\uBaby.pas',
  BabyEdit in 'View\BabyEdit.pas' {FBabyEdit: TFrame},
  BabyList in 'View\BabyList.pas' {FBabyList: TFrame},
  LyoutHeader in 'View\LyoutHeader.pas' {FlyoutHeader: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMainPage, FMainPage);
  //Application.CreateForm(TFlyoutHeader, FlyoutHeader);
  Application.Run;
end.
