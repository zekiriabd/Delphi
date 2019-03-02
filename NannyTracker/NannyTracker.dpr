program NannyTracker;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  MainPage in 'MainPage.pas' {FMainPage},
  uUser in 'Models\uUser.pas',
  LyoutHeader in 'LyoutHeader.pas' {FlyoutHeader: TFrame},
  uBaby in 'Models\uBaby.pas',
  BabyList in 'BabyList.pas' {FBabyList: TFrame},
  BabyEdit in 'BabyEdit.pas' {FBabyEdit: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFMainPage, FMainPage);
  //Application.CreateForm(TFlyoutHeader, FlyoutHeader);
  Application.Run;
end.
