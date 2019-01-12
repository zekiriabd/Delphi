unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  NetworkState;

procedure TForm1.Button1Click(Sender: TObject);
var
  NS: TNetworkState;
begin
  NS := TNetworkState.Create;
  try
    if not NS.IsConnected then
      Label1.Text := 'Not reachable'
    else if NS.IsWifiConnected then
      Label1.Text := 'Reachable via WiFi'
    else if NS.IsMobileConnected then
      Label1.Text := 'Reachable via WWAN';
    Label2.Text := NS.CurrentSSID;
  finally
    NS.Free;
  end;
end;

end.
