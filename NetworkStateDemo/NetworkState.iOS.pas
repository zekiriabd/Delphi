unit NetworkState.iOS;

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
  Macapi.ObjectiveC, 
  Macapi.CoreFoundation, 
  iOSApi.CocoaTypes, 
  iOSApi.Foundation,
  SCNetworkReachability, 
  CaptiveNetwork;

type
  SCNetworkReachabilityFlags = UInt32;

  TReachability = class;

  Reachability = interface(NSObject)
    ['{B405394F-57B1-4FF1-83D9-8FBFA38FFD7B}']
    function startNotifier: LongBool; cdecl;
    procedure stopNotifier; cdecl;
    function isReachable: LongBool; cdecl;
    function isReachableViaWWAN: LongBool; cdecl;
    function isReachableViaWiFi: LongBool; cdecl;
    function isConnectionRequired: LongBool; cdecl;
    function connectionRequired: LongBool; cdecl;
    function isConnectionOnDemand: LongBool; cdecl;
    function isInterventionRequired: LongBool; cdecl;
    function currentReachabilityStatus: NSInteger; cdecl;
    function reachabilityFlags: SCNetworkReachabilityFlags; cdecl;
    function currentReachabilityString: NSString; cdecl;
    function currentReachabilityFlags: NSString; cdecl;
  end;

  ReachabilityClass = interface(NSObjectClass)
    ['{39EC0490-2787-4BB9-95EA-77BB885BFD01}']
    function reachabilityWithHostname(hostname: NSString): pointer; cdecl;
    function reachabilityForInternetConnection: pointer; cdecl;
    function reachabilityWithAddress: pointer; cdecl;
    function reachabilityForLocalWiFi: pointer; cdecl;
  end;

  TReachability = class(TOCGenericImport<ReachabilityClass, Reachability>)
  end;

{$IFDEF CPUARM}
function FakeLoader: Reachability; cdecl; external 'libReachability.a' name 'OBJC_CLASS_$_Reachability';
{$ENDIF}

function GetInternetReachability: Reachability;
begin
  Result := TReachability.Wrap(TReachability.OCClass.reachabilityForInternetConnection);
end;

{ TPlatformNetworkState }

function TPlatformNetworkState.CurrentSSID: string;
var
  IntfArray: CFArrayRef;
  NetworkInfo: NSDictionary;
  IntfName: CFStringRef;
  SSID: Pointer;
begin
  Result := '';
  IntfArray := CNCopySupportedInterfaces;
  if Assigned(IntfArray) then
  begin
    IntfName := CFStringRef(CFArrayGetValueAtIndex(IntfArray, 0));
    if Assigned(IntfName) then
    begin
      NetworkInfo := TNSDictionary.Wrap(CNCopyCurrentNetworkInfo(IntfName));
      if Assigned(NetworkInfo) then
      begin
        SSID := NetworkInfo.valueForKey(NSSTR('SSID'));
        if Assigned(SSID) then
           Result := UTF8ToString(TNSString.Wrap(SSID).UTF8String);
      end;
    end;
  end;
end;

function TPlatformNetworkState.IsConnected: Boolean;
begin
  Result := GetInternetReachability.isReachable;
end;

function TPlatformNetworkState.IsMobileConnected: Boolean;
begin
  Result := GetInternetReachability.isReachableViaWWAN;
end;

function TPlatformNetworkState.IsWifiConnected: Boolean;
begin
  Result := GetInternetReachability.isReachableViaWiFi;
end;

initialization
{$IFDEF CPUARM}
  if False then
    FakeLoader;
{$ENDIF}

end.
