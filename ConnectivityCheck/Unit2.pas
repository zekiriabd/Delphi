unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.ScrollBox, FMX.Memo,
  System.Net.HttpClient,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form2: TForm2;

implementation
{$ifdef Android}
uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.NET,
  Androidapi.JNI.GraphicsContentViewText;
{$ENDIF}
{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
var
  WifiManagerObj: JObject;
  WifiManager: JWifiManager;
  WifiInfo: JWifiInfo;
begin
  WifiManagerObj := SharedActivityContext.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  WifiManager    := TJWifiManager.Wrap((WifiManagerObj as ILocalObject).GetObjectID);
  WifiInfo       := WifiManager.getConnectionInfo();

  Memo1.Lines.Clear;

  Memo1.Lines.Add('------------------------------ ');
  Memo1.Lines.Add('Wifi Enabled: '    + WifiManager.isWifiEnabled.ToString);
  Memo1.Lines.Add('Wifi State: '      + WifiManager.getWifiState.ToString);
  Memo1.Lines.Add('Ping Supplicant: ' + WifiManager.pingSupplicant.ToString);
  Memo1.Lines.Add('------------------------------ ');
  Memo1.Lines.Add('BSSID: ' + JStringToString(WifiInfo.getBSSID));
  Memo1.Lines.Add('HiddenSSID: ' + WifiInfo.getHiddenSSID.ToString);
  Memo1.Lines.Add('IpAddress: ' + WifiInfo.getIpAddress.ToString);
  Memo1.Lines.Add('LinkSpeed: ' + WifiInfo.getLinkSpeed.ToString + 'Mbps');
  Memo1.Lines.Add('MacAddress: ' + JStringToString(WifiInfo.getMacAddress));
  Memo1.Lines.Add('NetworkId: ' + WifiInfo.getNetworkId.ToString);
  Memo1.Lines.Add('Rssi: ' + WifiInfo.getRssi.ToString + 'dBm');
  Memo1.Lines.Add('SSID: ' + JStringToString(WifiInfo.getSSID));
  Memo1.Lines.Add('SupplicantState: ' + JStringToString(WifiInfo.getSupplicantState.toString));
end;

procedure TForm2.Button2Click(Sender: TObject);
var
    //IdTCPClient : TIdTCPClient;
    Result:string;
    statusCode : Integer;
begin

  with THTTPClient.Create do
  try
    try
      statusCode := Head('http://google.com').StatusCode;
      Result := 'Is conetcted ' + statusCode.ToString();
    except
      Result := 'Is not conetcted';
    end;
  finally
    Free;
    ShowMessage(Result);
  end;
end;
end.
