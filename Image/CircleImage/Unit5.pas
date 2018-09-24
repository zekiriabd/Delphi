unit Unit5;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP,system.iOUtils;

type
  TForm5 = class(TForm)
    Circle1: TCircle;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.Button1Click(Sender: TObject);
var path : string;
begin
  {$IFDEF MSWINDOWS}
    path := ExpandFileName(GetCurrentDir) + '\bebe1.jpg';
  {$ELSE}
    path := TPath.GetDocumentsPath + PathDelim + 'bebe1.jpg';
  {$ENDIF}
  Circle1.Fill.Bitmap.Bitmap.LoadFromFile(path);
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  idhttp : TIdHTTP;
  memStream: TMemoryStream;
begin
  try
    memStream := TMemoryStream.Create();
    idhttp    := TIdHTTP.Create();
    idhttp.Get('http://i.imgur.com/2peTq0G.jpg',memStream);
    Circle1.Fill.Bitmap.Bitmap.LoadFromStream(memStream);
  finally
    memStream.Free;
    idhttp.Free;
  end;

end;


end.
