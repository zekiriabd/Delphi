unit ConnectionModule;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Modules, XData.Web.Connection,
  App.Types, App.Config;

type
  TDMConnection = class(TWebDataModule)
    ApiConnection: TXDataWebConnection;
    AuthConnection: TXDataWebConnection;
    procedure ApiConnectionError(Error: TXDataWebConnectionError);
    procedure ApiConnectionRequest(Args: TXDataWebConnectionRequest);
    procedure ApiConnectionResponse(Args: TXDataWebConnectionResponse);
  private
    FUnauthorizedAccessProc: TUnauthorizedAccessProc;
  public
    procedure InitApp(SuccessProc: TSuccessProc;
      UnauthorizedAccessProc: TUnauthorizedAccessProc);
  end;

var
  DMConnection: TDMConnection;

implementation

uses
  JS, Web,
  XData.Web.Request,
  XData.Web.Response,
  Auth.Service,
  View.ErrorPage;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMConnection.ApiConnectionError(Error: TXDataWebConnectionError);
begin
  TFViewErrorPage.DisplayConnectionError(Error);
end;

procedure TDMConnection.ApiConnectionRequest(Args: TXDataWebConnectionRequest);
begin
  if AuthService.Authenticated then
    Args.Request.Headers.SetValue('Authorization', 'Bearer ' + AuthService.GetToken);
end;

procedure TDMConnection.ApiConnectionResponse(
  Args: TXDataWebConnectionResponse);
begin
  if Args.Response.StatusCode = 401 then
    FUnauthorizedAccessProc(Format('%d: %s',[Args.Response.StatusCode, Args.Response.ContentAsText]));
end;

procedure TDMConnection.InitApp(SuccessProc: TSuccessProc;
  UnauthorizedAccessProc: TUnauthorizedAccessProc);

  procedure ConfigLoaded(Config: TAppConfig);
  begin
    if Config.ApiUrl <> '' then
      ApiConnection.URL := Config.ApiUrl;

    ApiConnection.Open(SuccessProc);
  end;
  
begin
  FUnauthorizedAccessProc := UnauthorizedAccessProc;
  LoadConfig(@ConfigLoaded);
end;

end.
