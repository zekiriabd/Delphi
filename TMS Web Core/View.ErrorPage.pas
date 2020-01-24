unit View.ErrorPage;

interface

uses
  System.SysUtils, System.Classes, WEBLib.Graphics, WEBLib.Controls, WEBLib.Forms, WEBLib.Dialogs,
  Vcl.Controls, Vcl.StdCtrls,

  XData.Web.Connection, WEBLib.StdCtrls;

type
  TFViewErrorPage = class(TWebForm)
    lbTitle: TWebLabel;
    lbMessage: TWebLabel;
  public
    class procedure Display(AErrorMessage: string);
    class procedure DisplayConnectionError(AError: TXDataWebConnectionError);
  end;

var
  FViewErrorPage: TFViewErrorPage;

implementation

{$R *.dfm}

{ TFViewErrorPage }

class procedure TFViewErrorPage.Display(AErrorMessage: string);

  procedure AfterCreateProc(AForm: TObject);
  begin
    TFViewErrorPage(AForm).lbMessage.Caption := AErrorMessage;
  end;

begin
  if Assigned(FViewErrorPage) then
    FViewErrorPage.Free;
  FViewErrorPage := TFViewErrorPage.CreateNew(@AfterCreateProc);
end;

class procedure TFViewErrorPage.DisplayConnectionError(
  AError: TXDataWebConnectionError);
begin
  Display(AError.ErrorMessage + ': ' + AError.RequestUrl);
end;

end.
