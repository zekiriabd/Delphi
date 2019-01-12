unit NetworkState.Android;

interface

uses
  NetworkState;

type
  TPlatformNetworkState = class(TCustomNetworkState)
  public
    function CurrentSSID: string; override;
    function IsConnected: Boolean; override;
    function IsWifiConnected: Boolean; override;
    function IsMobileConnected: Boolean; override;
  end;

implementation

uses
  System.SysUtils,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.Helpers,
  Androidapi.JNI.NET,
  Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android;

type
  JConnectivityManager = interface;
  JNetworkInfo = interface;

  JNetworkInfoClass = interface(JObjectClass)
  ['{E92E86E8-0BDE-4D5F-B44E-3148BD63A14C}']
  end;

  [JavaSignature('android/net/NetworkInfo')]
  JNetworkInfo = interface(JObject)
  ['{6DF61A40-8D17-4E51-8EF2-32CDC81AC372}']
    {Methods}
    function isAvailable: Boolean; cdecl;
    function isConnected: Boolean; cdecl;
    function isConnectedOrConnecting: Boolean; cdecl;
  end;
  TJNetworkInfo = class(TJavaGenericImport<JNetworkInfoClass, JNetworkInfo>) end;

  JConnectivityManagerClass = interface(JObjectClass)
  ['{E03A261F-59A4-4236-8CDF-0068FC6C5FA1}']
    {Property methods}
    function _GetTYPE_WIFI: Integer; cdecl;
    function _GetTYPE_WIMAX: Integer; cdecl;
    function _GetTYPE_MOBILE: Integer; cdecl;
    {Properties}
    property TYPE_WIFI: Integer read _GetTYPE_WIFI;
    property TYPE_WIMAX: Integer read _GetTYPE_WIMAX;
    property TYPE_MOBILE: Integer read _GetTYPE_MOBILE;
  end;

  [JavaSignature('android/net/ConnectivityManager')]
  JConnectivityManager = interface(JObject)
  ['{1C4C1873-65AE-4722-8EEF-36BBF423C9C5}']
    {Methods}
    function getActiveNetworkInfo: JNetworkInfo; cdecl;
    function getNetworkInfo(networkType: Integer): JNetworkInfo; cdecl;
  end;
  TJConnectivityManager = class(TJavaGenericImport<JConnectivityManagerClass, JConnectivityManager>) end;

  JWifiManager = interface;
  JWifiInfo = interface;

  JWifiManagerClass = interface(JObjectClass)
    ['{69F35EA7-3EB9-48AA-B7FC-4FFD0E7D712F}']
    function _GetACTION_PICK_WIFI_NETWORK: JString;
    function _GetEXTRA_WIFI_INFO: JString;
    function _GetWIFI_STATE_CHANGED_ACTION: JString;

    property ACTION_PICK_WIFI_NETWORK: JString read _GetACTION_PICK_WIFI_NETWORK;
    property EXTRA_WIFI_INFO: JString read _GetEXTRA_WIFI_INFO;
    property WIFI_STATE_CHANGED_ACTION: JString read _GetWIFI_STATE_CHANGED_ACTION;
  end;

  [JavaSignature('android/net/wifi/WifiManager')]
  JWifiManager = interface(JObject)
    ['{DA7107B9-1FAD-4A9E-AA09-8D5B84614E60}']
    function isWifiEnabled: Boolean; cdecl;
    function setWifiEnabled(enabled: Boolean):Boolean; cdecl;
    //function getConfiguredNetworks : JList;cdecl;
    function getConnectionInfo: JWifiInfo; cdecl;
  end;

  TJWifiManager = class(TJavaGenericImport<JWifiManagerClass, JWifiManager>) end;

  JWifiInfoClass = interface(JObjectClass)
    ['{2B1CE79F-DE4A-40D9-BB2E-7F9F118D8C08}']
    function _GetLINK_SPEED_UNITS:JString;
    property LINK_SPEED_UNITS: JString read _GetLINK_SPEED_UNITS;
  end;

  [JavaSignature('android/net/wifi/WifiInfo')]
  JWifiInfo = interface(JObject)
    ['{4F09E865-DB04-4E64-8C81-AEFB36DABC45}']
    function getBSSID: JString; cdecl;
    function getHiddenSSID: Boolean; cdecl;
    function getIpAddress: integer; cdecl;
    function getLinkSpeed: integer; cdecl;
    function getMacAddress: JString; cdecl;
    function getNetworkId: integer; cdecl;
    function getRssi: integer; cdecl;
    function getSSID: JString; cdecl;
  end;

  TJWifiInfo= class(TJavaGenericImport<JWifiInfoClass, JWifiInfo>) end;

function GetWifiManager: JWifiManager;
var
  WifiManagerNative: JObject;
begin
  WifiManagerNative := SharedActivityContext.getSystemService(TJContext.JavaClass.WIFI_SERVICE);
  if not Assigned(WifiManagerNative) then
    raise Exception.Create('Could not locate Wifi Service');
  Result := TJWifiManager.Wrap((WifiManagerNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Wifi Manager');
end;

function GetConnectivityManager: JConnectivityManager;
var
  ConnectivityServiceNative: JObject;
begin
  ConnectivityServiceNative := SharedActivityContext.getSystemService(TJContext.JavaClass.CONNECTIVITY_SERVICE);
  if not Assigned(ConnectivityServiceNative) then
    raise Exception.Create('Could not locate Connectivity Service');
  Result := TJConnectivityManager.Wrap((ConnectivityServiceNative as ILocalObject).GetObjectID);
  if not Assigned(Result) then
    raise Exception.Create('Could not access Connectivity Manager');
end;

{ TPlatformNetworkState }

function TPlatformNetworkState.CurrentSSID: string;
var
  WifiManager: JWifiManager;
  Info: JWifiInfo;
begin
  Result := '';
  WifiManager := GetWifiManager;
  if Assigned(WifiManager) then
  begin
    Info := WifiManager.getConnectionInfo;
    if Assigned(Info) then
      Result := JStringToString(Info.getSSID);
  end;
end;

function TPlatformNetworkState.IsConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  ActiveNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  ActiveNetwork := ConnectivityManager.getActiveNetworkInfo;
  Result := Assigned(ActiveNetwork) and ActiveNetwork.isConnected;
end;

function TPlatformNetworkState.IsMobileConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  MobileNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  MobileNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_MOBILE);
  Result := MobileNetwork.isConnected;
end;

function TPlatformNetworkState.IsWifiConnected: Boolean;
var
  ConnectivityManager: JConnectivityManager;
  WiFiNetwork: JNetworkInfo;
begin
  ConnectivityManager := GetConnectivityManager;
  WiFiNetwork := ConnectivityManager.getNetworkInfo(TJConnectivityManager.JavaClass.TYPE_WIFI);
  Result := WiFiNetwork.isConnected;
end;

end.
