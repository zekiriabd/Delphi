program TMS Web Core;

{$R *.dres}

uses
  Vcl.Forms,
  XData.Web.Connection,
  App.Config in 'core\App.Config.pas',
  App.Types in 'core\App.Types.pas',
  Auth.Service in 'core\Auth.Service.pas',
  Dataset.Plugins in 'core\Dataset.Plugins.pas',
  Grid.Plugins in 'core\Grid.Plugins.pas',
  Grid.Settings in 'core\Grid.Settings.pas',
  Paginator.Plugins in 'core\Paginator.Plugins.pas',
  Crud.Utils in 'core\Crud.Utils.pas',
  ConnectionModule in 'ConnectionModule.pas' {DMConnection: TWebDataModule},
  View.UserProfile in 'View.UserProfile.pas' {FViewUserProfile: TWebForm} {*.html},
  View.ErrorPage in 'View.ErrorPage.pas' {FViewErrorPage: TWebForm} {*.html},
  View.Login in 'View.Login.pas' {FViewLogin: TWebForm} {*.html},
  View.Main in 'View.Main.pas' {FViewMain: TWebForm} {*.html},
  View.Home in 'View.Home.pas' {FViewHome: TWebForm} {*.html},  
  View.user.List in 'View.user.List.pas' {FViewuserList: TWebForm} {*.html},
  View.user.Edit in 'View.user.Edit.pas' {FViewuserEdit: TWebForm} {*.html},
  View.Crud.Container in 'View.Crud.Container.pas' {FViewCrudContainer: TWebForm} {*.html};

{$R *.res}

procedure DisplayLoginView(AMessage: string = ''); forward;

procedure DisplayMainView;

  procedure ConnectProc;
  begin
    TFViewMain.Display('body', @DisplayLoginView);
  end;

begin
  if not DMConnection.ApiConnection.Connected then
    DMConnection.ApiConnection.Open(@ConnectProc)
  else
    ConnectProc;
end;

procedure DisplayLoginView(AMessage: string);
begin
  AuthService.Logout;
  DMConnection.ApiConnection.Connected := False;
  TFViewLogin.Display('body', @DisplayMainView, AMessage);
end;

procedure UnauthorizedAccessProc(AMessage: string);
begin
  DisplayLoginView(AMessage);
end;

procedure StartApplication;
begin
  DisplayMainView;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConnection, DMConnection);
  Application.Run;
  DMConnection.InitApp(@StartApplication, @UnauthorizedAccessProc);
end.
