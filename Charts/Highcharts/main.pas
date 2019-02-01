unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.WebBrowser, FMX.Controls.Presentation ,system.iOUtils;

type
  TForm4 = class(TForm)
    Timer1: TTimer;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.fmx}

procedure TForm4.FormCreate(Sender: TObject);
var path :string;
begin
  {$IFDEF MSWINDOWS}
    path := ExpandFileName(GetCurrentDir) + '\index.html';
  {$ELSE}
    path := TPath.GetDocumentsPath + '/index.html';
  {$ENDIF}
   //ChromiumFMX1.Load('file://' + path );
   WebBrowser1.Navigate( 'file://' + path );
   WebBrowser1.EnableCaching:=false;
   Timer1.Enabled:=True;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled:=False;
     WebBrowser1.EvaluateJavaScript('Drawchart();');
   //ChromiumFMX1.Browser.MainFrame.ExecuteJavaScript('Drawchart();','',0);

end;

end.
