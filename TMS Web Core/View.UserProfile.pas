unit View.UserProfile;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Controls, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TFViewUserProfile = class(TWebForm)
    WebLabel1: TWebLabel;
    WebLabel3: TWebLabel;
    edUser: TWebEdit;
    WebLabel2: TWebLabel;
    edJwt: TWebEdit;
    procedure WebFormShow(Sender: TObject);
  end;

var
  FViewUserProfile: TFViewUserProfile;

implementation

uses
  JS,
  Auth.Service;

{$R *.dfm}

procedure TFViewUserProfile.WebFormShow(Sender: TObject);
begin
  edUser.Text := JS.toString(AuthService.TokenPayload.Properties['user']);
  edJwt.Text := TJSJSON.stringify(AuthService.TokenPayload);
end;

end.
