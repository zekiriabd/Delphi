unit main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.WebBrowser, FMX.Controls.Presentation ,system.iOUtils
   {$IFDEF MSWINDOWS}
  ,System.Win.Registry, FMX.Edit
  {$ENDIF}
  ;

type
  TForm4 = class(TForm)
    WebBrowser1: TWebBrowser;
    Timer1: TTimer;
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
   WebBrowser1.URL := 'file://' + path ;
   Timer1.Enabled:=true;
end;

procedure TForm4.Timer1Timer(Sender: TObject);
begin
   WebBrowser1.EvaluateJavaScript('Drawchart();');
   Timer1.Enabled:=false;
end;





end.
