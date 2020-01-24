unit View.Login;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Controls, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls,
  XData.Web.Connection, WEBLib.ExtCtrls,
  App.Types,
  ConnectionModule;

type
  TFViewLogin = class(TWebForm)
    WebLabel1: TWebLabel;
    edUser: TWebEdit;
    edPassword: TWebEdit;
    btLogin: TWebButton;
    pnlMessage: TWebPanel;
    lbMessage: TWebLabel;
    WebButton1: TWebButton;
    procedure btLoginClick(Sender: TObject);
    procedure WebButton1Click(Sender: TObject);
    procedure WebFormCreate(Sender: TObject);
    procedure edUserKeyPress(Sender: TObject; var Key: Char);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    FLoginProc: TSuccessProc;
    FMessage: string;
    procedure ShowNotification(Notification: string);
    procedure HiddenNotification;
  public
    class procedure Display(AElementId: string; LoginProc: TSuccessProc); overload;
    class procedure Display(AElementId: string; LoginProc: TSuccessProc;
      AMsg: string); overload;
  end;

var
  FViewLogin: TFViewLogin;

implementation

uses
  Auth.Service,
  View.ErrorPage;

{$R *.dfm}

procedure TFViewLogin.btLoginClick(Sender: TObject);

  procedure LoginSuccess;
  begin
    FLoginProc;
  end;

  procedure LoginError(AMsg: string);
  begin
    ShowNotification('Login Error: ' + AMsg);
  end;

begin
  AuthService.Login(
    edUser.Text, edPassword.Text,
    @LoginSuccess,
    @LoginError
  );
end;

class procedure TFViewLogin.Display(AElementId: string; LoginProc: TSuccessProc);
begin
  TFViewLogin.Display(AElementId, LoginProc, '');
end;

class procedure TFViewLogin.Display(AElementId: string; LoginProc: TSuccessProc;
  AMsg: string);

  procedure AfterCreate(AForm: TObject);
  begin
    TFViewLogin(AForm).FMessage := AMsg;
    TFViewLogin(AForm).FLoginProc := LoginProc;
  end;

begin
  if Assigned(FViewLogin) then
    FViewLogin.Free;
  FViewLogin := TFViewLogin.CreateNew(AElementId, @AfterCreate);
end;

procedure TFViewLogin.edUserKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    edPassword.SetFocus;
end;

procedure TFViewLogin.edPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btLogin.Click;
end;

procedure TFViewLogin.HiddenNotification;
begin
  pnlMessage.ElementHandle.hidden := True;
end;

procedure TFViewLogin.ShowNotification(Notification: string);
begin
  if Notification <> '' then
  begin
    lbMessage.Caption := Notification;
    pnlMessage.ElementHandle.hidden := False;
  end;
end;

procedure TFViewLogin.WebButton1Click(Sender: TObject);
begin
  HiddenNotification;
end;

procedure TFViewLogin.WebFormCreate(Sender: TObject);
begin
  if FMessage <> '' then
    ShowNotification(FMessage)
  else
    HiddenNotification;
end;

end.
